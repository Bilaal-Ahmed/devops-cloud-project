# DevOps Cloud Project

A complete DevOps deployment project demonstrating **containerization, CI/CD automation, Docker Hub image management, container security scanning, AWS infrastructure provisioning with Terraform, and automated EC2 deployment**.

The project uses GitHub Actions to automatically build, test, scan, publish, and deploy a Dockerized web application to an AWS EC2 instance.

---

## 🚀 Project Overview

This project demonstrates a practical DevOps workflow:

```text
Developer Push
      │
      ▼
   GitHub
      │
      ▼
GitHub Actions
      │
      ├── Build Docker Image
      │
      ├── Test Container
      │
      ├── Trivy Security Scan
      │
      ├── Push Image to Docker Hub
      │
      ▼
 AWS EC2 Deployment
      │
      ▼
 Docker Container
      │
      ▼
   Web Application
```

Infrastructure is managed using **Terraform**, including:

* AWS EC2 instance
* AWS Security Group
* AWS S3 bucket

---

## 🛠️ Technologies Used

### DevOps & CI/CD

* Git
* GitHub
* GitHub Actions
* Docker
* Docker Hub
* Trivy
* SSH

### Cloud

* Amazon Web Services (AWS)
* Amazon EC2
* Amazon S3
* AWS Security Groups
* IAM

### Infrastructure as Code

* Terraform
* Terraform AWS Provider

### Application

* HTML
* CSS
* JavaScript
* Nginx
* Docker

---

## 📁 Project Structure

```text
devops-project/
│
├── .github/
│   └── workflows/
│       └── ci.yml
│
├── terraform/
│   ├── main.tf
│   ├── variables.tf
│   ├── outputs.tf
│   └── .terraform.lock.hcl
│
├── Dockerfile
├── index.html
├── .gitignore
└── README.md
```

Terraform state files are intentionally excluded from Git using `.gitignore`.

---

# 🐳 Docker

The application is containerized using Docker.

The Docker image packages the web application together with Nginx and provides a consistent environment for local testing and cloud deployment.

### Build the image

```bash
docker build -t devops-web:test .
```

### Run the container

```bash
docker run -d \
  --name devops-web \
  -p 8080:80 \
  devops-web:test
```

### Test the application

```bash
curl http://localhost:8080
```

### Stop the container

```bash
docker stop devops-web
```

### Remove the container

```bash
docker rm devops-web
```

---

# 🔄 CI/CD Pipeline

The CI/CD pipeline is defined in:

```text
.github/workflows/ci.yml
```

The workflow runs automatically when changes are pushed to the `main` branch or when a pull request targets `main`.

## Pipeline Stages

### 1. Build and Test

GitHub Actions:

1. Checks out the repository.
2. Builds the Docker image.
3. Starts a test container.
4. Performs an HTTP health check.
5. Stops and removes the test container.

Example health check:

```bash
curl --fail http://localhost:8080
```

---

### 2. Docker Image Build

After the application passes testing, the pipeline builds the production Docker image.

Two tags are created:

```text
<dockerhub-username>/devops-cloud-project:<commit-sha>
<dockerhub-username>/devops-cloud-project:latest
```

The commit SHA tag provides an immutable reference to a specific build.

---

### 3. Container Security Scan

The Docker image is scanned using **Trivy**.

The pipeline checks for:

* HIGH vulnerabilities
* CRITICAL vulnerabilities

Unfixed vulnerabilities are ignored to reduce failures caused by issues that do not yet have available fixes.

The pipeline fails when relevant vulnerabilities are detected.

---

### 4. Push to Docker Hub

After successfully passing the security scan, the image is pushed to Docker Hub.

Images are published using:

```text
<commit-sha>
latest
```

This allows deployments to use a specific version instead of relying only on the `latest` tag.

---

### 5. Automated EC2 Deployment

After the Docker image is successfully published, GitHub Actions connects to the AWS EC2 server using SSH.

The deployment process:

1. Logs into Docker Hub.
2. Pulls the image associated with the current commit.
3. Stops the existing application container.
4. Removes the old container.
5. Starts the new container.
6. Enables automatic container restart.
7. Checks the running container.
8. Performs an HTTP health check.

The deployed container uses:

```text
Port 80 → Nginx → Web Application
```

---

# ☁️ AWS Infrastructure

AWS infrastructure is managed using Terraform.

The project currently provisions:

```text
AWS
│
├── EC2
│   └── DevOps-Terraform-Server
│
├── Security Group
│   ├── SSH : 22
│   └── HTTP : 80
│
└── S3
    └── Terraform Demo Bucket
```

The infrastructure is deployed in the configured AWS region.

---

# 🏗️ Terraform

Terraform configuration is located inside:

```text
terraform/
```

## Terraform Files

### `main.tf`

Defines the AWS infrastructure resources:

* EC2 instance
* Security Group
* S3 bucket

### `variables.tf`

Contains configurable infrastructure values:

