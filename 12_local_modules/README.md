A networking module that should:
1. Create a VPC with a given CIDR block
2. Allow the user to provide the configuration for multiple subnets:
  2.1 The user should be able to provide CIDR blocks 
  2.2 The user should be able to provide AWS AZ
  2.3 The user should be able to mark a subnet as public or private
    2.3.1 If at least 1 subnet is public, we need to deploy an IGW
    2.3.2 we need to associate the public subnets with a public RTB