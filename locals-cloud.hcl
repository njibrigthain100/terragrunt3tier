locals {
    // company = read_terragrunt_config(find_in_parent_folders("locals-company.hcl"))

    cloud_tier = {
        shiloh = "1"
        qa = "2"
        devops = "0"
    }

    cloud_build_method = {
        shiloh = "terragrunt"
        qa = "terrform"
        devops = "ansible"
    }

#############Infrastructure variables################################
    vpc_cidr = {
        shiloh = "10.2.0.0/16"
        qa = "10.3.0.0/16"
        devops = "10.1.0.0/16"
    }

    private_subnet_cidr = {
        shiloh = ["10.2.126.0/24","10.2.127.0/24" ]
        qa = ["10.3.126.0/24","10.3.127.0/24" ]
        devops = ["10.1.126.0/24","10.1.127.0/24" ]
    }

    public_subnet_cidr = {
        shiloh = ["10.2.254.0/24","10.2.255.0/24" ]
        qa = ["10.3.254.0/24","10.3.255.0/24" ]
        devops = ["10.1.254.0/24","10.1.255.0/24" ]        
    }

    private_subnet_az = {
        shiloh = ["us-east-1a", "us-east-1b"]
        qa = ["us-east-1a", "us-east-1b"]
        devops = ["us-east-1a", "us-east-1b"]
    }
##############Compute variables#######################################
    keyname = {
        shiloh = "windowscomputer"
        qa = "qa-keypair"
        devops = "devops"
    }

    iam_instance_profile = {
        shiloh = "AdminFullAccess"
        qa = "AdminFullAccess"
        devops = "AdminFullAccess"
    }

    bastion_instance_type = {
        shiloh = "t2.micro"
        qa = "t2.micro"
        devops = "t2.micro"
    }

    instance_server_type = {
        shiloh = "t2.medium"
        qa = "t2.medium"
        devops = "t2.medium"
    }

    appserver_names = {
        shiloh = ["Cobsine-A-01", "CobsineA-02"]
        qa = ["Cobsine-A-01", "Cobsine-A-02"]
        devops = ["Cobsine-A-01", "Cobsine-A-02"]
    }

    webserver_dotnet_names = {
        shiloh = "dotnet"
        qa = "dotnet"
        devops = "dotnet"
    }

    webserver_cobsine_names = {
        shiloh = "cobsine"
        qa = "cobsine"
        devops = "cobsine"
    }

    dbserver_names = {
        shiloh = ["Cobsine-DB-01", "Cobsine-DB-02"]
        qa = ["Cobsine-DB-01", "Cobsine-DB-02"]
        devops = ["Cobsine-DB-01", "Cobsine-DB-02"]
    }

    loadbalancer_names = {
        shiloh = "Webserver-alb"
        qa = "Webserver-alb"
        devops = "Webserver-alb"
    }
    cobsine_target_group_name = {
        shiloh = "cobsine-tg"
        qa = "cobsine-tg"
        devops = "cobsine-tg"
    }
    dotnet_target_group_name = {
        shiloh = "dotnet-tg"
        qa = "dotnet-tg"
        devops = "dotnet-tg"
    }

    windows_volume_type = {
        shiloh = "gp3"
        qa = "gp3"
        devops = "gp3"
    }

    windows_volume_size = {
        shiloh = "30"
        qa = "30"
        devops = "30"
    }

    parent_zone_id = {
        shiloh = "Z04398901ECFEVWDFU5O9"
        qa = "TBD"
        devops = "TBD"

    }

    health_check = {
      "timeout"  = "10"
      "interval" = "20"
      "path"     = "/"
      "port"     = "80"
      "unhealthy_threshold" = "2"
      "healthy_threshold" = "3"
    }

    sql_instance_type = {
        shiloh = "m6i.xlarge"
        qa = "m6i.xlarge"
        devops = "m6i.xlarge"
    }

    webserver_security_group_rules = {
        shiloh = [{
            from_port   = 80
            to_port     = 80
            ip_protocol = "tcp"
            description = "HTTP"
            },
            {
            from_port   = 443
            to_port     = 443
            ip_protocol = "tcp"
            description = "HTTPS"

    }]
        qa = [{
            from_port   = 80
            to_port     = 80
            ip_protocol = "tcp"
            description = "HTTP"
            },
            {
            from_port   = 443
            to_port     = 443
            ip_protocol = "tcp"
            description = "HTTPS"

    }]
        devops = [{
            from_port   = 80
            to_port     = 80
            ip_protocol = "tcp"
            description = "HTTP"
            },
            {
            from_port   = 443
            to_port     = 443
            ip_protocol = "tcp"
            description = "HTTPS"

    }]}


    ssh_bastion_security_group_rules = {
        shiloh = [{
            from_port   = 22
            to_port     = 22
            ip_protocol = "tcp"
            cidr_ipv4   = "0.0.0.0/0"
            description = "SSH"
            }]
         qa = [{
            from_port   = 22
            to_port     = 22
            ip_protocol = "tcp"
            cidr_ipv4   = "0.0.0.0/0"
            description = "SSH"
            }]
         devops = [{
            from_port   = 22
            to_port     = 22
            ip_protocol = "tcp"
            cidr_ipv4   = "0.0.0.0/0"
            description = "SSH"
            }]}

    rdp_bastion_security_group_rules = {
        shiloh = [{
            from_port   = 3389
            to_port     = 3389
            ip_protocol = "tcp"
            cidr_ipv4   = "0.0.0.0/0"
            description = "RDP"
            }]
        qa = [{
            from_port   = 3389
            to_port     = 3389
            ip_protocol = "tcp"
            cidr_ipv4   = "0.0.0.0/0"
            description = "RDP"
            }]
        devops = [{
            from_port   = 3389
            to_port     = 3389
            ip_protocol = "tcp"
            cidr_ipv4   = "0.0.0.0/0"
            description = "RDP"
            }]}

    appserver_security_group_rules = {
        shiloh = [{
            from_port   = 80
            to_port     = 80
            ip_protocol = "tcp"
            description = "HTTP"
            },
            {
            from_port   = 443
            to_port     = 443
            ip_protocol = "tcp"
            description = "HTTPS"
         }]
        qa = [{
            from_port   = 80
            to_port     = 80
            ip_protocol = "tcp"
            description = "HTTP"
            },
            {
            from_port   = 443
            to_port     = 443
            ip_protocol = "tcp"
            description = "HTTPS"
        }]
        devops = [{
            from_port   = 80
            to_port     = 80
            ip_protocol = "tcp"
            description = "HTTP"
            },
            {
            from_port   = 443
            to_port     = 443
            ip_protocol = "tcp"
            description = "HTTPS"
        }]}

    appserver_ssh_bastion_security_group_rules = {
        shiloh = [{
            from_port   = 22
            to_port     = 22
            ip_protocol = "tcp"
            description = "HTTP"
            }]
        qa = [{
            from_port   = 22
            to_port     = 22
            ip_protocol = "tcp"
            description = "HTTP"
            }]
        devops = [{
            from_port   = 22
            to_port     = 22
            ip_protocol = "tcp"
            description = "HTTP"
            }]}

    appserver_rdp_bastion_security_group_rules = { 
        shiloh = [{
            from_port   = 3389
            to_port     = 3389
            ip_protocol = "tcp"
            description = "HTTP"
            }]
        qa = [{
            from_port   = 3389
            to_port     = 3389
            ip_protocol = "tcp"
            description = "HTTP"
            }]
        devops = [{
            from_port   = 3389
            to_port     = 3389
            ip_protocol = "tcp"
            description = "HTTP"
            }]}

    db_security_group_rules = {
        shiloh = [{
            from_port   = 5001
            to_port     = 5011
            ip_protocol = "tcp"
            description = "SSH from private subnet 1"
            }]
        qa = [{
            from_port   = 5001
            to_port     = 5011
            ip_protocol = "tcp"
            description = "SSH from private subnet 1"
            }]
        devops = [{
            from_port   = 5001
            to_port     = 5011
            ip_protocol = "tcp"
            description = "SSH from private subnet 1"
            }]}

    lb_security_group_rules = {
        shiloh = [{
            from_port   = 80
            to_port     = 80
            ip_protocol = "tcp"
            cidr_ipv4   = "0.0.0.0/0"
            description = "HTTP from the internet"
            },
            {
            from_port   = 443
            to_port     = 443
            ip_protocol = "tcp"
            cidr_ipv4   = "0.0.0.0/0"
            description = "HTTPS from the internet"
            }]
        qa = [{
            from_port   = 80
            to_port     = 80
            ip_protocol = "tcp"
            cidr_ipv4   = "0.0.0.0/0"
            description = "HTTP from the internet"
            },
            {
            from_port   = 443
            to_port     = 443
            ip_protocol = "tcp"
            cidr_ipv4   = "0.0.0.0/0"
            description = "HTTPS from the internet"
            }]
        devops = [{
            from_port   = 80
            to_port     = 80
            ip_protocol = "tcp"
            cidr_ipv4   = "0.0.0.0/0"
            description = "HTTP from the internet"
            },
            {
            from_port   = 443
            to_port     = 443
            ip_protocol = "tcp"
            cidr_ipv4   = "0.0.0.0/0"
            description = "HTTPS from the internet"
            }]}

    lb_vpc_security_group_rules = {
        shiloh = [{
            from_port   = 80
            to_port     = 80
            ip_protocol = "tcp"
            cidr_ipv4   = "10.2.0.0/16"
            description = "HTTP from the vpc"
            },
            {
            from_port   = 443
            to_port     = 443
            ip_protocol = "tcp"
            cidr_ipv4   = "10.2.0.0/16"
            description = "HTTPS from the vpc"
            }]
        qa = [{
            from_port   = 80
            to_port     = 80
            ip_protocol = "tcp"
            cidr_ipv4   = "10.3.0.0/16"
            description = "HTTP from the vpc"
            },
            {
            from_port   = 443
            to_port     = 443
            ip_protocol = "tcp"
            cidr_ipv4   = "10.3.0.0/16"
            description = "HTTPS from the vpc"
            }]
        devops = [{
            from_port   = 80
            to_port     = 80
            ip_protocol = "tcp"
            cidr_ipv4   = "10.1.0.0/16"
            description = "HTTP from the vpc"
            },
            {
            from_port   = 443
            to_port     = 443
            ip_protocol = "tcp"
            cidr_ipv4   = "10.1.0.0/16"
            description = "HTTPS from the vpc"
            }]}

}