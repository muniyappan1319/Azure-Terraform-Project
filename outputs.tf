output "resource_group_name" {
  value = azurerm_resource_group.rg.name
}

output "virtual_network_name" {
  value = azurerm_virtual_network.vnet.name
}

output "subnet_name" {
  value = azurerm_subnet.subnet.name
}

output "nsg_name" {
  value = azurerm_network_security_group.nsg.name
}

output "vm_name" {
  value = azurerm_linux_virtual_machine.vm.name
}



output "storage_account_name" {
  value = azurerm_storage_account.storage.name
}

output "public_ip_address" {
  value = azurerm_public_ip.pip.ip_address
}