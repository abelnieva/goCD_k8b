variable "stack" {
  description = "The name for the stack, used for prefixing"
}

variable "cluster_password" {
  description = "The password for logging into kubernetes ui"
}

variable "env" {
  description = "The name for the env, used for prefixing"
}

##NETWORKING

variable "subnet_range" {
  description = "networking subnet range"
}

variable "container_cidr_range" {
  description = "networking subnet range"
}


variable "subnet_region" {
  description = "subnet_region"
  default = "europe-west1"
}
variable "project" {
  description = "google cloud project id "
}
variable "initial_node_count" {
  description = "initial nodes number"
}
