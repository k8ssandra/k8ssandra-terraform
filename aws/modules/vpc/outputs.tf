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

# Output attributes for the VPC module
# Output attribute id of the VPC 
output "aws_vpc_id" {
  value = aws_vpc.vpc.id
}
# Output attribute of the VPC cidr block.
output "aws_vpc_cidr" {
  value = aws_vpc.vpc.cidr_block
}

# Output attributes of the public and private subnets
#----------------------------------------------------
output "aws_subnet_public_ids" {
  value = aws_subnet.public_subnet.*.id
}

output "aws_subnet_private_ids" {
  value = aws_subnet.private_subnet.*.id
}

# Output atrributes of the route table ids.
#---------------------------------------------
output "aws_route_table_public_ids" {
  value = aws_route_table.public_route_table.id
}

output "aws_route_table_private_ids" {
  value = aws_route_table.private_route_table.*.id
}

# Output attributes of the NAT gateway
#---------------------------------------
output "aws_nat_gateway_count" {
  value = length(aws_nat_gateway.nat_gateway.*.id)
}

output "aws_nat_gateway_ids" {
  value = aws_nat_gateway.nat_gateway.*.id
}

# Output attribute of the Elastic IP.
#-------------------------------------
output "aws_eip_nat_ips" {
  value = aws_eip.mod_nat_eip.*.public_ip
}

# Output attributes of the Security Groups.
#-----------------------------------------
output "security_group_id" {
  value = aws_security_group.security_group.id
}

output "worker_security_group_id" {
  value = aws_security_group.worker_security_group.id
}
