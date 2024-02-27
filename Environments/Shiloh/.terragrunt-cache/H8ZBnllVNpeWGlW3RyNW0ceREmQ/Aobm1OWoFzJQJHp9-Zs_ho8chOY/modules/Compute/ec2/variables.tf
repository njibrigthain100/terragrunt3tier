variable "region_name" {
  type        = string
  description = "The region to deploy all the resources"
}

variable "instance-profile" {
  type        = string
  description = "The instance profile to use for resource deployment"

}

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
  description = "the health default values"
}
variable "parent_zone_id" {
  type = string 
  description = "The id of the hosted zone "
}


variable "sql_instance_type" {
  type = string 
  description = "The instance type for the sql instance"
}

variable "dbserver-names" {
 type = list(string) 
 description = "The names of the dbserver"
}