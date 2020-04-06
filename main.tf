variable "project" {
  type = string
}

variable "zone" {
  type = string
  default = "us-central1-a"
}

variable "cluster" {
  type = string
}

variable "machine_type" {
  type = string
  default = "n1-standard-1"
}

variable "node_count" {
  type = number
  default = 1
}

provider "google" {
  credentials = file(".cred/terraform.json")
  project = var.project
  zone = var.zone
}

resource "google_container_cluster" "primary" {
  name = var.cluster
  location = var.zone

  initial_node_count = var.node_count

  master_auth {
    username = ""
    password = ""

    client_certificate_config {
      issue_client_certificate = false
    }
  }

  node_config {
    machine_type = var.machine_type

    metadata = {
      disable-legacy-endpoints = "true"
    }

    oauth_scopes = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]
  }

  timeouts {
    create = "10m"
    update = "10m"
  }
}