* AWS region
* AMI ID
* EC2 instance type
* subnet ID

### `outputs.tf`

Provides useful information after deployment:

* EC2 instance ID
* EC2 public IP
* Security Group ID
* S3 bucket name

---

## Terraform Workflow

Initialize Terraform:

```bash
terraform init
```

Format the configuration:

```bash
terraform fmt
```

Validate the configuration:

```bash
terraform validate
```

Preview infrastructure changes:

```bash
terraform plan
```

Apply infrastructure changes:

```bash
terraform apply
```

View managed resources:

```bash
terraform state list
```

View Terraform outputs:

```bash
terraform output
```

---

## 🔍 Infrastructure Verification

Terraform is used to maintain infrastructure consistency.

The expected result after the infrastructure is synchronized is:

```text
No changes. Your infrastructure matches the configuration.
```

This confirms that the actual AWS infrastructure matches the Terraform configuration.

---

# 🔐 Security

The project follows several basic security practices:

* Docker images are scanned using Trivy.
* Docker Hub authentication uses GitHub Secrets.
* EC2 SSH credentials are stored as GitHub Secrets.
* AWS credentials are not stored in the repository.
* Terraform state files are excluded from Git.
* Sensitive information is not hardcoded into the CI/CD workflow.
* Docker images are tagged using commit SHA values for traceable deployments.

### Secrets

The CI/CD pipeline uses GitHub repository secrets for credentials such as:

```text
DOCKERHUB_USERNAME
DOCKERHUB_TOKEN
EC2_HOST
EC2_USERNAME
EC2_SSH_KEY
```

Secret values must never be committed to the repository.

---

# 📦 Docker Image

Docker Hub repository:

```text
bilaalahmed/devops-cloud-project
```

The CI/CD pipeline publishes images using both:

```text
<commit-sha>
latest
```

The commit SHA tag allows a particular application version to be deployed and identified.

---

# 🚀 Deployment Flow

A normal deployment follows this process:

```text
1. Developer modifies application
              ↓
2. Git commit
              ↓
3. Git push to main
              ↓
4. GitHub Actions starts
              ↓
5. Docker image is built
              ↓
6. Container is tested
              ↓
7. Trivy scans the image
              ↓
8. Image is pushed to Docker Hub
              ↓
9. GitHub Actions connects to EC2
              ↓
10. EC2 pulls the new image
              ↓
11. Old container is replaced
              ↓
12. Application health check
              ↓
13. Deployment completed
```

---

# 🧪 Local Testing

Clone the repository:

```bash
git clone https://github.com/Bilaal-Ahmed/devops-cloud-project.git
cd devops-cloud-project
```

Build the Docker image:

```bash
docker build -t devops-web:test .
```

Run it:

```bash
docker run -d \
  --name devops-test \
  -p 8080:80 \
  devops-web:test
```

Test:

```bash
curl --fail http://localhost:8080
```

Clean up:

```bash
docker stop devops-test
docker rm devops-test
```

---

# 📊 Infrastructure Management

Terraform follows an Infrastructure as Code approach.

Instead of manually creating AWS resources through the AWS Console, the infrastructure is described in Terraform configuration files.

This provides:

* Repeatable infrastructure
* Version-controlled configuration
* Infrastructure change tracking
* Predictable deployments
* Easier recovery
* Reduced manual configuration

---

# 📌 Current Project Status

The following components are implemented:

* [x] Git repository
* [x] Dockerfile
* [x] Docker containerization
* [x] Local container testing
* [x] GitHub Actions CI pipeline
* [x] Docker Hub integration
* [x] Trivy container scanning
* [x] Automated EC2 deployment
* [x] AWS EC2 infrastructure
* [x] AWS Security Group
* [x] AWS S3
* [x] Terraform Infrastructure as Code
* [x] Terraform variables
* [x] Terraform outputs
* [x] Infrastructure validation
* [x] Infrastructure drift verification

---

# 🔮 Future Improvements

Possible future improvements include:

* Remote Terraform state using an S3 backend
* Terraform state locking
* Separate development and production environments
* Terraform modules
* Deployment rollback strategy
* Application monitoring
* Centralized logging
* Automated infrastructure deployment through GitHub Actions
* Blue/green or rolling deployment strategies
* HTTPS with a domain and TLS certificate

These improvements can be added as the project evolves.

---

# 👨‍💻 Author

**Bilal Ahmed**

Software Engineering Graduate
DevOps / Cloud Engineering

Email:
mr.bilal.ahmed281@gmail.com

GitHub:
https://github.com/Bilaal-Ahmed

LinkedIn:
https://www.linkedin.com/in/bilal-ahmed-26513b296/

---

## ⭐ Project Goal

The goal of this project is to demonstrate practical DevOps skills by building an automated workflow from source code to a running application on AWS.

It combines **Git, GitHub Actions, Docker, Docker Hub, Trivy, AWS, EC2, S3, and Terraform** into a reproducible deployment workflow.

