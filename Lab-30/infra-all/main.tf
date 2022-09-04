#-------------------------------------------------------------------------------
#  Terraform - From Zero to Certified Professional
#
# Manipulation with Remote State, Refactoring Terraform Code
#
# Made by Denis Astahov
#-------------------------------------------------------------------------------
provider "aws" {
  region = "us-west-2"
}

data "aws_availability_zones" "available" {}
data "aws_ami" "latest_amazon_linux" {
  owners      = ["amazon"]
  most_recent = true
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

resource "aws_default_vpc" "default" {} # This need to be added since AWS Provider v4.29+ to get VPC id

resource "aws_eip" "prod-ip1" { vpc = true } # Need to be added in new versions of AWS Provider
resource "aws_eip" "prod-ip2" { vpc = true } # Need to be added in new versions of AWS Provider

resource "aws_eip" "stag-ip1" { vpc = true } # Need to be added in new versions of AWS Provider
resource "aws_eip" "stag-ip2" { vpc = true } # Need to be added in new versions of AWS Provider
resource "aws_eip" "stag-ip3" { vpc = true } # Need to be added in new versions of AWS Provider
