#configure the cloud provider

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm" #provider type
      version = "~>3.0.2"           #If exempted, terraform uses the lastest version and this may introduce breaking changes
    }

  }

  required_version = ">=1.1.0"
}

provider "azurerm" {
  features {}
}

#create the resource group---------------------------------------------------------------------------------------------------------------------------------------------------

resource "azurerm_resource_group" "hella" {
  name     = "rg-dev-uks-sprint01"
  location = "uk south"

  tags = {
    department  = "AzTDP"
    environment = "Task dev TDP"
  }
}

#create a virtual network---------------------------------------------------------------------------------------------------------------------------------------------------

resource "azurerm_virtual_network" "hella" {
  name                = "Vnet-dev-uks-sprint01"
  address_space       = ["10.0.0.0/24"]
  location            = "uk south"
  resource_group_name = "rg-dev-uks-sprint01"

  tags = {
    environment = "Virtual Network tf"
  }

}

#create subnets-----------------------------------------------------------------------------------------------------------------------------------------------------------
resource "azurerm_subnet" "tfsubnet" {
  name                 = "default"
  resource_group_name  = "rg-dev-uks-sprint01"
  virtual_network_name = azurerm_virtual_network.hella.name
  address_prefixes     = ["10.0.0.0/26"]
}


resource "azurerm_subnet" "tfsubnet2" {
  name                 = "subnet1"
  resource_group_name  = "rg-dev-uks-sprint01"
  virtual_network_name = azurerm_virtual_network.hella.name
  address_prefixes     = ["10.0.0.64/26"]
}


resource "azurerm_subnet" "tfsubnet3" {
  name                 = "subnet2"
  resource_group_name  = "rg-dev-uks-sprint01"
  virtual_network_name = azurerm_virtual_network.hella.name
  address_prefixes     = ["10.0.0.128/26"]
}


resource "azurerm_subnet" "tfsubnet4" {
  name                 = "subnet3"
  resource_group_name  = "rg-dev-uks-sprint01"
  virtual_network_name = azurerm_virtual_network.hella.name
  address_prefixes     = ["10.0.0.192/26"]
}


#create the Network Security Groups---------------------------------------------------------------------------------------------------------------------------------------------------

resource "azurerm_network_security_group" "nsg" {
  name                = "nsg_dev_sprint1_hella"
  location            = "uk south"
  resource_group_name = "rg-dev-uks-sprint01"
}



resource "azurerm_network_security_group" "nsg2" {
  name                = "nsg2_dev_sprint1_hella"
  location            = "uk south"
  resource_group_name = "rg-dev-uks-sprint01"
}



resource "azurerm_network_security_group" "nsg3" {
  name                = "nsg3_dev_sprint1_hella"
  location            = "uk south"
  resource_group_name = "rg-dev-uks-sprint01"
}



resource "azurerm_network_security_group" "nsg4" {
  name                = "nsg4_dev_sprint1_hella"
  location            = "uk south"
  resource_group_name = "rg-dev-uks-sprint01"
}


#create the NSG rules ----------------------------------------------------------------------------------------------------------------------------------------------------------------

resource "azurerm_network_security_rule" "nsg1" {
  name                        = "nsg_trial_sprint01_hella"
  priority                    = "2045"
  direction                   = "Inbound"
  access                      = "Deny"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = "rg-dev-uks-sprint01"
  network_security_group_name = azurerm_network_security_group.nsg.name
}





resource "azurerm_network_security_rule" "nsg2" {
  name                        = "nsg2_trial_sprint01_hella"
  priority                    = "2045"
  direction                   = "Inbound"
  access                      = "Deny"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = "rg-dev-uks-sprint01"
  network_security_group_name = azurerm_network_security_group.nsg2.name
}


resource "azurerm_network_security_rule" "nsg3" {
  name                        = "nsg2_trial_sprint01_hella"
  priority                    = "2045"
  direction                   = "Inbound"
  access                      = "Deny"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = "rg-dev-uks-sprint01"
  network_security_group_name = azurerm_network_security_group.nsg3.name
}



resource "azurerm_network_security_rule" "nsg4" {
  name                        = "nsg2_trial_sprint01_hella"
  priority                    = "2045"
  direction                   = "Inbound"
  access                      = "Deny"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = "rg-dev-uks-sprint01"
  network_security_group_name = azurerm_network_security_group.nsg4.name
}


#Associating the NSGs to the subnet

resource "azurerm_subnet_network_security_group_association" "nsgdefault" {
  subnet_id = azurerm_subnet.tfsubnet.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}


resource "azurerm_subnet_network_security_group_association" "nsgsubnet1" {
  subnet_id = azurerm_subnet.tfsubnet2.id
  network_security_group_id = azurerm_network_security_group.nsg2.id
}

resource "azurerm_subnet_network_security_group_association" "nsgsubnet2" {
  subnet_id = azurerm_subnet.tfsubnet3.id
  network_security_group_id = azurerm_network_security_group.nsg3.id
}

resource "azurerm_subnet_network_security_group_association" "nsgsubnet3" {
  subnet_id = azurerm_subnet.tfsubnet4.id
  network_security_group_id = azurerm_network_security_group.nsg4.id
}