# Hosting a Static Website in S3, Using Terraform

## Setup backend state management
### State Bucket
---
You will need to create a `terraform.tfvars` file in the `backends/bucket/` directory with the following values:
- region  = "us-east-1"
- profile = "personal"
- account_id = "YOUR AWS ACCOUNT ID"

You can go through the variables in the backends folder and update them to values that suite your project

#### Initialize
`cd backends/bucket && terraform init`

#### Apply
`terraform apply`

---
### State DB
---
#### Initialize
`cd backends && terraform init`

#### Apply
`terraform apply`

---