module "backup" {
  source = "./modules/aft-account-request"

  control_tower_parameters = {
    AccountEmail              = "cfbackupservic.in@capgemini.com"
    AccountName               = "backup-service"
    ManagedOrganizationalUnit = "Infra"
    SSOUserEmail              = "cfbackupservic.in@capgemini.com"
    SSOUserFirstName          = "BAckup"
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

  account_customizations_name = "backup"
}
