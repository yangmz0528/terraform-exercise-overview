# Networking Module

This module manages the creation of VPCs and SUbnets, allowing for the creation of both private and public subnets.

Example usage:
```
module "networking" {
  source = "./modules/networking"
  vpc_config = {
    cidr_block = "10.0.0.0/16"
    name       = "your-vpc"
  }
  subnet_config = {
    subnet_1 = {
      cidr_block = "10.0.0.0/24"
      az         = "ap-southeast-1a"
    }
    subnet_2 = {
      cidr_block = "10.0.1.0/24"
      public     = true
      az         = "ap-southeast-1b"
    }
  }
}
```
