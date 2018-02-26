provider "google" {
  credentials  = "${file("credentials.json")}"
  project      = "quixotic-galaxy-196119"
  region       = "europe-west1"
}

# Uncomment this for remote state storage
# You'll need to create the bucket first
#terraform {
#  backend "gcs" {
#    bucket = "gocd-bucket-anieva"
#    prefix   = "terraform.tfstate"
#    project = "quixotic-galaxy-196119"
#  }
#}

module "container" {
  source = "../modules/container"
  env = "${var.env}"
	stack = "${var.stack}"
  subnet_range = "${var.subnet_range}"								# The IP range for the kubernetes VMs
  container_cidr_range = "${var.container_cidr_range}"				# The IP range for the containers
  cluster_password = "${var.cluster_password}"  # The password for the kubernetes UI
}
