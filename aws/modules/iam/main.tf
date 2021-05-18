# Copyright 2021 DataStax, Inc.
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

# Create AWS iam role for EKS service. 
resource "aws_iam_role" "iam_role" {
  name                  = format("%s-role", var.name)
  force_detach_policies = true
  tags                  = var.tags
  assume_role_policy    = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
  lifecycle {
    create_before_destroy = true
  }
}

# create AWS cluster iam role policy attachment. 
resource "aws_iam_role_policy_attachment" "clusterPolicy_iam_role_policy_attachment" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.iam_role.name
}

# Create AWS service iam role policy attachment. 
resource "aws_iam_role_policy_attachment" "servicePolicy_iam_role_policy_attachment" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
  role       = aws_iam_role.iam_role.name
}

# Create AWS EKSVPCResourceController iam role policy attachment.
resource "aws_iam_role_policy_attachment" "EKSVPCResourceController_iam_role_policy_attachment" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
  role       = aws_iam_role.iam_role.name
}

# If no loadbalancer was ever created in this region, then this following role is necessary
resource "aws_iam_role_policy" "service_linked_iam_role_policy" {
  name   = format("%s-service-linked-role", var.name)
  role   = aws_iam_role.iam_role.name
  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": "iam:CreateServiceLinkedRole",
            "Resource": "arn:aws:iam::*:role/aws-service-role/*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "ec2:DescribeAccountAttributes"
            ],
            "Resource": "*"
        }
    ]
}
EOF

}

# Create AWS worker iam role.
resource "aws_iam_role" "worker_iam_role" {
  name                  = format("%s-worker-role", var.name)
  force_detach_policies = true
  tags                  = var.tags
  assume_role_policy    = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
  lifecycle {
    create_before_destroy = true
  }
}

# Create AWS workernode iam role policy attachment.
resource "aws_iam_role_policy_attachment" "WorkerNode_iam_role_policy_attachment" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.worker_iam_role.name
}

# Create AWS iam role CNI policy attachment.
resource "aws_iam_role_policy_attachment" "CNI_policy_iam_role_policy_attachment" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.worker_iam_role.name
}

# Create AWS EC2Container registry read only iam role policy attachment.
resource "aws_iam_role_policy_attachment" "EC2ContainerRegistryReadOnly_iam_role_policy_attachment" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.worker_iam_role.name
}

# Create AWS Medusa iam role policy attachment to the worker nodes.
resource "aws_iam_role_policy_attachment" "medusa_s3_iam_role_policy_attachment" {
  policy_arn = aws_iam_policy.medusa_s3_iam_policy.arn
  role       = aws_iam_role.worker_iam_role.name
}

# Create AWS iam instance profile group.
resource "aws_iam_instance_profile" "iam_instance_profile" {
  name = format("%s-instance-profile", var.name)
  role = aws_iam_role.worker_iam_role.name

  lifecycle {
    create_before_destroy = true
  }
}

# Create AWS iam policy document to create access to the s3 bucket to store the medusa backups.
resource "aws_iam_policy" "medusa_s3_iam_policy" {
  name = format("%s-medusa-s3-access", var.name)

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = ["s3:*"]
        Effect = "Allow"
        Resource = [
          format("arn:aws:s3:::%s", var.bucket_id),
          format("arn:aws:s3:::%s/*", var.bucket_id)
        ]
      },
    ]
  })
}
