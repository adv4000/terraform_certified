
resource "aws_eip" "prod-ip1" { domain = "vpc" } # Need to be added in new versions of AWS Provider
resource "aws_eip" "prod-ip2" { domain = "vpc" } # Need to be added in new versions of AWS Provider
