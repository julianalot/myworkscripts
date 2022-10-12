provider "google" {
  credentials = file(var.gcp_credentials_filename)
  project = var.project_id
  region = var.gcp_region
  zone = var.gcp_zone
}

provider "kafka" {
  bootstrap_servers = var.kafka_parameters.bootstrap_brokers
  skip_tls_verify = true
  tls_enabled = false
}

provider "kubernetes" {
  host = module.gke_auth.host
  cluster_ca_certificate = module.gke_auth.cluster_ca_certificate
  token = module.gke_auth.token
}
