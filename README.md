# Secure Cloud-Native DevSecOps Platform

A secure, containerized Product API built with **FastAPI and PostgreSQL**, with a DevSecOps workflow covering automated testing, Docker containerization, Infrastructure as Code, security scanning, AWS deployment, GitOps, Kubernetes, and monitoring.

---

## 📌 Project Overview

This project demonstrates how a cloud-native application can move from application development to a complete DevSecOps deployment workflow.

The application layer is a **Product REST API** built with FastAPI and backed by PostgreSQL. The project is designed to progress through:

**Application → Docker → GitHub Actions → Security Scanning → Amazon ECR → Argo CD → Amazon EKS → Prometheus + Grafana**

The project documentation defines the initial application architecture as FastAPI → SQLAlchemy → PostgreSQL, with API endpoints for products, health, and metrics. [Project documentation]

---

## 🎯 Project Objectives

- Build a REST API using FastAPI
- Connect the application to PostgreSQL using SQLAlchemy
- Containerize the application with Docker
- Use Docker Compose for local application and database deployment
- Add automated API tests with Pytest
- Build CI/CD automation using GitHub Actions
- Add code and container security scanning
- Provision AWS infrastructure using Terraform
- Store Docker images in Amazon ECR
- Deploy the application to Kubernetes/Amazon EKS
- Use Argo CD for GitOps-based deployment
- Expose application metrics for Prometheus
- Monitor the application and Kubernetes environment using Prometheus and Grafana
- Keep credentials and environment-specific secrets outside source code

---

## 🏗️ Architecture

### Application Architecture

```text
                    ┌──────────────┐
                    │    Client    │
                    └──────┬───────┘
                           │
                           ▼
                 ┌───────────────────┐
                 │ FastAPI Application│
                 └─────────┬─────────┘
                           │
             ┌─────────────┼─────────────┐
             │             │             │
             ▼             ▼             ▼
       GET /products   POST /products  GET /health
             │             │             │
             └─────────────┼─────────────┘
                           ▼
                    ┌──────────────┐
                    │  SQLAlchemy  │
                    └──────┬───────┘
                           │
                           ▼
                    ┌──────────────┐
                    │  PostgreSQL  │
                    └──────┬───────┘
                           │
                           ▼
                      Product Data

                    GET /metrics
                           │
                           ▼
                       Prometheus
```

### DevSecOps Deployment Architecture

```text
Developer
    │
    ▼
  GitHub
    │
    ▼
GitHub Actions
    │
    ├── Pytest
    │
    ├── SonarQube / SonarCloud
    │
    ├── Trivy
    │
    └── Docker Build
            │
            ▼
       Amazon ECR
            │
            ▼
         Argo CD
            │
            ▼
       Amazon EKS
        ┌────┴─────┐
        │          │
        ▼          ▼
   Product API  PostgreSQL
        │
        ▼
  Prometheus
        │
        ▼
     Grafana
```

### 📷 Architecture Screenshot

Place your architecture screenshot here:

```text
docs/screenshots/architecture.png
```

Then use:

![Project Architecture](docs/screenshots/architecture.png)

---

# 🚀 Key Features

## 1. FastAPI Product API

The application provides REST endpoints for:

| Method | Endpoint | Purpose |
|---|---|---|
| GET | `/` | Application information |
| GET | `/health` | Health check |
| GET | `/products` | Retrieve products |
| POST | `/products` | Create a product |
| GET | `/products/{product_id}` | Retrieve a product by ID |
| GET | `/metrics` | Prometheus-compatible metrics |

### 📷 FastAPI Swagger UI

Place your Swagger screenshot here:

```text
docs/screenshots/fastapi-docs.png
```

```markdown
![FastAPI Swagger UI](docs/screenshots/fastapi-docs.png)
```

---

## 2. Health Check

The `/health` endpoint returns the application health status.

Expected response:

```json
{
  "status": "healthy"
}
```

This endpoint is useful for application validation and can later be used with Kubernetes health checks.

### 📷 Health Check Screenshot

Place here:

```text
docs/screenshots/health-check.png
```

```markdown
![FastAPI Health Check](docs/screenshots/health-check.png)
```

---

## 3. Product API

Example product:

```json
{
  "name": "Laptop",
  "description": "DevOps testing laptop",
  "price": 75000,
  "quantity": 10
}
```

Example response:

```json
{
  "name": "Laptop",
  "description": "DevOps testing laptop",
  "price": 75000,
  "quantity": 10,
  "id": 1
}
```

