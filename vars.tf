variable "project_id" {
  description = "GCP project id"
  type = string
}

variable "gcp_region" {
  description = "Name of the GCP region e.g. europe-west1"
  type = string
}

variable "gcp_zone" {
  description = "Name of the GCP zone e.g. europe-west1-b"
  type = string
}

variable "gcp_credentials_filename" {
  description = "Path and filename of file containing GCP credentials"
  type = string
  default = null
}

variable "gke_cluster_name" {
  description = "Name of the GKE cluster e.g. gke1"
  type = string
}

variable "gke_location" {
  description = "Name of the GKE location e.g. europe-west1"
  type = string
}

variable "kafka_parameters" {
  description = "Kafka parameters including bootstrap broker addresses."
  type = object({
    bootstrap_brokers = list(string)
  })
}
