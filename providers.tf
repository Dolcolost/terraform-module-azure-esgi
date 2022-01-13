provider  "azurerm"  {
	client_id = var.client_id
	client_secret = var.client_secret
	tenant_id = var.tenant_id
	subscription_id = var.subscription_id
	features  {}
}
provider  "databricks"  {
	host = azurerm_databricks_workspace.example.workspace_url
	azure_client_id = var.client_id
	azure_client_secret = var.client_secret
	azure_tenant_id = var.tenant_id
}