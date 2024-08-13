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

resource "aws_instance" "web" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type
  subnet_id     = aws_subnet.this.id

  lifecycle {
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
