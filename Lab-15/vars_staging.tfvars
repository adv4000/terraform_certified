aws_region    = "ca-central-1"
port_list     = ["80", "443", "8443"]
instance_size = "t2.micro"
key_pair      = "CanadaKey"

tags = {
  Owner       = "Denis Astahov"
  Environment = "Staging"
  Project     = "Phoenix"
  Code        = "445555"
}
