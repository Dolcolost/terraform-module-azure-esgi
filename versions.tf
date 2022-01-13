terraform  {
	required_providers  {
		azurerm = {
			source = "hashicorp/azurerm"
			version = "=2.46.0"
	}
		databricks = {
			source = "databrickslabs/databricks"
			version = "0.4.4"
		}
	}
}