resource "aws_eks_cluster" "eks_cluster" {
  name     = format("%s-eks-cluster", var.name)
  role_arn = var.role_arn
  region   = var.region
  vpc_config {
    security_group_ids = var.security_group_id
    subnet_ids         = var.subnet_ids // from the vpc module
  }

  tags = {
    "Name"        = var.name
    "Environment" = var.environment
  }

}

# This data block will get the current caller identity(account_id)
data "aws_caller_identity" "current" {}

data "aws_ami" "worker_ami" {
  filter {
    name   = "name"
    values = ["amazon-eks-node-${aws_eks_cluster.eks_cluster.version}-v*"]
  }

  most_recent = true
  owners      = [data.aws_caller_identity.current] # Amazon
}

resource "aws_launch_configuration" "lunch_configuration" {
  associate_public_ip_address = true
  iam_instance_profile        = var.instance_profile_name
  image_id                    = data.aws_ami.worker_ami.id
  instance_type               = "t2.medium"
  name_prefix                 = var.name
  security_groups             = var.security_group_id
  user_data_base64            = base64encode(local.demo-node-userdata)

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "autoscaling_group" {
  desired_capacity     = 2
  launch_configuration = aws_launch_configuration.launch_configuration.id
  max_size             = 5
  min_size             = 2
  name                 = format("%s-autoscaling-group", var.name)

  vpc_zone_identifier = var.public_subnets

  tag {
    key                 = "Name"
    value               = var.name
    propagate_at_launch = true
  }

  tag {
    key                 = "kubernetes.io/cluster/${var.name}"
    value               = "owned"
    propagate_at_launch = true
  }
}
