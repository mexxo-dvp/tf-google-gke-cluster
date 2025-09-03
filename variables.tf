variable "GOOGLE_PROJECT" {
  type        = string
  description = "GCP project ID (e.g., civil-pattern-466501-m8)"
}

# Використовується провайдером; має бути саме РЕГІОН (e.g., europe-west1)
variable "GOOGLE_REGION" {
  type        = string
  description = "GCP region to use (e.g., europe-west1)"
}

# Використовується ресурсом кластера як location:
# Може бути РЕГІОН (кластер регіональний) або ЗОНА (кластер зональний), напр. europe-west1-b
variable "GOOGLE_LOCATION" {
  type        = string
  description = "GKE location (region or zone, e.g., europe-west1 or europe-west1-b)"
}

variable "GKE_MACHINE_TYPE" {
  type        = string
  default     = "g1-small"
  description = "Node machine type"
}

variable "GKE_NUM_NODES" {
  type        = number
  default     = 1
  description = "Node count in custom node pool"
}

variable "GKE_CLUSTER_NAME" {
  type        = string
  default     = "main"
  description = "GKE cluster name"
}

variable "GKE_POOL_NAME" {
  type        = string
  default     = "main"
  description = "GKE node pool name"
}
