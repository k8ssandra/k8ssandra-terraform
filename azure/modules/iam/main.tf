# Cluster Identity
resource "azuread_application" "application" {
  name = var.name
}

#service principal
resource "azuread_service_principal" "service_principal" {
  application_id = azuread_application.application.application_id
}


#random String 
resource "random_string" "cluster_sp_password" {
  length  = 32
  special = true
  keepers = {
    service_principal = azuread_service_principal.service_principal.id
  }
}

resource "azuread_service_principal_password" "service_principal_password" {
  service_principal_id = azuread_service_principal.service_principal.id
  value                = random_string.cluster_sp_password.result

  # 1 year since creation
  # https://www.terraform.io/docs/configuration/functions/timeadd.html
  end_date = timeadd(timestamp(), "8760h")

  lifecycle {
    ignore_changes = [end_date]
  }
}
