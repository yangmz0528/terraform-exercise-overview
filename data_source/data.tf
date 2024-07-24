# AMI
data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Owner is Canonical
  provider    = aws.ap-southeast

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-*-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

# IAM Policy document
data "aws_iam_policy_document" "static_website" {
  statement {
    sid = "PublicReadGetObject"

    principals {
      type        = "*"
      identifiers = ["*"]
    }

    actions = ["s3:GetObject"]

  }
}

# VPC (vpc that is managed on the console, not created by terraform)
data "aws_vpc" "prod_vpc" {
  tags = {
    Env = "prod"
  }
}

# AWS Account Information and Region
data "aws_caller_identity" "current" {}

# AWS region
data "aws_region" "current" {
  # input provider = provider_alias if want to reference to other region
}

# AWS availability zones
data "aws_availability_zones" "available" {
  state = "available"
}