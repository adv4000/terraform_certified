#----------------------------------------------------------
#  Terraform - From Zero to Certified Professional
#
# Deploy in Multiply AWS Accounts and Regions
#
# Made by Denis Astahov
#----------------------------------------------------------
provider "aws" {
  region = "ca-central-1"
}

provider "aws" {
  region = "us-west-2"
  alias  = "DEV"

  assume_role {
    role_arn = "arn:aws:iam::639130796919:role/TerraformRole"
  }
}

provider "aws" {
  region = "ca-central-1"
  alias  = "PROD"

  assume_role {
    role_arn = "arn:aws:iam::032823347814:role/TerraformRole"
  }
}

#============================================================================

resource "aws_vpc" "master_vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "Master VPC"
  }
}

resource "aws_vpc" "dev_vpc" {
  provider   = aws.DEV
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "Dev VPC"
  }
}

resource "aws_vpc" "prod_vpc" {
  provider   = aws.PROD
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "Prod VPC"
  }
}
