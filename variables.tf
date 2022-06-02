#######################
#   Project 
#######################
variable "project" {
  description = "Please provide project name for reference"
  default = "DemoHubSpoke"
}

#######################
# RG name
#######################
variable "resource_group_name" {
  description = "Please provide Resource Group name"
  default     = "DemoHuBSpoke"
}

#######################
#Locations
#######################
variable "location1" {
  description = "Location to deploy resources"
  default     = "westus2"
}

variable "location2" {
  description = "Location to deploy resources"
  default     = "northcentralus"
}

variable "location3" {
  description = "Location to deploy resources"
  default     = "westcentralus"
}

variable "location4" {
  description = "Location to deploy resources"
  default     = "eastus"
}
#######################
# Networking vars
#######################

##HUB-VNet20#
variable "hubvnet" {
    description = "Provide Hub vnet "
    default     = ["10.20.0.0/16",]
    }

variable "hubvnet_name" {
  description = "Provide Hub Vnet name"
  default = "HUB-VNet20"
}

variable "hubvnet_subnet" {
    description = "Provide HUB VM Subnet "
    default     = ["10.20.0.0/24",]
   }

variable "hubvnet_subnetname" {
  description = "Provide HUB Vnet20 subnet name"
  default = "Infra-Vnet20"
}

variable "bastion_subnet" {
    description = "Provide Bastion Subnet "
    default     = ["10.20.1.0/27",]
}
variable "bastion_name" {
  description = "Provide Bastion name"
  default = "HUB-Bastion"
}

##Spoke1-VNet21##
variable "vnetspoke1" {
    description = "Provide vnet Spoke 1"
    default     = ["10.21.0.0/16",]
    }

variable "vnetspoke1_name" {
  description = "Provide Spoke 1 name"
  default = "Spoke1-Vnet21"
}

variable "vnetspoke1_subnet" {
    description = "Provide Spoke 1 VM Subnet "
    default     = ["10.21.0.0/24",]
   }

variable "vnetspoke1_subnetname" {
  description = "Provide spoke1 subnet name"
  default = "Infra-Vnet21"
}
##Spoke2-VNet22##
variable "vnetspoke2" {
    description = "Provide vnet Spoke 2"
    default     = ["10.22.0.0/16",]
    }

variable "vnetspoke2_name" {
  description = "Provide Spoke 2 name"
  default = "Spoke2-Vnet22"
}

variable "vnetspoke2_subnet" {
    description = "Provide Spoke 2 VM Subnet "
    default     = ["10.22.0.0/24",]
   }

variable "vnetspoke2_subnetname" {
  description = "Provide spoke 2 subnet name"
  default = "Infra-Vnet22"
}

##Spoke3-VNet23##
variable "vnetspoke3" {
    description = "Provide vnet Spoke 3"
    default     = ["10.23.0.0/16",]
    }

variable "vnetspoke3_name" {
  description = "Provide Spoke 3 name"
  default = "Spoke3-Vnet23"
}

variable "vnetspoke3_subnet" {
    description = "Provide Spoke 3 VM Subnet "
    default     = ["10.23.0.0/24",]
   }

variable "vnetspoke3_subnetname" {
  description = "Provide spoke 3 subnet name"
  default = "Infra-Vnet23"
}

######################
# VM Vars
######################
variable "admin_username" {
  description = "Please provide admin username"
  default = "AzureAdmin"
}

variable "admin_password" {
  description = "Please provide Password, must adhere to azure password complexity"
  type =  string
}

variable "vm1name" {
  description = "Please provide the machine name for VM 1"
  default = "Hub-VM1"
}

variable "vm2name" {
  description = "Please provide the machine name for VM 2"
  default = "Spoke1-VM1"
}

variable "vm3name" {
  description = "Please provide the machine name for VM 3"
  default = "Spoke2-VM1"
}

variable "vm4name" {
  description = "Please provide the machine name for VM 4"
  default = "Spoke3-VM1"
}

variable "vmsize" {
  description = "Size of the VMs"
  default     = "Standard_D2_v4"
}
