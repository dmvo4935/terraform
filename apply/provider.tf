provider "azurerm" {
  subscription_id = "${var.subscription}"
  client_id       = "${var.appId}"
  client_secret   = "${var.password}"
  tenant_id       = "${var.tenant}"
}
