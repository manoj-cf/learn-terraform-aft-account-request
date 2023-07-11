module "master" {
  source = "./modules/aft-account-request"

  control_tower_parameters = {
    AccountEmail              = "cfmaster.in@capgemini.com"
    AccountName               = "cf-master"
    ManagedOrganizationalUnit = "Management"
    SSOUserEmail              = "cfmaster.in@capgemini.com"
    SSOUserFirstName          = "CF-Master"
    SSOUserLastName           = "Account"
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

  account_customizations_name = "master"
}
