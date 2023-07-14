module "security" {
  source = "./modules/aft-account-request"

  control_tower_parameters = {
    AccountEmail              = "securityservice.in@capgemini.com"
    AccountName               = "security-service"
    ManagedOrganizationalUnit = "Security OU"
    SSOUserEmail              = "securityservice.in@capgemini.com"
    SSOUserFirstName          = "SecurityOU"
    SSOUserLastName           = "Service"
  }

  account_tags = {
    "Learn Tutorial" = "AFT"
  }

  change_management_parameters = {
    change_requested_by = "HashiCorp Learn"
    change_reason       = "Learn AWS Control Tower Account Factory for Terraform Test"
  }

  custom_fields = {
    group = "non-prod"
  }

  account_customizations_name = "security"
}
