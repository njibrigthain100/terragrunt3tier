
terraform {
    source = "../../terraform-modules"
    #git::git@github.com:njibrigthain100/terragrunt-modules.git
    
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
    build_environment = "trn"
    aws_region = "us-east-1"
    state_bucket = "distributorbk"
    dynamoDB_table = "Terraform"
    // iam_role = "arn:aws:iam::485147667400:role/github_actions_role"
   
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
       cidr_block = include.env.locals.resource_vpc_cidr
       region_name = local.aws_region
       private_subnets_cidr = include.env.locals.resource_private_subnet_cidr
       public_subnets_cidr = include.env.locals.resource_public_subnet_cidr
       private_az = include.env.locals.resource_private_az
       public_az = include.env.locals.resource_public_az
       keyname = include.env.locals.resource_keyname
       iam_instance_profile = include.env.locals.resource_iam_instance_profile
       bastion-instance-type = include.env.locals.resource_bastion_instance_type
       instance_server_type = include.env.locals.resource_instance_server_type
       appserver-names = include.env.locals.resource_appserver_names
       webserver-name-dotnet = "${include.env.locals.resource_webserver_dotnet_name}-${local.build_environment}"
       webserver-name-cobsine = "${include.env.locals.resource_webserver_cobsine_name}-${local.build_environment}"
       dbserver-names = include.env.locals.resource_dbserver_names
       load-balancer-name = "${include.env.locals.resource_loadbalancer_name}-${local.build_environment}"
       cobsine-target_group_name = include.env.locals.resource_cobsine_target_group_name
       dotnet-target_group_name = include.env.locals.resource_dotnet_target_group_name
       windows_volume_type = include.env.locals.resource_windows_ebs_type
       windows_volume_size = include.env.locals.resource_window_volume_size
       parent_zone_id = include.env.locals.resource_zone_id
       sql_instance_type = include.env.locals.resource_sql_instance_type
       health_check = include.env.locals.resource_tg_health_check
       webserver-security_group_rules = include.env.locals.resource_webserver_sg_rules
       ssh-bastion-security_group_rules = include.env.locals.resource_ssh_bastion_sg_rules
       rdp-bastion-security_group_rules = include.env.locals.resource_rdp_bastion_sg_rules
       appserver-security_group_rules = include.env.locals.resource_appserver_sg_rules
       appserver-ssh-bastion-security_group_rules = include.env.locals.resource_appserver_ssh_bastion_sg_rules
       appserver-rdp-bastion-security_group_rules = include.env.locals.resource_appserver_rdp_bastion_sg_rules
       db-security_group_rules = include.env.locals.resource_db_sg_rules
       lb-security_group_rules = include.env.locals.resource_lb_sg_rules
       lb-vpc-security_group_rules = include.env.locals.resource_lb_vpc_sg_rules

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
        profile = include.env.locals.resource_profile 
        // role_arn = "${local.iam_role}"
    }
}
generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite"
  contents  = <<EOF
provider "aws" {
  region   = "${local.aws_region}"
}
EOF
}


