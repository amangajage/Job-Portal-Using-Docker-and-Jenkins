pipeline {
    agent any

    stages {

        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t job-portal .'
            }
        }

        stage('Test') {
            steps {
                sh 'docker images job-portal'
            }
        }

        stage('Deploy') {
            steps {
                withCredentials([
                    string(
                        credentialsId: 'mysql-root-password',
                        variable: 'MYSQL_ROOT_PASSWORD'
                    )
                ]) {
                    sh '''
                        export MYSQL_DATABASE=job_portal
                        docker compose down || true
                        docker compose up -d --build
                    '''
                }
            }
        }
    }
}