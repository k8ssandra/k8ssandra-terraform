resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr_block
  instance_tenancy     = var.vpc_instance_tenancy
  enable_dns_support   = var.vpc_enable_dns_support
  enable_dns_hostnames = var.vpc_enable_dns_hostnames
  enable_classiclink   = var.vpc_enable_classiclink

  tags = merge(var.tags, {
    "Name" = format("%s-vpc-network", var.name)
    }
  )
  lifecycle {
    ignore_changes = [tags]
  }
}


resource "aws_subnet" "public_subnet" {
  count             = local.pub_az_count
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.public_cidr_block[count.index]
  availability_zone = local.pub_avilability_zones[count.index]

  tags = merge(var.tags, {
    Name = format("public_avilability_zone-%s", local.pub_avilability_zones[count.index])
    }
  )
}

resource "aws_route_table_association" "public_route_table_association" {
  count          = local.pub_az_count
  subnet_id      = element(aws_subnet.public_subnet.*.id, count.index)
  route_table_id = aws_route_table.public_route_table.id
}


resource "aws_subnet" "private_subnet" {
  count             = local.pri_az_count
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.private_cidr_block[count.index]
  availability_zone = local.pri_avilability_zones[count.index]

  tags = merge(var.tags, {
    Name = format("private_avilability_zone-%s", local.pri_avilability_zones[count.index])
    }
  )
}


resource "aws_route_table_association" "private_route_table_association" {
  count          = local.pri_az_count
  subnet_id      = element(aws_subnet.private_subnet.*.id, count.index)
  route_table_id = element(aws_route_table.private_route_table.*.id, count.index)
}

#-------------------------------------------------------------------------------
# Routing table for public subnets
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.vpc.id
  tags = merge(
    var.tags,
    {
      "Name" = "public_route_table"
    }
  )
}


resource "aws_route" "internet_gateway_route" {
  route_table_id         = aws_route_table.public_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.internet_gateway.id
}

# Routing table for private subnets
resource "aws_route_table" "private_route_table" {
  count  = var.multi_az_nat_gateway * local.pri_az_count + var.single_nat_gateway * 1
  vpc_id = aws_vpc.vpc.id
  tags = merge(
    var.tags,
    {
      az_name = format("private_route_table_az-%s", local.pri_avilability_zones[count.index])
    }
  )
}


resource "aws_route" "private_nat_gateway_route" {
  count                  = var.multi_az_nat_gateway * local.pri_az_count + var.single_nat_gateway * 1
  route_table_id         = element(aws_route_table.private_route_table.*.id, count.index)
  nat_gateway_id         = element(aws_nat_gateway.nat_gateway.*.id, count.index)
  destination_cidr_block = "0.0.0.0/0"
  depends_on = [
    aws_route_table.private_route_table,
    aws_nat_gateway.nat_gateway,
  ]
}

#--------------------------------------------------------------------

resource "aws_nat_gateway" "nat_gateway" {
  count         = var.multi_az_nat_gateway * local.pri_az_count + var.single_nat_gateway * 1
  subnet_id     = element(aws_subnet.public_subnet.*.id, count.index)
  allocation_id = element(aws_eip.mod_nat_eip.*.id, count.index)
  tags          = var.tags
  depends_on = [
    aws_internet_gateway.internet_gateway,
    aws_eip.mod_nat_eip,
    aws_subnet.public_subnet,
  ]
  lifecycle {
    ignore_changes = [tags]
  }
}


#-----------------------------------------------------------------------

resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.vpc.id
  tags = merge(
    var.tags,
    {
      "name" = format("%s", aws_vpc.vpc.id)
    }
  )
}

#----------------------------------------------------------------------
resource "aws_eip" "mod_nat_eip" {
  count = var.multi_az_nat_gateway * local.pri_az_count + var.single_nat_gateway * 1
  tags  = var.tags
  vpc   = true
}

#-------------------------------------------------------------------------


data "http" "workstation-external-ip" {
  url = "http://ipv4.icanhazip.com"
}

data "aws_availability_zones" "availability_zones" {
}

resource "aws_security_group" "security_group" {
  name        = format("%s-security-group", var.name)
  description = "Cluster communication with worker nodes"
  vpc_id      = aws_vpc.vpc.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = var.tags
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
  name        = format("%s-worker-security-group", var.name)
  description = "Security group for all nodes in the cluster"
  vpc_id      = aws_vpc.vpc.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = var.tags
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

provider "aws" {
  region = "us-east-1"
}
