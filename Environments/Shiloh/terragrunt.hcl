
terraform {
    source = "git::git@github.com:njibrigthain100/terragrunt-modules.git"
    
}
include "root" {
    path = find_in_parent_folders()
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

locals  {
    build_environment = "sit"
    aws_region = "us-east-1"
    state_bucket = "distributorbk"
    dynamoDB_table = "Terraform"
   
}

inputs = {
       Service = include.env.locals.resource_service
       Owner   = include.env.locals.resource_owner
       Environment = include.env.locals.resource_environment
       Tier        = include.env.locals.resource_Tier
       Build-Method = include.env.locals.resource_build_method
       CostCenter   = include.env.locals.resource_costcenter
       Compliance   = include.env.locals.resource_compliance
       instance-profile = include.env.locals.resource_profile 
}

remote_state {
    backend = "s3"
    generate = {
    path = "s3-backend.tf"
    if_exists = "overwrite_terragrunt"
 }
 config = {
        bucket = local.state_bucket
        key   =  "${local.build_environment}/terraform.tfstate"
        dynamodb_table = local.dynamoDB_table
        region = local.aws_region
        encrypt = true
        profile = "shilohIT"
    }
}


