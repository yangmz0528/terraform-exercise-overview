locals {
  allowed_instance_types = ["t2.micro", "t3.micro"]
}

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

resource "aws_instance" "this" {
  count         = 2
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type
  subnet_id     = aws_subnet.this[0].id

  lifecycle {
    create_before_destroy = true # default is `destroy before create`, this will prevent terraform from destroying the instance even though postcondition fails at the apply phase
    precondition {
      condition     = contains(local.allowed_instance_types, var.instance_type)
      error_message = "Var invalid instance type"
    }

    postcondition {
      condition     = contains(local.allowed_instance_types, self.instance_type) # only postcondition can use `self` when referencing the resource itself
      error_message = "Self invalid instance type"
    }
  }

  root_block_device {
    delete_on_termination = true
    volume_size           = 10
    volume_type           = "gp3"
  }
}

check "cost_center_check" {
  assert {
    condition     = can(aws_instance.this.tags.CostCenter != "")
    error_message = "Your AWS Instance does not have a ConstCenter tag."
  }
}

check "high_availability_check" {
  assert {
    condition     = length(toset([for subnet in aws_subnet.this : subnet.availability_zone])) > 1
    error_message = <<-EOT
    You are deploying subnets within the same AZ. Please consider distributing them across AZs for higher availability.
    EOT
  }
}