### 📷 API Output Screenshot

Place here:

```text
docs/screenshots/api-output.png
```

```markdown
![Product API Output](docs/screenshots/api-output.png)
```

---

# 🗄️ Database

The application uses **PostgreSQL**.

Database:

```text
devsecops_db
```

Table:

```text
products
```

The `products` table contains:

```text
id
name
description
price
quantity
```

SQLAlchemy is used as the ORM between FastAPI and PostgreSQL.

```text
FastAPI
   │
   ▼
SQLAlchemy
   │
   ▼
PostgreSQL
   │
   ▼
products
```

---

# 🐳 Docker

The application is containerized using Docker.

The Docker image is based on:

```text
python:3.11-slim
```

The container exposes:

```text
8000
```

The application runs with Uvicorn:

```text
uvicorn app.main:app --host 0.0.0.0 --port 8000
```

## Docker Build

```bash
docker build -t devsecops-product-api:test .
```

## Docker Compose

Docker Compose is used to run:

- FastAPI application
- PostgreSQL database

Start the services:

```bash
docker compose up -d --build
```

Check containers:

```bash
docker ps
```

### 📷 Docker Screenshot

Place here:

```text
docs/screenshots/docker.png
```

```markdown
![Docker Containers](docs/screenshots/docker.png)
```

---

# 🧪 Testing

Automated API tests are implemented using **Pytest**.

The project includes tests for:

- Root endpoint
- Health endpoint

Run:

```bash
pytest -v
```

Expected result:

```text
2 passed
```

### 📷 Test Results Screenshot

Place here:

```text
docs/screenshots/tests.png
```

```markdown
![Pytest Results](docs/screenshots/tests.png)
```

---

# 🔐 DevSecOps Security

Security is incorporated into the development and deployment workflow.

The project documentation includes:

### SonarQube / SonarCloud

Used for code analysis.

### Trivy

Used for security scanning of container images.

The intended pipeline includes:

```text
Git Push
    │
    ▼
GitHub Actions
    │
    ├── Unit Tests
    │
    ├── SonarQube / SonarCloud
    │
    ├── Trivy
    │
    └── Docker Build
```

### 📷 Security Scan Screenshot

Place here when available:

```text
docs/screenshots/security-scan.png
```

```markdown
![Security Scan](docs/screenshots/security-scan.png)
```

---

# ⚙️ GitHub Actions CI/CD

GitHub Actions is used to automate the project workflow.

The planned pipeline includes:

```text
Git Push
   │
   ▼
GitHub Actions
   │
   ├── Pytest
   │
   ├── Security Scan
   │
   ├── Docker Build
   │
   └── Push Image → Amazon ECR
```

### 📷 GitHub Actions Screenshot

Place here:

```text
docs/screenshots/github-actions.png
```

```markdown
![GitHub Actions Pipeline](docs/screenshots/github-actions.png)
```

---

# ☁️ AWS Infrastructure

Terraform is used as Infrastructure as Code for AWS resources.

The project infrastructure is designed around:

- Amazon VPC
- Public and private subnets
- Internet Gateway
- NAT Gateway
- Amazon ECR
- Amazon EKS
- IAM

AWS region used in the project configuration:

```text
ap-south-1
```

Development VPC:

```text
devsecops-vpc-dev
```

ECR repository:

```text
devsecops-product-api
```

---

# 🏗️ Terraform

Terraform modules are used to organize the AWS infrastructure.

Current module structure:

```text
terraform/
├── modules/
│   ├── vpc/
│   └── ecr/
│
└── environments/
    └── dev/
```

The infrastructure plan is intended to create the networking and container registry required by the application.

Typical Terraform workflow:

```bash
terraform init
terraform validate
terraform plan
terraform apply
```

### 📷 Terraform Screenshot

Place here:

```text
docs/screenshots/terraform.png
```

```markdown
![Terraform Infrastructure](docs/screenshots/terraform.png)
```

---

# 📦 Amazon ECR

Amazon Elastic Container Registry is used to store Docker images.

Repository:

```text
devsecops-product-api
```

The deployment workflow is:

```text
Docker Build
     │
     ▼
Security Scan
     │
     ▼
Amazon ECR
     │
     ▼
Amazon EKS
```

### 📷 ECR Screenshot

Place here:

```text
docs/screenshots/ecr.png
```

```markdown
![Amazon ECR Repository](docs/screenshots/ecr.png)
```

