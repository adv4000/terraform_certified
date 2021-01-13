aws_region    = "ca-central-1"
port_list     = ["80", "443", "8443"]
instance_size = "t3.large"
key_pair      = "CanadaKey"

tags = {
  Owner       = "Denis Astahov"
  Environment = "Prod"
  Project     = "Phoenix"
  Code        = "334455"
}
