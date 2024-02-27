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
    resource_vpc_cidr = local.cloud.locals.vpc_cidr[local.account_name_abr]
    resource_private_subnet_cidr = local.cloud.locals.private_subnet_cidr[local.account_name_abr]
    resource_public_subnet_cidr = local.cloud.locals.public_subnet_cidr[local.account_name_abr]
    resource_private_az = local.cloud.locals.private_subnet_az[local.account_name_abr]
    resource_public_az = local.cloud.locals.private_subnet_az[local.account_name_abr]
  ###############Compute variables starts below this line###########################################
    resource_keyname = local.cloud.locals.keyname[local.account_name_abr]
    resource_iam_instance_profile = local.cloud.locals.iam_instance_profile[local.account_name_abr]
    resource_bastion_instance_type = local.cloud.locals.bastion_instance_type[local.account_name_abr]
    resource_instance_server_type = local.cloud.locals.instance_server_type[local.account_name_abr]
    resource_appserver_names = local.cloud.locals.appserver_names[local.account_name_abr]
    resource_webserver_dotnet_name = local.cloud.locals.webserver_dotnet_names[local.account_name_abr]
    resource_webserver_cobsine_name = local.cloud.locals.webserver_cobsine_names[local.account_name_abr]
    resource_dbserver_names = local.cloud.locals.dbserver_names[local.account_name_abr]
    resource_loadbalancer_name = local.cloud.locals.loadbalancer_names[local.account_name_abr]
    resource_cobsine_target_group_name = local.cloud.locals.cobsine_target_group_name[local.account_name_abr]
    resource_dotnet_target_group_name = local.cloud.locals.dotnet_target_group_name[local.account_name_abr]
    resource_windows_ebs_type = local.cloud.locals.windows_volume_type[local.account_name_abr]
    resource_window_volume_size = local.cloud.locals.windows_volume_size[local.account_name_abr]
    resource_zone_id = local.cloud.locals.parent_zone_id[local.account_name_abr]
    resource_tg_health_check = local.cloud.locals.health_check
    resource_sql_instance_type = local.cloud.locals.sql_instance_type[local.account_name_abr]
    resource_webserver_sg_rules = local.cloud.locals.webserver_security_group_rules[local.account_name_abr]
    resource_ssh_bastion_sg_rules = local.cloud.locals.ssh_bastion_security_group_rules[local.account_name_abr]
    resource_rdp_bastion_sg_rules = local.cloud.locals.rdp_bastion_security_group_rules[local.account_name_abr]
    resource_appserver_sg_rules = local.cloud.locals.appserver_security_group_rules[local.account_name_abr]
    resource_appserver_ssh_bastion_sg_rules = local.cloud.locals.appserver_ssh_bastion_security_group_rules[local.account_name_abr]
    resource_appserver_rdp_bastion_sg_rules = local.cloud.locals.appserver_rdp_bastion_security_group_rules[local.account_name_abr]
    resource_db_sg_rules = local.cloud.locals.db_security_group_rules[local.account_name_abr]
    resource_lb_sg_rules = local.cloud.locals.lb_security_group_rules[local.account_name_abr]
    resource_lb_vpc_sg_rules = local.cloud.locals.lb_vpc_security_group_rules[local.account_name_abr]
    resource_account_map = local.company.locals.aws_account_map[local.account_name_abr]
}


