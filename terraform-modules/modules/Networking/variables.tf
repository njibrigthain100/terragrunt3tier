variable "Environment" {
  type        = string
  description = "The environment to create the resources in"
  default     = "prod"
}

variable "Service" {
  type        = string
  description = "The type of service provided to the client"
  default     = "Network"
}

variable "Owner" {
  type        = string
  description = "The owner of all the resources to be built"
  default     = "Customer-Application-a"

}

variable "Tier" {
  type        = string
  description = "The Tier for the resource created"
  default     = "1"
}

variable "Build-Method" {
  type        = string
  description = "The method used to create the resource"
  default     = "Greenfield"

}

variable "CostCenter" {
  type        = string
  description = "The cost center to be applied to the resources"
  default     = "1.0.0.1"

}

variable "Compliance" {
  type        = string
  description = "The compliance status of the resources"
  default     = "HIPAA"

}

variable "cidr_block" {
  type        = string
  description = "The vpc cidr block to be used"
  default     = "10.2.0.0/16"

}

variable "region_name" {
  type        = string
  description = "The region for resources creation"
  default     = "us-east-1"

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

