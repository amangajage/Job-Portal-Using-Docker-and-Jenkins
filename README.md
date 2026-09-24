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

### Application

- Java
- JSP
- Servlets
- MySQL
- Apache Tomcat
- Maven

### DevOps

- Git & GitHub
- Docker
- Docker Compose
- Jenkins
- Linux
- Shell scripting
- GitHub Webhooks

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

##Docker Implementation
Dockerfile

The application is packaged into a Docker image containing the required Java/Tomcat runtime.

The Dockerfile:

Uses a Tomcat base image
Copies the generated application WAR file into Tomcat
Exposes port 8080
Starts Tomcat when the container launches

The application runs on port 8080 inside the container.

##Docker Compose

Docker Compose is used to run the application and MySQL together.

The Compose configuration provides:

Java/Tomcat application container
MySQL 8 container
Dedicated Docker network
Database initialization
Environment variable configuration
Container dependency configuration
Port mapping
