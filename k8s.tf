resource "azurerm_resource_group" "k8s" {
  name     = "k8s-rg"
  location = var.location
}

resource "azurerm_kubernetes_cluster" "k8s" {
  name                      = "k8s-aks"
  resource_group_name       = azurerm_resource_group.k8s.name
  location                  = var.location
  automatic_channel_upgrade = "stable"

  dns_prefix = "bruce-test"

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_B2ms"
  }

  identity {
    type = "SystemAssigned"
  }
}

# cert-manager

resource "kubernetes_namespace" "cert_manager" {
  metadata {
    name = "cert-manager"
  }
}

resource "helm_release" "cert_manager" {
  name       = "cert-manager"
  repository = "https://charts.jetstack.io"
  chart      = "cert-manager"
  version    = var.cert_manager_helm_chart_version
  namespace  = kubernetes_namespace.cert_manager.metadata.0.name

  set {
    name  = "installCRDs"
    value = "true"
  }
}

