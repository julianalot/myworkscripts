project_id = "tal-pre-prod-data-lakehouse"
gcp_region = "europe-west1"
gcp_zone = "europe-west1-b"
gcp_credentials_filename = "/var/secrets/key.json"

gke_cluster_name = "gke1"
gke_location = "europe-west1"

kafka_parameters = {
  bootstrap_brokers = [
    "data-lakehouse-kafka-01:6667",
    "data-lakehouse-kafka-02:6667",
    "data-lakehouse-kafka-03:6667"
  ]
}
