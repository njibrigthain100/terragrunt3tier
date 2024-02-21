locals {
    // company = read_terragrunt_config(find_in_parent_folders("locals-company.hcl"))

    cloud_tier = {
        shiloh = "1"
        qa = "2"
        devops = "0"
    }

    cloud_build_method = {
        shiloh = "greenfiled"
        qa = "terrform"
        devops = "ansible"
    }
}