variable "location" {
  type        = string
  description = "Azure region where resources will be deployed."
}

variable "aks_location" {
  type        = string
  description = "Azure region where AKS will be deployed."
}

# Kubernetes App Versions

variable "cert_manager_helm_chart_version" {
  type        = string
  description = "cert-manager Helm Chart version"
}

