module "log" {
  source = "./modules/aft-account-request"

  control_tower_parameters = {
    AccountEmail              = "cflogservice2.in@capgemini.com"
    AccountName               = "log-service-acc"
    ManagedOrganizationalUnit = "Infra"
    SSOUserEmail              = "cflogservice2.in@capgemini.com"
    SSOUserFirstName          = "Log"
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

  account_customizations_name = "log"
}
