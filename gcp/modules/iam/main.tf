// Add the service account to the project
resource "google_project_iam_member" "service-account" {
  count   = length(var.service_account_iam_roles)
  project = var.project_id
  role    = element(var.service_account_iam_roles, count.index)
  member  = format("serviceAccount:%s", google_service_account.service_account.email)
}


// Add user-specified roles
resource "google_project_iam_member" "service-account-custom" {
  count   = length(var.service_account_custom_iam_roles)
  project = var.project_id
  role    = element(var.service_account_custom_iam_roles, count.index)
  member  = format("serviceAccount:%s", google_service_account.service_account.email)
}

#google service account
resource "google_service_account" "service_account" {
  account_id   = format("%s-service-account", var.name)
  display_name = "GKE Security Service Account"
  project      = var.project_id
}
