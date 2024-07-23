# AMI
output "ubuntu_ami" {
  value = data.aws_ami.ubuntu
}

# AWS caller identity
output "aws_caller_identity" {
  value = data.aws_caller_identity.current
}

# AWS region
output "aws_region" {
  value = data.aws_region.current
}

# VPC
output "prod_vpc_id" {
  value = data.aws_vpc.prod_vpc.id
}