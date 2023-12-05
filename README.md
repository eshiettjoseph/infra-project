# Go RESTful API
This repository contains code that sets up a Terraform-managed infrastructure comprising of an ECR, ECS, and RDS pivotal in deploying and managing a Go Restful API. 

# Infrastructure Overview
This project is designed with efficiency and scalability in mind.

- *ECS Cluster:* This the core of the infrastructure handling a service that manages numerous tasks. Each task encompasses a container dedicated to running the Go Restful API.
- *Load Balancer:* Ensures even distribution of incoming requests across tasks, optimizing response times and resource utilization.
- *PostgreSQL Database:* Provides robust data storage for the Go Restful API, ensuring data integrity and quick access.

# How to Deploy Infrastructure
- Initialize backend
    - `make init_backend`
- View backend plan
    - `make plan_backend`
- Deploy backend
    - `make deploy_backend`

> **_Note:_** Ensure uniqueness of the state bucket. If a `bucket already exists` error occurs, modify the bucket value in `main.tf` and and the `provider.tf` in `terraform/backend`, `terraform/ecr` and `terraform/infrastructure` subdirectories.

- Initialize Infrastructure(ECR, ECS, and RDS)
    - `make deploy_all`

## Author
- Joseph Eshiett - [Github](https://github.com/eshiettjoseph)

## Collaborators
- [YOUR NAME HERE] - Feel free to contribute to the codebase by resolving any open issues, refactoring, adding new features, writing test cases or any other way to make the project better and helpful to the community. Feel free to fork and send pull requests.

## Hire me
Looking for a DevOps Engineer to build your next infrastructure? Get in touch: [josepheshiett@gmail.com](mailto:josepheshiett@gmail.com)


## TODO:

- Implement cache layer with Redis
- Implement logging, send logs to AWS cloudwatch
- Github workflow to test code, and deploy infrastructure via terraform

