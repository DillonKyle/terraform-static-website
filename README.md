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
## Setup Website
### HTML Files
---
Store the html files in the src folder. 
You will need a onepager index.html and an error.html

### Infrastructure
---
in the `infractructure/main.tf` file, change the bucket name to youre desired name.

#### Initialize
`cd infratructure && terraform init`

#### Apply
`terraform apply`

---
Your URL will be output in the console once terraform completes