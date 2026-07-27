############################
# Resource Group
############################

resource "azurerm_resource_group" "rg" {
  name     = "rg-cloudinfra-prod-ci-001"
  location = "Central India"
}

############################
# Virtual Network
############################

resource "azurerm_virtual_network" "vnet" {
  name                = "vnet-cloudinfra-ci-001"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  address_space = ["10.10.0.0/16"]
}

############################
# Subnet
############################

resource "azurerm_subnet" "subnet" {
  name                 = "snet-workload-ci-001"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name

  address_prefixes = ["10.10.1.0/24"]
}

############################
# Network Security Group
############################

resource "azurerm_network_security_group" "nsg" {
  name                = "nsg-workload-ci-001"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  security_rule {
    name                       = "Allow-SSH"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"

    source_port_range          = "*"
    destination_port_range     = "22"

    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

############################
# Public IP
############################

resource "azurerm_public_ip" "pip" {
  name                = "pip-linuxvm-ci-001"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  allocation_method = "Static"
  sku               = "Standard"
}

############################
# Network Interface
############################

resource "azurerm_network_interface" "nic" {
  name                = "nic-linuxvm-ci-001"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.pip.id
  }
}

############################
# NSG Association
############################

resource "azurerm_network_interface_security_group_association" "assoc" {
  network_interface_id      = azurerm_network_interface.nic.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}

############################
# Linux Virtual Machine
############################

resource "azurerm_linux_virtual_machine" "vm" {
  name                = "vm-linux-ci-001"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  size                = "Standard_B2ts_v2"

  admin_username = "azureuser"

  network_interface_ids = [
    azurerm_network_interface.nic.id
  ]

  admin_password                  = "Azure@123456789"
  disable_password_authentication = false

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }
}

############################
# Storage Account
############################

resource "azurerm_storage_account" "storage" {

  name                     = "stcloudinfraci001"

  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location

  account_tier             = "Standard"
  account_replication_type = "LRS"
}