module "network" {
  source = "./modules/aft-account-request"

  control_tower_parameters = {
    AccountEmail              = "networkservicacc2.in@capgemini.com"
    AccountName               = "network-service"
    ManagedOrganizationalUnit = "Infra"
    SSOUserEmail              = "networkservicacc2.in@capgemini.com"
    SSOUserFirstName          = "Network"
    SSOUserLastName           = "Service"
  }

  account_tags = {
    "Learn Tutorial" = "AFT"
  }

  change_management_parameters = {
    change_requested_by = "HashiCorp Learn"
    change_reason       = "Learn AWS Control Tower Account Factory for Terraform"
  }

  custom_fields = {
    group = "non-prod"
  }

  account_customizations_name = "network"
}
