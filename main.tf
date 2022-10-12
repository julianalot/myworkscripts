terraform {
  required_providers {
    kafka = {
      source = "Mongey/kafka"
      version = "0.4.1"
    }

    google = {
      source = "hashicorp/google"
      version = "~> 3.81.0"   # needed, otherwise google_bigquery_dataset_iam_member not supported
    }
  }

  required_version = ">= 0.13"
}

module "gke_auth" {
  source               = "terraform-google-modules/kubernetes-engine/google//modules/auth"

  project_id           = var.project_id
  cluster_name         = var.gke_cluster_name
  location             = var.gke_location
  use_private_endpoint = true
}
