locals {
  public_subnets = {
    for key, config in var.subnet_config : key => config if config.public
  }
  private_subnets = {
    for key, config in var.subnet_config : key => config if !config.public
  }
}

data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_vpc" "this" {
  cidr_block = var.vpc_config.cidr_block

  tags = {
    Name = var.vpc_config.name
  }
}

resource "aws_subnet" "this" {
  for_each          = var.subnet_config
  vpc_id            = aws_vpc.this.id
  availability_zone = each.value.ez
  cidr_block        = each.value.cidr_block

  tags = {
    Name = each.key # subnet_1, subnet_2 for each
  }

  lifecycle {
    precondition {
      condition     = contains(data.aws_availability_zones.available.names, each.value.az)
      error_message = <<EOT
      The AZ "${each.value.az}" provided for subnet "${each.key}" is invalid.

      The setup AWS region "${data.aws_availability_zones.available.id}" supports the following 
      AZs: [${join(",", data.aws_availability_zones.available.names)}]
      EOT 
    }
  }
}

resource "aws_internet_gateway" "this" {
  count  = length(local.public_subnets) > 0 ? 1 : 0 # condition here is if no. of public subnet specified is greater than 0, then will deploy 1 IGW else none
  vpc_id = aws_vpc.this.id
}

resource "aws_route_table" "public_rtb" {
  count  = length(local.public_subnets) > 0 ? 1 : 0
  vpc_id = aws_vpc.this.id

  route = {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.this[0].id # need to specify index cus of count.
  }
}

resource "aws_route_table_association" "public" {
  for_each = local.public_subnets

  subnet_id      = aws_subnet.this[each.key].id
  route_table_id = aws_route_table.public_rtb[0].id
}
