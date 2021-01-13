#-------------------------------------------------------------------------------
#  Terraform - From Zero to Certified Professional
#
# Provision VPCs using Modules
#
# Made by Denis Astahov
#-------------------------------------------------------------------------------
provider "aws" {
  region = "us-west-1"
}


module "my_vpc_default" {
  source = "../modules/aws_network"
}

module "my_vpc_staging" {
  source               = "../modules/aws_network"
  env                  = "staging"
  vpc_cidr             = "10.100.0.0/16"
  public_subnet_cidrs  = ["10.100.1.0/24", "10.100.2.0/24"]
  private_subnet_cidrs = []
}

module "my_vpc_prod" {
  source               = "../modules/aws_network"
  env                  = "prod"
  vpc_cidr             = "10.200.0.0/16"
  public_subnet_cidrs  = ["10.200.1.0/24", "10.200.2.0/24"]
  private_subnet_cidrs = ["10.200.11.0/24", "10.200.22.0/24"]
  tags = {
    Owner   = "ASTAHOV.NET"
    Code    = "777766"
    Project = "SuperPreject"
  }
}
