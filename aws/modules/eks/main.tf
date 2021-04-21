# Copyright 2021 Datastax LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     https://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Elastic kubernetes Service Cluster configuration
resource "aws_eks_cluster" "eks_cluster" {
  name     = format("%s-eks-cluster", var.name)
  role_arn = var.role_arn

  vpc_config {
    security_group_ids = [var.security_group_id] // from the vpc module
    subnet_ids         = var.subnet_ids          // from the vpc module
  }

  tags = {
    "Name"        = var.name
    "Environment" = var.environment
  }

}

# This data block will get the current caller identity(account_id)
data "aws_caller_identity" "current" {}

# This data block helps to get the latest Ubuntu image id's form AWS.
data "aws_ami" "eks_worker" {
  most_recent = true
  owners      = ["099720109477"] #Cannonical

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-trusty-14.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

# AWS Autoscaling launch configuration for the worker nodes.
resource "aws_launch_configuration" "launch_configuration" {
  associate_public_ip_address = true
  iam_instance_profile        = var.instance_profile_name
  image_id                    = data.aws_ami.eks_worker.id
  instance_type               = var.instance_type
  name_prefix                 = var.name
  security_groups             = [var.security_group_id]
  user_data_base64            = base64encode(local.demo-node-userdata)

  lifecycle {
    create_before_destroy = true
  }
}

# AWS Autoscaling Group configuration.
resource "aws_autoscaling_group" "autoscaling_group" {
  desired_capacity     = var.desired_capacity
  launch_configuration = aws_launch_configuration.launch_configuration.id
  max_size             = var.max_size
  min_size             = var.min_size
  name                 = format("%s-autoscaling-group", var.name)

  vpc_zone_identifier = var.public_subnets

  tag {
    key                 = "Name"
    value               = var.name
    propagate_at_launch = true
  }

  tag {
    key                 = format("kubernetes.io/cluster/%s", var.name)
    value               = "owned"
    propagate_at_launch = true
  }
}
