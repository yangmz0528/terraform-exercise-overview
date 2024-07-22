terraform {
  required_version = "> 1.7.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
  }

  backend "s3" {
    # put the below details in tfbackend for diff env (not reco, should do with CICD)
    bucket = "mingzi-terraform-remote-backend"
    key = "state.tfstate" # path for our state file
    region = "ap-southeast-1"
    #dynamodb_table = "my-dynamodb-table" # S3 remote backend support state locking done via DynamoDB table
  }
}

provider "aws" {
  region = "ap-southeast-1"
}

