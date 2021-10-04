#######################################################################
## Create Spoke 3
## 1 - Create Virtual Network
## 2 - Create subnets
## 3 - deploy VM omn subnet Infra
#######################################################################

## 1 ##
resource "azurerm_virtual_network" "spoke3-vnet" {
  name                = var.vnetspoke3_name
  location            = var.location4
  resource_group_name = azurerm_resource_group.anmhubspoke.name
  address_space       = var.vnetspoke3
  
   tags = {
    environment = var.project
    deployment  = var.vnetspoke3_name
    location = var.location4
   }
}

##2##
resource "azurerm_subnet" "spoke3-subnet" {
  name                 = var.vnetspoke3_subnetname
  resource_group_name  = azurerm_resource_group.anmhubspoke.name
  virtual_network_name = azurerm_virtual_network.spoke3-vnet.name
  address_prefixes     = var.vnetspoke3_subnet
}

##3##
##NIC##
resource "azurerm_network_interface" "vm4nic" {
  name                 = "${var.vm4name}-nic"
  location             = var.location4
  resource_group_name  = azurerm_resource_group.anmhubspoke.name
  
  ip_configuration {
    name                          = "${var.vm4name}-nic-ip"
    subnet_id                     = azurerm_subnet.spoke3-subnet.id
    private_ip_address_allocation = "Dynamic"
    }
}

##VM##
resource "azurerm_virtual_machine" "Spoke3VM1" {
  name                  = var.vm4name
  resource_group_name = var.resource_group_name
  location              = var.location4
  network_interface_ids = [azurerm_network_interface.vm4nic.id]
  vm_size               = var.vmsize
 
   storage_image_reference {
    offer     = "WindowsServer"
    publisher = "MicrosoftWindowsServer"
    sku       = "2019-Datacenter"
    version   = "latest"
  }

  storage_os_disk {
    name              = "${var.vm4name}-osdisk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  os_profile {
    computer_name  = var.vm4name
    admin_username = var.admin_username
    admin_password = var.admin_password
  }

  os_profile_windows_config {
    provision_vm_agent = true
  }
}