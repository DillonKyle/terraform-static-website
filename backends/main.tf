  module "dynamodb_terraform_state" {
    source = "./modules/dynamodb"
    backend_table_name = "tsw-terraform-state-locks"
  }
