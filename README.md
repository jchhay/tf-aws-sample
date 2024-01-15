#tf-aws-sample

## Summary

Sample Terraform project to provide baseline understanding in folder structures, modules, and variables.

## Terraform Architecture

- [ ] Terrform Core: consists of State File, Config, and Provider
    - [ ] State File:    Representation of remote infrastructure
    - [ ] Config:        Infrastructure code
    - [ ] Provider:      Plug-in to interact with Cloud API

## Getting started

- [ ] Here are some basic usage command sequence:

```
# Initializes terraform project by downloading the set providers, and registering modules
terraform init

# Formats configuration code
terraform fmt --recursive

# Checks local configuration code for validity 
terraform validate

# Performs dry run to get a preview of what the changes are
terraform plan

# Applies the changes into the target environment
terraform apply

# Tears down the target environment
terraform destroy

```