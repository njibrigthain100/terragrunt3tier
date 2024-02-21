
terraform {
    source = "git::git@github.com:njibrigthain100/terraform3tier.git"
    
}

include "company" {
    path = find_in_parent_folders("locals-company.hcl")
    expose = true 
}

include "cloud" {
    path = find_in_parent_folders("locals-cloud.hcl")
    expose = true 
}

include "env" {
    path = find_in_parent_folders("locals-env.hcl")
    expose = true 
}

include "root" {
    path = find_in_parent_folders()
}

locals = {
    build_environment = "sit"
   
}




inputs = {
       Service = include.company.locals.company_service.include.env.account_name_abr
       Owner   = include.company.locals.account_owner.include.env.account_name_abr
       Environment = include.company.locals.aws_account_environment.include.env.account_name_abr
       Tier        = include.cloud.locals.cloud_tier.include.env.account_name_abr
       Build-Method = include.cloud.locals.cloud_build_method.include.env.account_name_abr
       CostCenter   = include.company.locals.company_cost_center.include.env.account_name_abr
       Complaince   = include.company.locals.company_compliance.include.env.account_name_abr
       instance-profile = include.env.locals.cloud_profile.include.env.account_name_abr  
}


generate "backend" {
    path = "s3-backend.tf"
    if_exists = "overwrite_terragrunt"
    contents = <<EOF
terraform {
    backend "s3" {
        bucket = "terragrunt-3tier"
        key   =  "terraform/${local.build_environment}/terraform.tfstate"
        region = "us-east-1"
        encrypt = true
        profile = include.env.locals.cloud_profile.include.env.account_name_abr
    }
}
EOF
}