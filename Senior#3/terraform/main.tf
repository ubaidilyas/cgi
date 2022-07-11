terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 2.65"
    }
  }
  required_version = ">= 0.14.9"
}

provider "azurerm" {
  features {}

    subscription_id = "2fc0173e-cada-4000-82db-566c79d396db"
}

# Create a resource group
resource "azurerm_resource_group" "rg" {
  name     = "cgirg"
  location = "westeurope"

  tags = {
    author = "Ubaid"
    purpose = "Challenge"
  }
}

resource "azurerm_kubernetes_cluster" "aks" {
  name                = "cgiaks"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = "cgiaks"

  default_node_pool {
    name       = "default"
    node_count = 2
    vm_size    = "Standard_DS2_v2"
  }

  identity {
    type = "SystemAssigned"
  }
  
  tags = {
    author = "Ubaid"
    purpose = "Challenge"
  }
}




# resource "azurerm_linux_virtual_machine" "vm" {
#   name                            = "cgivmlinux"
#   resource_group_name             = azurerm_resource_group.rg.name
#   location                        = azurerm_resource_group.rg.location
#   size                            = "standard_b1ls"
#   admin_username                  = "ubaidilyas"
#   admin_password                  = "Ub@!d!lyas99"
#   disable_password_authentication = false
#   network_interface_ids = [
#     azurerm_network_interface.nic.id,
#   ]

#   os_disk {
#     caching              = "ReadWrite"
#     storage_account_type = "Standard_LRS"
#   }

#   source_image_reference {
#     publisher = "Canonical"
#     offer     = "UbuntuServer"
#     sku       = "16.04-LTS"
#     version   = "latest"
#   }
# }

# resource "azurerm_network_interface" "nic" {
#   name                = "cginic"
#   location            = azurerm_resource_group.rg.location
#   resource_group_name = azurerm_resource_group.rg.name

#   ip_configuration {
#     name                          = "internal"
#     subnet_id                     = azurerm_subnet.sn.id
#     private_ip_address_allocation = "Dynamic"
#   }
# }

# resource "azurerm_subnet" "sn" {
#   name                 = "cgisnet"
#   resource_group_name  = azurerm_resource_group.rg.name
#   virtual_network_name = azurerm_virtual_network.vnet.name
#   address_prefixes     = ["10.0.2.0/24"]
#   service_endpoints    = ["Microsoft.Sql", "Microsoft.Storage"]
# }

# resource "azurerm_virtual_network" "vnet" {
#   name                = "cgivnet"
#   address_space       = ["10.0.0.0/16"]
#   location            = azurerm_resource_group.rg.location
#   resource_group_name = azurerm_resource_group.rg.name
# }


# resource "azurerm_network_security_group" "nsg" {
#   name                = "cginsgroup"
#   location            = azurerm_resource_group.rg.location
#   resource_group_name = azurerm_resource_group.rg.name


#   tags = {
#     author = "Ubaid"
#     purpose = "Challenge"
#   }
# }

# resource "azurerm_network_security_rule" "nsr" {
#   for_each                    = local.nsgrules
#   name                        = each.value.name
#   direction                   = each.value.direction
#   access                      = each.value.access
#   priority                    = each.value.priority
#   protocol                    = each.value.protocol
#   source_port_range           = each.value.source_port_range
#   destination_port_range      = each.value.destination_port_range
#   source_address_prefix       = each.value.source_address_prefix
#   destination_address_prefix  = each.value.destination_address_prefix
#   resource_group_name         = azurerm_resource_group.rg.name
#   network_security_group_name = azurerm_network_security_group.nsg.name
# }
