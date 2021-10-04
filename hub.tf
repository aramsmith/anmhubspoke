#######################################################################
## Create HUB
## 1 - Create Virtual Network
## 2 - Create subnets
## 3 - Create Bastion (only HUB)
## 4 - deploy VM omn subnet Infra
#######################################################################

## 1 ##
resource "azurerm_virtual_network" "hub-vnet" {
  name                = var.hubvnet_name
  location            = var.location1
  resource_group_name = azurerm_resource_group.anmhubspoke.name
  address_space       = var.hubvnet
  
   tags = {
    environment = var.project
    deployment  = var.hubvnet_name
    location = var.location1
   }
}

##2##
resource "azurerm_subnet" "hubvnet-subnet" {
  name                 = var.hubvnet_subnetname
  resource_group_name  = azurerm_resource_group.anmhubspoke.name
  virtual_network_name = azurerm_virtual_network.hub-vnet.name
  address_prefixes     = var.hubvnet_subnet
}
resource "azurerm_subnet" "bastion-subnet" {
  name                 = "AzureBastionSubnet"
  resource_group_name  = azurerm_resource_group.anmhubspoke.name
  virtual_network_name = azurerm_virtual_network.hub-vnet.name
  address_prefixes     = var.bastion_subnet
}

##3##
resource "azurerm_public_ip" "bastion-pip" {
  name                = "bastion-pip"
  location            = var.location1
  resource_group_name = azurerm_resource_group.anmhubspoke.name
  allocation_method   = "Static"
  sku                 = "Standard"
}
resource "azurerm_bastion_host" "bastion-host" {
  name                = var.bastion_name
  location            = var.location1
  resource_group_name = azurerm_resource_group.anmhubspoke.name

  ip_configuration {
    name                 = "bastion-host"
    subnet_id            = azurerm_subnet.bastion-subnet.id
    public_ip_address_id = azurerm_public_ip.bastion-pip.id
  }
}

##4##
##NIC##
resource "azurerm_network_interface" "vm1nic" {
  name                 = "${var.vm1name}-nic"
  location             = var.location1
  resource_group_name  = azurerm_resource_group.anmhubspoke.name
  
  ip_configuration {
    name                          = "${var.vm1name}-nic-ip"
    subnet_id                     = azurerm_subnet.hubvnet-subnet.id
    private_ip_address_allocation = "Dynamic"
    }
}

##VM##
resource "azurerm_virtual_machine" "HubVM1" {
  name                  = var.vm1name
  resource_group_name = var.resource_group_name
  location              = var.location1
  network_interface_ids = [azurerm_network_interface.vm1nic.id]
  vm_size               = var.vmsize
 
   storage_image_reference {
    offer     = "WindowsServer"
    publisher = "MicrosoftWindowsServer"
    sku       = "2019-Datacenter"
    version   = "latest"
  }

  storage_os_disk {
    name              = "${var.vm1name}-osdisk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  os_profile {
    computer_name  = var.vm1name
    admin_username = var.admin_username
    admin_password = var.admin_password
  }

  os_profile_windows_config {
    provision_vm_agent = true
  }
}