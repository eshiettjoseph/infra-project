TF          = terraform
TF_BCKEND_DIR  = terraform/backend
TF_INFRA_DIR  = terraform/infrastructure
TF_ECR_DIR  = terraform/ecr

init_all: init_backend init_ecr init_infra

init_backend: 
	cd $(TF_BCKEND_DIR) && $(TF) init

init_ecr:
	cd $(TF_ECR_DIR) && $(TF) init

init_infra:
	cd $(TF_INFRA_DIR) && (TF) init 

plan_backend:
	cd $(TF_BCKEND_DIR) && $(TF) plan -auto-approve

p