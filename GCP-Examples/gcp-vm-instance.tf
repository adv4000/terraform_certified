#----------------------------------------------------------
# Use Terraform with GCP - Google Cloud Platform
# Simple VM Server
#
# Developed by Denis Astahov
#-----------------------------------------------------------
provider "google" {
  credentials = file("mygcp-creds.json") // export GCLOUD_KEYFILE_JSON="gcp-creds.json"
  project     = "prod-251618"            // export GCLOUD_PROJECT="prod-251618"
  region      = "us-west1"               // export GCLOUD_REGION="us-west1"
  zone        = "us-west1-a"             // export GCLOUD_ZONE="us-west1-a"
}

resource "google_compute_instance" "my_web_server" {
  name         = "my-gcp-server"
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
}
