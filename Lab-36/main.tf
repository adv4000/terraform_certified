#-------------------------------------------------------------------------------
#  Terraform - From Zero to Certified Professional
#
#  Moudule which create resource in Multiply Account/Regions
#
# Made by Denis Astahov
#-------------------------------------------------------------------------------
provider "aws" { // My Root Account
  region = "us-west-2"
}

provider "aws" { // My DEV Account
  region = "us-west-1"
  alias  = "DEV"

  assume_role {
    role_arn = "arn:aws:iam::639130796919:role/TerraformRole"
  }
}

provider "aws" { // My PROD Account
  region = "ca-central-1"
  alias  = "PROD"

  assume_role {
    role_arn = "arn:aws:iam::032823347814:role/TerraformRole"
  }
}
#--------------------------------------------------------------

module "servers" {
  source        = "./module_servers"
  instance_type = "t3.small"
  providers = {
    aws.root = aws
    aws.prod = aws.PROD
    aws.dev  = aws.DEV
  }
}
