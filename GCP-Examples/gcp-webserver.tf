#----------------------------------------------------------
# Use Terraform with GCP - Google Cloud Platform
# Apache WebServer on Ubuntu
#
# Developed by Denis Astahov
#-----------------------------------------------------------
provider "google" {
  credentials = file("mygcp-creds.json") // export GCLOUD_KEYFILE_JSON="gcp-creds.json"
  project     = "prod-251618"            // export GCLOUD_PROJECT="prod-251618"
  region      = "us-west1"               // export GCLOUD_REGION="us-west1"
  zone        = "us-west1-b"             // export GCLOUD_ZONE="us-west1-b"
}

resource "google_project_service" "api" {
  for_each = toset([
    "cloudresourcemanager.googleapis.com",
    "compute.googleapis.com"
  ])
  disable_on_destroy = false
  service            = each.value
}

resource "google_compute_firewall" "web" {
  name          = "web-access"
  network       = "default"
  source_ranges = ["0.0.0.0/0"]
  allow {
    protocol = "tcp"
    ports    = ["80", "443"]
  }
}

resource "google_compute_instance" "my_web_server" {
  name         = "my-gcp-web-server"
  machine_type = "f1-micro"
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9" // Image to use for VM
    }
  }
  network_interface {
    network = "default" // This Enable Private IP Address
    access_config {}    // This Enable Public IP Address
  }
  metadata_startup_script = <<EOF
#!/bin/bash
apt update -y
apt install apache2 -y
echo "<h2>WebServer on GCP Build by Terraform!<h2>"  >  /var/www/html/index.html
systemctl restart apache2
EOF

  depends_on = [google_project_service.api, google_compute_firewall.web]
}
