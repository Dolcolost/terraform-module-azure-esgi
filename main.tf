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

resource "azurerm_storage_account" "esgiblobuwucute" {
  name                     = "esgiblobuwucute"
  resource_group_name = azurerm_resource_group.firstdataproject.name
  location            = azurerm_resource_group.firstdataproject.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  account_kind             = "StorageV2"
}

resource "azurerm_storage_container" "marketing" {
  name                  = "marketing"
  storage_account_name  = azurerm_storage_account.esgiblobuwucute.name
  container_access_type = "private"
}

resource "databricks_secret_scope" "terraform" {
  name                     = "application"
  initial_manage_principal = "users"
}

resource "databricks_secret" "storage_key" {
  key          = "blob_storage_key"
  string_value = azurerm_storage_account.esgiblobuwucute.primary_access_key
  scope        = databricks_secret_scope.terraform.name
}

resource "databricks_mount" "marketing" {
  name = "marketing"
  wasb {
    container_name       = azurerm_storage_container.marketing.name
    storage_account_name = azurerm_storage_account.esgiblobuwucute.name
    auth_type            = "ACCESS_KEY"
    token_secret_scope   = databricks_secret_scope.terraform.name
    token_secret_key     = databricks_secret.storage_key.key
  }
}