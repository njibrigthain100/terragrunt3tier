#####################Networking outputs############################
output "vpc-id" {
  value = [module.vpc-module.customer-vpc-id]
}

output "private-subnet-ids" {
  value = [module.vpc-module.customer-private-subnets-id]
}

output "public-subnets-id" {
  value = [module.vpc-module.customer-public-subnets-id]
}

output "nat-gw-id" {
  value = [module.vpc-module.customer-nat-gw-id]
}

output "igw-id" {
  value = [module.vpc-module.customer-igw-id]
}

##########################Instance & security group variables###################
output "customer-webserver-security-group-id" {
  value = [module.security-group-module.customer-webserver-security-group]
}

output "customer-appserver-security-group-id" {
  value = [module.security-group-module.customer-appserver-security-group]
}

output "customer-shh-bastion-security-group-id" {
  value = [module.security-group-module.customer-ssh-security-group]
}

output "customer-RDP-bastion-security-group-id" {
  value = [module.security-group-module.customer-rdp-security-group]
}