---

# ☸️ Kubernetes / Amazon EKS

Kubernetes manifests are organized under:

```text
k8s/
├── 01-setup.yaml
├── 02-database.yaml
├── 03-api.yaml
└── argocd-app.yaml
```

The Kubernetes configuration includes:

- Namespace
- Kubernetes Secret configuration
- PostgreSQL deployment
- PostgreSQL service
- Product API deployment
- Product API service

The Product API deployment is configured for multiple replicas.

Example architecture:

```text
                 Amazon EKS
                     │
            ┌────────┴────────┐
            │                 │
            ▼                 ▼
       Product API        PostgreSQL
       Replicas            Pod
            │                 │
            ▼                 ▼
 product-api-service    postgres-service
```

### 📷 Kubernetes Screenshot

Place here:

```text
docs/screenshots/kubernetes.png
```

```markdown
![Kubernetes Deployment](docs/screenshots/kubernetes.png)
```

---

# 🔄 GitOps with Argo CD

Argo CD is used to connect the Kubernetes deployment with the Git repository.

The intended GitOps workflow is:

```text
Developer
    │
    ▼
GitHub
    │
    ▼
Kubernetes Manifests
    │
    ▼
Argo CD
    │
    ▼
Amazon EKS
```

Argo CD watches the Kubernetes configuration in the repository and synchronizes the application with the cluster.

### 📷 Argo CD Screenshot

Place here:

```text
docs/screenshots/argocd.png
```

```markdown
![Argo CD Application](docs/screenshots/argocd.png)
```

---

# 📊 Monitoring

The application exposes Prometheus-compatible metrics through:

```text
/metrics
```

The planned monitoring stack contains:

- Prometheus
- Grafana
- Alertmanager
- Node Exporter
- Kube State Metrics

Monitoring flow:

```text
FastAPI
   │
   ▼
/metrics
   │
   ▼
Prometheus
   │
   ▼
Grafana
```

### 📷 Prometheus Screenshot

Place here:

```text
docs/screenshots/prometheus.png
```

```markdown
![Prometheus Monitoring](docs/screenshots/prometheus.png)
```

### 📷 Grafana Screenshot

Place here:

```text
docs/screenshots/grafana.png
```

```markdown
![Grafana Dashboard](docs/screenshots/grafana.png)
```

---

# 🔑 Environment Variables & Secrets

Sensitive configuration should not be hardcoded into the application.

For local development, the application uses:

```text
DATABASE_URL
```

Example format:

```text
DATABASE_URL=postgresql://<user>:<password>@localhost:5432/devsecops_db
```

The `.env` file must not be committed to GitHub.

The `.gitignore` includes:

```text
.env
venv/
__pycache__/
*.pyc
.pytest_cache/
.coverage
```

For Kubernetes, the project uses Kubernetes Secrets as part of the deployment configuration.

For production environments, secret management should use an appropriate managed secret solution rather than committing credentials to Git.

**Never place AWS access keys, database passwords, SonarCloud tokens, or other credentials in this README or Git repository.**

---

# 📁 Project Structure

```text
Project1-Secure-DevSecOps/
│
├── app/
│   ├── __init__.py
│   ├── database.py
│   ├── models.py
│   ├── schemas.py
│   └── main.py
│
├── tests/
│   └── test_api.py
│
├── terraform/
│   ├── modules/
│   │   ├── vpc/
│   │   └── ecr/
│   │
│   └── environments/
│       └── dev/
│
├── k8s/
│   ├── 01-setup.yaml
│   ├── 02-database.yaml
│   ├── 03-api.yaml
│   └── argocd-app.yaml
│
├── .github/
│   └── workflows/
│
├── docs/
│   └── screenshots/
│
├── Dockerfile
├── docker-compose.yml
├── requirements.txt
├── .gitignore
└── README.md
```

---

# 💻 Local Setup

## 1. Clone the repository

```bash
git clone https://github.com/Shashanka2911/Project1-Secure-DevSecOps.git
```

```bash
cd Project1-Secure-DevSecOps
```

## 2. Create a virtual environment

Windows PowerShell:

```powershell
python -m venv venv
```

Activate:

```powershell
.\venv\Scripts\Activate.ps1
```

## 3. Install dependencies

```bash
pip install -r requirements.txt
```

## 4. Configure PostgreSQL

Create:

```text
devsecops_db
```

Configure the local database connection using an environment variable:

```text
DATABASE_URL=postgresql://<user>:<password>@localhost:5432/devsecops_db
```

