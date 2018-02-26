provider "google" {
  credentials  = "${file("credentials.json")}"
  project      = "${var.project}"
  region       = "${var.subnet_region}"
}



module "container" {
  source = "../modules/container"
  env = "${var.env}"
	stack = "${var.stack}"
  subnet_range = "${var.subnet_range}"								# The IP range for the kubernetes VMs
  container_cidr_range = "${var.container_cidr_range}"				# The IP range for the containers
  cluster_password = "${var.cluster_password}"  # The password for the kubernetes UI
}
