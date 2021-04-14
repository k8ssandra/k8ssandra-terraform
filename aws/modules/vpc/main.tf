module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "2.6.0"

  name = format("%s-vpc-network", var.name)
  cidr = "10.0.0.0/16"

  azs             = slice(data.aws_availability_zones.available.names, 0, 3)
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

  enable_nat_gateway = false
  enable_vpn_gateway = false

  tags = {
    "Name"                              = "${var.name}-eks-node"
    "kubernetes.io/cluster/${var.name}" = "shared"
  }
}

data "http" "workstation-external-ip" {
  url = "http://ipv4.icanhazip.com"
}

data "aws_availability_zones" "availability_zones" {
}

resource "aws_security_group" "security_group" {
  name        = format("%s-security-group")
  description = "Cluster communication with worker nodes"
  vpc_id      = module.vpc.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.name}"
  }
}

resource "aws_security_group_rule" "https_security_group_rule" {
  description              = "Allow pods to communicate with the cluster API Server"
  from_port                = 443
  protocol                 = "tcp"
  security_group_id        = aws_security_group.security_group.id
  source_security_group_id = aws_security_group.worker_security_group.id
  to_port                  = 443
  type                     = "ingress"
}

resource "aws_security_group_rule" "workstation_https_group_rule" {
  cidr_blocks       = [local.workstation-external-cidr]
  description       = "Allow workstation to communicate with the cluster API Server"
  from_port         = 443
  protocol          = "tcp"
  security_group_id = aws_security_group.security_group.id
  to_port           = 443
  type              = "ingress"
}

# workers
resource "aws_security_group" "worker_security_group" {
  name        = format("%s-worker-security-group")
  description = "Security group for all nodes in the cluster"
  vpc_id      = module.vpc.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    "Name"                              = "${var.name}-eks-node"
    "kubernetes.io/cluster/${var.name}" = "owned"
  }
}

resource "aws_security_group_rule" "self_security_group_rule" {
  description              = "Allow node to communicate with each other"
  from_port                = 0
  protocol                 = "-1"
  security_group_id        = aws_security_group.worker_security_group.id
  source_security_group_id = aws_security_group.worker_security_group.id
  to_port                  = 65535
  type                     = "ingress"
}

resource "aws_security_group_rule" "cluster_security_group_rule" {
  description              = "Allow worker Kubelets and pods to receive communication from the cluster control plane"
  from_port                = 1025
  protocol                 = "tcp"
  security_group_id        = aws_security_group.worker_security_group.id
  source_security_group_id = aws_security_group.worker_security_group.id
  to_port                  = 65535
  type                     = "ingress"
}
