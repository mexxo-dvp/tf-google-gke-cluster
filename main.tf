# tf-google-gke-cluster/main.tf

# (provider "google" у модулі видаляємо — провайдер прийде з root)

# GKE кластер (зональний, якщо в location передати зону)
resource "google_container_cluster" "this" {
  name                     = var.GKE_CLUSTER_NAME
  location                 = var.GOOGLE_REGION
  remove_default_node_pool = true
  initial_node_count       = 1
  deletion_protection      = false

  workload_identity_config {
    workload_pool = "${var.GOOGLE_PROJECT}.svc.id.goog"
  }

  node_config {
    workload_metadata_config { mode = "GKE_METADATA" }
  }
}

# Кастомний node pool
resource "google_container_node_pool" "this" {
  name       = var.GKE_POOL_NAME
  project    = google_container_cluster.this.project
  cluster    = google_container_cluster.this.name
  location   = google_container_cluster.this.location
  node_count = var.GKE_NUM_NODES

  node_config {
    machine_type = var.GKE_MACHINE_TYPE
  }
}

# Аутентифікація до кластера
module "gke_auth" {
  depends_on   = [google_container_cluster.this]
  source       = "terraform-google-modules/kubernetes-engine/google//modules/auth"
  version      = ">= 24.0.0"

  project_id   = var.GOOGLE_PROJECT
  cluster_name = google_container_cluster.this.name
  location     = google_container_cluster.this.location
}

# Корисні data-джерела
data "google_client_config" "current" {}

data "google_container_cluster" "main" {
  name     = google_container_cluster.this.name
  location = google_container_cluster.this.location
}
