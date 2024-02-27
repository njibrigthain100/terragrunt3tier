##################################Creating the networks components##############################
module "vpc-module" {
    source = "./Networking"
    Environment          = var.Environment
    Service              = var.Service
    Owner                = var.Owner
    Tier                 = var.Tier
    Build-Method         = var.Build-Method
    CostCenter           = var.CostCenter
    Compliance           = var.Compliance
    cidr_block           = var.cidr_block
    region_name          = var.region_name
    private_subnets_cidr = var.private_subnets_cidr
    public_subnets_cidr  = var.public_subnets_cidr
    private_az           = var.private_az
    public_az            = var.public_az
}

##################################Creating the security group####################################
module "security-group-module" {
    source = "./Compute/ec2/Security_group"
    region_name = var.region_name
    instance-profile = var.instance-profile
    Environment = var.Environment
    Service = var.Service
    Owner = var.Owner
    Tier = var.Tier
    Build-Method = var.Build-Method
    CostCenter = var.CostCenter
    Compliance = var.Compliance
    webserver-security_group_rules = var.webserver-security_group_rules
    ssh-bastion-security_group_rules = var.ssh-bastion-security_group_rules
    rdp-bastion-security_group_rules = var.rdp-bastion-security_group_rules
    appserver-security_group_rules = var.appserver-security_group_rules
    appserver-ssh-bastion-security_group_rules = var.appserver-ssh-bastion-security_group_rules
    appserver-rdp-bastion-security_group_rules = var.appserver-rdp-bastion-security_group_rules
    db-security_group_rules = var.db-security_group_rules
    lb-security_group_rules = var.lb-security_group_rules
    lb-vpc-security_group_rules = var.lb-vpc-security_group_rules
    depends_on = [ module.vpc-module ]
   
}
###########################Creating the Instance###################################################
module "ec2-instances" {
    source = "./Compute/ec2"
    region_name = var.region_name
    instance-profile = var.instance-profile
    Environment = var.Environment
    Service = var.Service
    Owner = var.Owner
    Tier = var.Tier
    Build-Method = var.Build-Method
    CostCenter = var.CostCenter
    Compliance = var.Compliance
    keyname = var.keyname
    sql_instance_type = var.sql_instance_type
    bastion-instance-type = var.bastion-instance-type
    iam_instance_profile = var.iam_instance_profile
    instance_server_type = var.instance_server_type
    appserver-names = var.appserver-names
    windows_volume_size = var.windows_volume_size
    windows_volume_type = var.windows_volume_type 
    webserver-name-cobsine = var.webserver-name-cobsine
    webserver-name-dotnet = var.webserver-name-dotnet
    load-balancer-name = var.load-balancer-name
    cobsine-target_group_name = var.cobsine-target_group_name
    dotnet-target_group_name = var.dotnet-target_group_name
    health_check = var.health_check
    parent_zone_id = var.parent_zone_id
    dbserver-names = var.dbserver-names
    depends_on = [ module.security-group-module ]
}


