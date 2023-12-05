TF          = terraform
TF_BCKEND_DIR  = terraform/backend
TF_INFRA_DIR  = terraform/infrastructure
TF_ECR_DIR  = terraform/ecr

# Define the default target
.DEFAULT_GOAL := help

# Targets that do not represent files
.PHONY: help init_all validate_all deploy_all destroy_all init_backend init_ecr init_infra plan_backend plan_ecr plan_infra apply_backend apply_ecr apply_infra destroy_backend destroy_ecr destroy_infra

help:
	@echo "Usage: make [target]"
	@echo ""
	@echo "Targets:"
	@echo "  init_all                               - Initialize all ECR, backend and infrastructure configurations"
	@echo "  validate_all                           - Validate ECR, Terraform backend and infrastructure Terraform configurations"
	@echo "  init_ecr                               - Initialize Terraform for the ECR configuration"
	@echo "  init_backend                           - Initialize Terraform for the backend configuration"
	@echo "  init_infra                             - Initialize Terraform for the infrastructure configuration"
	@echo "  plan_ecr                               - Generate and show an execution plan for the ECR configuration"
	@echo "  plan_backend                           - Generate and show an execution plan for the backend configuration"
	@echo "  plan_infra                             - Generate and show an execution plan for the infrastructure configuration"
	@echo "  apply_backend                          - Apply the changes to the backend configuration"
	@echo "  apply_ecr                              - Apply the changes to the ECR configuration"
	@echo "  apply_infra                            - Apply the changes to the infrastructure configuration"
	@echo "  destroy_infra                          - Destroy the Terraform-managed infrastructure"
	@echo "  destroy_ecr                            - Destroy the Terraform-managed ECR "
	@echo "  destroy_backend                        - Destroy the Terraform-managed S3 backend"
	@echo "  deploy_all                             - Deploy all ECR, backend and infrastructure layers"
	@echo "  destroy_all                            - Destroy all ECR, backend and infrastructure layers"
	@echo "  help                                   - Shows this help message"

init_all: init_backend init_ecr init_infra

deploy_all: apply_ecr apply_infra

destroy_all: destroy_ecr destroy_infra

init_backend: 
	cd $(TF_BCKEND_DIR) && $(TF) init

init_ecr:
	cd $(TF_ECR_DIR) && $(TF) init

init_infra:
	cd $(TF_INFRA_DIR) && $(TF) init 

plan_backend:
	cd $(TF_BCKEND_DIR) && $(TF) plan -input=false

plan_ecr:
	cd $(TF_ECR_DIR) && $(TF) plan -input=false

plan_infra:
	cd $(TF_INFRA_DIR) && $(TF) plan -input=false

apply_ecr:
	cd $(TF_ECR_DIR) && $(TF) apply -auto-approve

apply_backend:
	cd $(TF_BCKEND_DIR) && $(TF) apply -auto-approve

apply_infra:
	cd $(TF_INFRA_DIR) && $(TF) apply -auto-approve

destroy_ecr:
	cd $(TF_ECR_DIR) && $(TF) destroy -auto-approve

destroy_backend:
	cd $(TF_BCKEND_DIR) && $(TF) destroy -auto-approve

destroy_infra:
	cd $(TF_INFRA_DIR) && $(TF) destroy -auto-approve