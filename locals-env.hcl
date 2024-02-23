locals {
    company = read_terragrunt_config(find_in_parent_folders("locals-company.hcl"))
    cloud   = read_terragrunt_config(find_in_parent_folders("locals-cloud.hcl"))

    # Simple variables
    account_name_abr = "shiloh"
    cloud_profile = {
        shiloh = "shilohIT"
        qa     = "QA"
        devops = "Devops"
    }
    resource_service = local.company.locals.company_service[local.account_name_abr]
    resource_owner = local.company.locals.account_owner[local.account_name_abr]
    resource_environment = local.company.locals.aws_account_environment[local.account_name_abr]
    resource_Tier = local.cloud.locals.cloud_tier[local.account_name_abr]
    resource_build_method = local.cloud.locals.cloud_build_method[local.account_name_abr]
    resource_costcenter = local.company.locals.company_cost_center[local.account_name_abr]
    resource_compliance = local.company.locals.company_compliance[local.account_name_abr]
    resource_profile = local.cloud_profile[local.account_name_abr]
}


