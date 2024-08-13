module "networking" {
  source = "./modules/networking"
  vpc_config = {
    cidr_block = "10.0.0.0/16"
    name       = "12-local-modules"
  }
  subnet_config = {
    subnet_1 = {
    }
    subnet_2 = {
      cidr_block = "10.0.1.0/24"
      # Public subnets are indicated by setting the "public" option to true.
      public = true
      az     = "ap-southeast-1b"
    }
  }
}