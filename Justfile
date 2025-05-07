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
init project="containers":
    cd {{project}} && terraform init

# Deploy via Terraform on the current host.
[group: "terraform"]
apply project="containers": (init project)
    cd {{project}} && terraform apply -var-file=./vars.tfvars

# Run Terraform plan.
[group: "terraform"]
plan project="containers": (init project)
    cd {{project}} && terraform plan -var-file=./vars.tfvars

# Format code.
[group: "terraform"]
fmt:
    terraform fmt -recursive

# Check code.
[group: "terraform"]
check: init
    terraform fmt -recursive -check
    cd containers && terraform validate
    cd infrastructure && terraform validate
