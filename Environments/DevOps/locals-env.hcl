locals {
    company = read_terragrunt_config(find_in_parent_folders("locals-company.hcl"))
    cloud   = read_terragrunt_config(find_in_parent_folders("locals-cloud.hcl"))
}
account_name_abr = "Devops"
cloud_profile = {
    shiloh = "shilohIT"
    qa     = "QA"
    devops = "Devops"
}