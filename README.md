# Azure Infrastructure Provisioning using Terraform

Automated Azure infrastructure provisioning using Terraform, covering networking, compute and security resources defined as Infrastructure as Code.


---

## Overview

This project uses Terraform to provision Azure infrastructure in a repeatable and consistent way. Instead of creating resources manually in the Azure Portal, the entire environment is defined in code, version controlled, and deployed with a single workflow.

---

## Architecture

```text
Terraform (Azure Provider)
          |
          v
   Resource Group
          |
          v
 Virtual Network + Subnet
          |
          v
 Network Security Group
          |
          v
 Compute Resources (Azure VM)
```

---

## Azure Resources

- Resource Group
- Virtual Network and Subnet
- Network Security Group
- Azure Virtual Machine and related networking components

---

## Project Structure

```text
Azure-Terraform-Project/
├── Images/              # Screenshots and proof of deployment
├── .gitignore           # Excludes state files and sensitive data
├── .terraform.lock.hcl  # Provider version lock file
├── main.tf              # Main resource definitions
├── outputs.tf           # Output values after deployment
├── provider.tf          # Azure provider configuration
└── README.md
```

---

## Prerequisites

- Azure subscription
- [Terraform](https://developer.hashicorp.com/terraform/install) installed
- [Azure CLI](https://learn.microsoft.com/cli/azure/install-azure-cli) installed
- Logged in to Azure using `az login`

---

## Deployment

```powershell
# Login to Azure
az login

# Initialize Terraform and download providers
terraform init

# Format and validate the configuration
terraform fmt
terraform validate

# Preview the changes
terraform plan

# Deploy the infrastructure
terraform apply
```

---

## Outputs

After deployment, Terraform displays the values defined in `outputs.tf`. To view them again:

```powershell
terraform output
```

---

## Screenshots

Deployment screenshots and proof of the provisioned resources are available in the [Images](./Images) folder.

---

## Security

- Terraform state files and sensitive variables are excluded using `.gitignore`
- No credentials, keys or subscription IDs are stored in the repository
- Network access is controlled using a Network Security Group

---

## Troubleshooting

- **Authentication error:** run `az login` again and confirm the correct subscription with `az account show`
- **Provider errors:** run `terraform init -upgrade`
- **Name already exists:** Azure resource names may need to be unique, so change the name in `main.tf`
- **Quota or region issues:** try a different region or VM size

---

## Cleanup

Delete all resources created by this project to avoid charges:

```powershell
terraform destroy
```

---

## Technologies

Terraform, HCL, Microsoft Azure, Azure CLI, Azure Virtual Machines, Virtual Network, Network Security Group

---

## Author

Muniyappan Ayyanar, Azure Cloud Engineer (AZ-104)

LinkedIn: https://linkedin.com/in/muniyappan-a-4937b8201
GitHub: https://github.com/muniyappan1319
