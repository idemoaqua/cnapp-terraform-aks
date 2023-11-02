resource "azurerm_resource_group" "cnapp_rsg" {
  location = var.resource_group_location
  name     = var.resource_group_name
  tags = {
    yor_trace = "310df0dc-4af4-4446-878f-a0dfc6049cd8"
  }
}

resource "azurerm_kubernetes_cluster" "k8s" {
  location            = azurerm_resource_group.cnapp_rsg.location
  name                = var.kubernetes_cluster_name
  resource_group_name = azurerm_resource_group.cnapp_rsg.name
  dns_prefix          = var.dns_prefix

  identity {
    type = "SystemAssigned"
  }

  default_node_pool {
    name       = "agentpool"
    vm_size    = "Standard_D2_v2"
    node_count = var.node_count
  }
  linux_profile {
    admin_username = var.username

    ssh_key {
      key_data = jsondecode(azapi_resource_action.ssh_public_key_gen.output).publicKey
    }
  }
  network_profile {
    network_plugin    = "kubenet"
    load_balancer_sku = "standard"
  }
  tags = {
    yor_trace = "c56965b6-2a2d-40a0-9dc9-8c7490be11ea"
  }
}
