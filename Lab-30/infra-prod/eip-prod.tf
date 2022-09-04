
resource "aws_eip" "prod-ip1" { vpc = true } # Need to be added in new versions of AWS Provider
resource "aws_eip" "prod-ip2" { vpc = true } # Need to be added in new versions of AWS Provider
