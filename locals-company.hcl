locals {
        aws_account_map = {
            shiloh = "485147667400"
            qa = "271457809232"
            devops = "388927731914"
        }

        aws_account_environment = {
            shiloh = "dev"
            qa = "qa"
            devops = "prod"
        }

        company_cost_center = {
            shiloh = "1.0.0.1"
            qa = "1.0.0.2"
            devops = "1.0.0.3"
        }

        company_compliance = {
            shiloh = "hippa"
            qa = "financial"
            devops = "HR complaince"
        }

        company_service = {
            shiloh = "pharmacy-care"
            qa = "financial regulations"
            devops = "human resources"
        }
        account_owner = {
            shiloh = "Customer-Application-a"
            qa = "Customer-Application-b"
            devops = "Customer-Application-c"
        }
}