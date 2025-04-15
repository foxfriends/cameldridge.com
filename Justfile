default:
    just --list

# Run update playbook (standard deploy).
[group: "ansible"]
[working-directory: "ansible"]
update:
    ansible-playbook -i inventory.yaml update.yaml -v

# Run setup playbook.
[group: "ansible"]
[working-directory: "ansible"]
setup:
    ansible-playbook -i inventory.yaml setup.yaml -Kv

# Run pre-init playbook.
[group: "ansible"]
[working-directory: "ansible"]
pre-init:
    ansible-playbook -i inventory.yaml pre-init.yaml -Kv

# Terraform init.
[group: "terraform"]
init:
    terraform init

# Deploy via Terraform on the current host.
[group: "terraform"]
deploy: init
    terraform apply -var-file=./vars.tfvars

# Run Terraform plan.
[group: "terraform"]
plan: init
    terraform plan -var-file=./vars.tfvars

# Format code.
[group: "terraform"]
format:
    terraform fmt -recursive

# Check code.
[group: "terraform"]
check: init
    terraform fmt -recursive -check
    terraform validate
