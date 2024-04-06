# Terraform AWS Infrastructure Deployment

This repository contains Terraform configurations to deploy a basic AWS infrastructure for hosting a MediaWiki application. The infrastructure includes a VPC with public subnets, internet gateway, NAT gateway, EC2 instances running MediaWiki, and associated networking components.

## Table of Contents

1. Prerequisites
2. File Structure
3. Terraform Modules
4. Execution Steps
5. Outputs
6. Cleanup

## Prerequisites

Before getting started, ensure you have the following prerequisites installed on your system:

- Terraform
- AWS CLI configured with appropriate credentials
- Linux-based system for running setup script (`setup.sh`)

## File Structure

- **ec2.tf**: Defines EC2 instances running MediaWiki.
- **outputs.tf**: Defines outputs to retrieve information about deployed resources.
- **provider.tf**: Specifies the AWS provider configuration.
- **sg.tf**: Configures security groups for EC2 instances.
- **user_data.sh**: Bash script executed on EC2 instances for setup.
- **variables.tf**: Declares input variables used in Terraform configurations.
- **vpc.tf**: Defines VPC, subnets, internet gateway, and NAT gateway.
- **main.tf**: Entry point for Terraform configurations. Uses modules for environment setup.
- **modules/**: Directory containing Terraform modules for environment setup.
- **setup.sh**: Bash script for installing Terraform prerequisites.

## Terraform Modules

The `modules/` directory contains modules used for setting up the environment. These modules encapsulate reusable pieces of infrastructure configurations.

## Execution Steps

1. Clone this repository to your local machine.
2. Ensure you have met the prerequisites mentioned above.
3. Run the setup script `setup.sh` on your Linux-based system to install Terraform.
4. Update the variables in `main.tf` or create a `terraform.tfvars` file with your AWS credentials.
5. Execute `terraform init` to initialize the working directory.
6. Execute `terraform plan` to preview the changes.
7. Execute `terraform apply` to deploy the infrastructure.
8. After deployment, access the MediaWiki application using the provided URL.

## Outputs

The Terraform outputs provide useful information about the deployed resources. You can access the output values using `terraform output` command or by referring to the `outputs.tf` file.

## Cleanup

To clean up the resources created by Terraform, execute `terraform destroy` after you're done using them.
