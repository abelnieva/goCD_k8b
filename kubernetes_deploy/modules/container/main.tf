module "network" {
  source        = "../cluster-network"
  env           = "${var.env}"
	stack         = "${var.stack}"
  subnet_range  = "${var.subnet_range}"
	subnet_region = "${var.subnet_region}"
}

resource "google_container_cluster" "cluster" {
  depends_on = ["module.network"]
  name = "${var.stack}-${var.env}"
  cluster_ipv4_cidr = "${var.container_cidr_range}"

  master_auth {
    username = "${var.cluster_username}"
    password = "${var.cluster_password}"
  }

  zone = "${var.subnet_region}-c"
  additional_zones = ["${var.subnet_region}-d"]
  network = "${module.network.vpc_name}"
  subnetwork = "${module.network.subnet_name}"
  monitoring_service = "monitoring.googleapis.com"
  logging_service = "logging.googleapis.com"
  initial_node_count = "${var.initial_node_count}"
  node_config {
	  machine_type = "n1-standard-1"
	  disk_size_gb = "100"

    oauth_scopes = [
  	  "https://www.googleapis.com/auth/compute",
  	  "https://www.googleapis.com/auth/devstorage.read_write",
      "https://www.googleapis.com/auth/datastore",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring"
    ]
  }
}
