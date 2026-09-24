# Online Job Portal — Docker & Jenkins CI/CD

A Java-based Online Job Portal containerized with Docker and deployed through an automated Jenkins CI/CD pipeline.

The primary focus of this project is the **DevOps implementation**: containerization, multi-container orchestration, CI/CD automation, GitHub integration, deployment verification, and Docker resource management.

---

# Docker and Jenkins Highlights

- Containerized a Java/Tomcat web application using Docker
- Created a custom Docker image using a Dockerfile
- Containerized and configured MySQL
- Used Docker Compose to orchestrate the application and database
- Created a dedicated Docker network for container-to-container communication
- Configured environment-based database credentials
- Implemented a Jenkins Declarative Pipeline
- Integrated Jenkins with GitHub
- Configured a GitHub Webhook for automatic pipeline triggering
- Automated Docker image building and deployment
- Added post-deployment application health checks
- Added Docker image and build-cache cleanup
- Troubleshot Docker networking, port conflicts, database connectivity, and Jenkins pipeline issues

---

## Technology Stack

### DevOps

- Git & GitHub
- Docker
- Docker Compose
- Jenkins
- Linux
- Shell scripting
- GitHub Webhooks

## Docker Implementation
### Dockerfile

The application is packaged into a Docker image containing the required Java/Tomcat runtime.

The Dockerfile:

1. Uses a Tomcat base image
2. Copies the generated application WAR file into Tomcat
3. Exposes port 8080
4. Starts Tomcat when the container launches

The application runs on port 8080 inside the container.

### Docker Compose

Docker Compose is used to run the application and MySQL together.

The Compose configuration provides:

1. Java/Tomcat application container
2. MySQL 8 container
3. Dedicated Docker network
4. Database initialization
5. Environment variable configuration
6. Container dependency configuration
7. Port mapping

## Jenkins CI/CD Pipeline

The project uses a Jenkins Declarative Pipeline to automate the build and deployment process.
## Pipeline Stages
### 1. Checkout

Jenkins retrieves the latest source code from GitHub.

GitHub → Jenkins Workspace
### 2. Build Docker Image

Jenkins builds the Docker image from the Dockerfile.

docker build -t job-portal .
### 3. Test

The pipeline verifies that the Docker image was successfully created.

### 4. Deploy

Docker Compose is used to deploy the application and MySQL containers.

docker compose up -d --build
### 5. Health Check

After deployment, Jenkins waits for the application to start and verifies that it responds over HTTP.


This prevents Jenkins from treating a deployment as successful when the container starts but the application is not responding.

### 6. Docker Cleanup

Unused Docker images and build cache are removed:

docker image prune -f
docker builder prune -f

This helps control Docker disk usage on the deployment server.

## GitHub Webhook Integration

A GitHub Webhook connects the GitHub repository to Jenkins.

---

## Architecture

```text
                         GitHub
                            │
                            │ git push
                            ▼
                    GitHub Webhook
                            │
                            ▼
                        Jenkins
                            │
                ┌───────────┴───────────┐
                │                       │
            Checkout              Build Docker
                │                   Image
                │                       │
                └───────────┬───────────┘
                            ▼
                          Test
                            │
                            ▼
                    Docker Compose
                            │
                 ┌──────────┴──────────┐
                 │                     │
                 ▼                     ▼
          Job Portal App            MySQL
          Tomcat Container        Container
                 │                     │
                 └────── Docker ──────┘
                        Network
                            │
                            ▼
                     Health Check
                            │
                            ▼
                    Docker Cleanup