## 5. Start FastAPI

```bash
uvicorn app.main:app --reload
```

Open:

```text
http://127.0.0.1:8000
```

Swagger UI:

```text
http://127.0.0.1:8000/docs
```

Health check:

```text
http://127.0.0.1:8000/health
```

Metrics:

```text
http://127.0.0.1:8000/metrics
```

---

# 🐳 Run with Docker Compose

Build and start:

```bash
docker compose up -d --build
```

Check running containers:

```bash
docker ps
```

Check API logs:

```bash
docker compose logs api
```

Stop the application:

```bash
docker compose down
```

---

# 🧪 Run Tests

```bash
pytest -v
```

---

# 🏗️ Terraform Commands

Move into the development environment:

```bash
cd terraform/environments/dev
```

Initialize:

```bash
terraform init
```

Validate:

```bash
terraform validate
```

Review:

```bash
terraform plan
```

Apply:

```bash
terraform apply
```

When infrastructure is no longer required, review resources carefully before running:

```bash
terraform destroy
```

---

# ☸️ Kubernetes Commands

Validate manifests without deploying:

```bash
kubectl apply --dry-run=client -f k8s/01-setup.yaml
kubectl apply --dry-run=client -f k8s/02-database.yaml
kubectl apply --dry-run=client -f k8s/03-api.yaml
```

Validate all manifests:

```bash
kubectl apply --dry-run=client -f k8s/
```

Check resources:

```bash
kubectl get pods -n devsecops
kubectl get svc -n devsecops
```

---

# 📈 Monitoring Commands

Check monitoring components:

```bash
kubectl get pods -n monitoring
```

Prometheus:

```text
http://localhost:9090
```

Grafana:

```text
http://localhost:3000
```

---

# 🔒 Security Practices

This project follows several basic DevSecOps security practices:

- Credentials are stored outside application source code.
- `.env` is excluded through `.gitignore`.
- GitHub Actions secrets are used for CI/CD credentials.
- Trivy is included in the security-scanning workflow.
- SonarQube/SonarCloud is included for code analysis.
- Kubernetes Secrets are used for Kubernetes configuration.
- Docker images are stored in Amazon ECR.
- Infrastructure is managed using Terraform rather than manually creating every resource.

**Do not publish secret values or screenshots containing credentials.**

---

# 📚 What I Learned

Through this project I practiced:

### Application Development

- REST API development
- FastAPI
- SQLAlchemy
- PostgreSQL
- API testing

### Containers

- Dockerfile creation
- Docker image creation
- Docker Compose
- Container networking

### CI/CD

- GitHub Actions
- Automated testing
- Docker build automation
- ECR image publishing

### Infrastructure as Code

- Terraform
- Terraform modules
- AWS VPC
- Amazon ECR
- AWS infrastructure planning

### Kubernetes

- Kubernetes Deployments
- Services
- Secrets
- Namespaces
- Amazon EKS

### DevSecOps

- Trivy
- SonarQube/SonarCloud
- Secret management
- Security scanning in CI/CD

### GitOps & Monitoring

- Argo CD
- Prometheus
- Grafana
- Application metrics

---

# 🔮 Future Improvements

Possible next improvements include:

- Add more comprehensive automated tests
- Add Kubernetes readiness and liveness probes
- Improve production secret management with AWS-managed secret services
- Add automated EKS deployment through the CI/CD/GitOps workflow
- Add richer Prometheus and Grafana dashboards
- Add centralized logging
- Add alerting rules
- Add HTTPS/TLS
- Add image versioning instead of relying only on `latest`
- Add rollback strategies for deployments

---

# 📸 Project Screenshots

The recommended screenshot directory is:

```text
docs/screenshots/
```

Use these filenames:

```text
architecture.png
fastapi-docs.png
health-check.png
api-output.png
docker.png
tests.png
security-scan.png
github-actions.png
terraform.png
ecr.png
kubernetes.png
argocd.png
prometheus.png
grafana.png
```

Only add screenshots for components you have actually completed and verified.

---

# 🔗 Project Repository

GitHub:

**https://github.com/Shashanka2911/Project1-Secure-DevSecOps**

---

# 👨‍💻 Author

**Shashanka**

Cloud & DevOps Engineer | AWS | Kubernetes | Terraform | Docker | CI/CD

---

## ⭐ If you find this project useful

Feel free to explore the repository, review the implementation, and learn from the DevSecOps workflow.
