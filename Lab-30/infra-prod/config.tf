terraform {
  backend "s3" {
    bucket = "adv-it-terraform-remote-state" // Bucket where to SAVE Terraform State
    key    = "infra-prod/terraform.tfstate"  // Object name in the bucket to SAVE Terraform State
    region = "us-west-2"                     // Region where bucket is created
  }
}
