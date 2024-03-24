provider "aws" {
  profile = var.profile
  region  = var.region
  
  default_tags {
    tags = {
      created_by = "terraform"
      workspace  = terraform.workspace
    }
  }
}