####################Network variables###################################
variable "Environment" {
  type        = string
  description = "The environment to create the resources in"
}

variable "Service" {
  type        = string
  description = "The type of service provided to the client"
}

variable "Owner" {
  type        = string
  description = "The owner of all the resources to be built"

}

variable "Tier" {
  type        = string
  description = "The Tier for the resource created"
}

variable "Build-Method" {
  type        = string
  description = "The method used to create the resource"

}

variable "CostCenter" {
  type        = string
  description = "The cost center to be applied to the resources"

}

variable "Compliance" {
  type        = string
  description = "The compliance status of the resources"

}

variable "cidr_block" {
  type        = string
  description = "The vpc cidr block to be used"

}

variable "region_name" {
  type        = string
  description = "The region for resources creation"

}

variable "private_subnets_cidr" {
  type        = list(string)
  description = "The cidr range for all the private subnets"
  default     = ["10.2.126.0/24", "10.2.127.0/24"]

}

variable "public_subnets_cidr" {
  type        = list(string)
  description = "The cidr range for all the public subnets"
  default     = ["10.2.254.0/24", "10.2.255.0/24"]

}

variable "private_az" {
  type        = list(string)
  description = "The availability zones on which to create the private sunets"
  default     = ["us-east-1a", "us-east-1b"]
}

variable "public_az" {
  type        = list(string)
  description = "The availability zones on which to create the public sunets"
  default     = ["us-east-1a", "us-east-1b"]
}

###########################Security group and instance variables###################


variable "instance-profile" {
  type        = string
  description = "The instance profile to use for resource deployment"

}

variable "webserver-security_group_rules" {
  description = "All web server security group rules"
  type = list(object({
    from_port   = number
    to_port     = number
    ip_protocol = string
    description = string
  }))
 }

variable "ssh-bastion-security_group_rules" {
  description = "All ssh bastion security group rules"
  type = list(object({
    from_port   = number
    to_port     = number
    ip_protocol = string
    cidr_ipv4   = string
    description = string
  }))
}
variable "rdp-bastion-security_group_rules" {
  description = "All ssh bastion security group rules"
  type = list(object({
    from_port   = number
    to_port     = number
    ip_protocol = string
    cidr_ipv4   = string
    description = string
  }))
}

variable "appserver-security_group_rules" {
  description = "All app server security group rules"
  type = list(object({
    from_port   = number
    to_port     = number
    ip_protocol = string
    description = string
  }))
}

variable "appserver-ssh-bastion-security_group_rules" {
  description = "All app server security group rules from the rdp bastion"
  type = list(object({
    from_port   = number
    to_port     = number
    ip_protocol = string
    description = string
  }))
}

variable "appserver-rdp-bastion-security_group_rules" {
  description = "All app server security group rules from the rdp bastion"
  type = list(object({
    from_port   = number
    to_port     = number
    ip_protocol = string
    description = string
  }))
}

variable "keyname" {
  type = string 
  description = "The key pair to be used during instance build"
}

variable "bastion-instance-type" {
  type = string
  description = "The instance type for the bastion"
}

variable "iam_instance_profile" {
  type = string 
  description = "the iam instance profile to use for resource creation"
}

variable "instance_server_type" {
  type = string 
  description = "The instance type for the app and web servers"
}

variable "appserver-names" {
  type = list(string)
  description = "The names of the app-servers"
}
variable "windows_volume_size" {
  type = string 
  description = "The size of the root volume for windows boxes"
}

variable "windows_volume_type" {
  type = string 
  description = "The volume type"
}
variable "webserver-name-cobsine" {
  type = string
  description = "The names of the web-servers"
}

variable "webserver-name-dotnet" {
  type = string
  description = "The names of the web-servers"
}
variable "load-balancer-name" {
  type = string
  description = "The name of the load balancer"
  default = "customer-public-load-balancer"
}

variable "cobsine-target_group_name" {
  type = string
  description = "The target group for the application load balancer"
}

variable "dotnet-target_group_name" {
  type = string
  description = "The target group for the application load balancer"
}

variable "health_check" {
   type = map(string)
   description = "The health check default values"
}
variable "parent_zone_id" {
  type = string 
  description = "The id of the hosted zone "
}

variable "db-security_group_rules" {
  description = "All db server security group rules"
  type = list(object({
    from_port   = number
    to_port     = number
    ip_protocol = string
    description = string
  }))
}

variable "lb-security_group_rules" {
   description = "All lb security group rules"
  type = list(object({
    from_port   = number
    to_port     = number
    ip_protocol = string
    cidr_ipv4   = string
    description = string
  }))
}

variable "lb-vpc-security_group_rules" {
   description = "All lb security group rules"
  type = list(object({
    from_port   = number
    to_port     = number
    ip_protocol = string
    cidr_ipv4   = string
    description = string
  }))
}
variable "sql_instance_type" {
  type = string 
  description = "The instance type for the sql instance"
}
variable "dbserver-names" {
 type = list(string) 
 description = "The names of the dbserver"
}