resource "azurerm_resource_group" "firstdataproject" {
 name		= "firstdataproject"
 location	= "West Europe"
 }

resource "azurerm_databricks_workspace" "databricks-firstdataproject" {
  name                = "databricks-firstdataproject"
  resource_group_name = azurerm_resource_group.firstdataproject.name
  location            = azurerm_resource_group.firstdataproject.location
  sku                 = "trial"
}

