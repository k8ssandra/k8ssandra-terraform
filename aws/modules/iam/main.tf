# 
resource "aws_iam_role" "iam_role" {
  name = format("%s-role", var.name)

  assume_role_policy = <<POLICY
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

}

resource "aws_iam_role_policy_attachment" "clusterPolicy_iam_role_policy_attachment" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.iam_role.name
}

resource "aws_iam_role_policy_attachment" "servicePolicy_iam_role_policy_attachment" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
  role       = aws_iam_role.iam_role.name
}


# If no loadbalancer was ever created in this region, then this following role is necessary
resource "aws_iam_role_policy" "service_linked_iam_role_policy" {
  name = format("%s-service-linked-role", var.name)
  role = aws_iam_role.iam_role.name

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

resource "aws_iam_role" "worker_iam_role" {
  name = format("%s-worker-role", var.name)

  assume_role_policy = <<POLICY
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

}

resource "aws_iam_role_policy_attachment" "WorkerNode_iam_role_policy_attachment" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.worker_iam_role.name
}

resource "aws_iam_role_policy_attachment" "CNI_policy_iam_role_policy_attachment" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.worker_iam_role.name
}

resource "aws_iam_role_policy_attachment" "EC2ContainerRegistryReadOnly_iam_role_policy_attachment" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.worker_iam_role.name
}

resource "aws_iam_instance_profile" "iam_instance_profile" {
  name = format("%s-instace-profile", var.name)
  role = aws_iam_role.worker_iam_role.name
}
