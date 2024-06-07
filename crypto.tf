resource "random_id" "ssh_key_name" {
  prefix    = "ssh"
  byte_length = 8
}

resource "azapi_resource_action" "ssh_public_key_generator" {
  type        = "Microsoft.Compute/sshPublicKeys@2024-03-01"
  resource_id = azapi_resource.ssh_public_key.id
  action      = "generateKeyPair"
  method      = "POST"

  response_export_values = ["publicKey", "privateKey"]
}

resource "azapi_resource" "ssh_public_key" {
  type      = "Microsoft.Compute/sshPublicKeys@2024-03-01"
  name      = random_id.ssh_key_name.id
  location  = azurerm_resource_group.rg.location
  parent_id = azurerm_resource_group.rg.id
}

output "key_data" {
  value = jsondecode(azapi_resource_action.ssh_public_key_generator.output).publicKey
}