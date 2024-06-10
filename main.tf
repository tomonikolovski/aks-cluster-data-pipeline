# Generate random resource group name
resource "random_id" "rg_name" {
  prefix = var.resource_group_name_prefix
  byte_length = 8
}

resource "azurerm_resource_group" "rg" {
  location = var.resource_group_location
  name     = random_id.rg_name.id
}

resource "random_id" "azurerm_kubernetes_cluster_name" {
  prefix = "cluster"
  byte_length = 8
}

resource "random_id" "azurerm_kubernetes_cluster_dns_prefix" {
  prefix = "dns"
  byte_length = 8
}

resource "azurerm_kubernetes_cluster" "k8s" {
  location            = azurerm_resource_group.rg.location
  name                = random_id.azurerm_kubernetes_cluster_name.id
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = random_id.azurerm_kubernetes_cluster_dns_prefix.id

  identity {
    type = "SystemAssigned"
  }

  default_node_pool {
    name       = "agentpool"
    vm_size    = "Standard_D2as_v4"
    node_count = var.node_count
  }
  linux_profile {
    admin_username = var.username

    ssh_key {
      key_data = azapi_resource_action.ssh_public_key_generator.output.publicKey
    }
  }
  network_profile {
    network_plugin    = "kubenet"
    load_balancer_sku = "standard"
  }
}