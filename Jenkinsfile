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

        stage('Health Check') {
            steps {
                sh '''
                    echo "Waiting for application to start..."
                    sleep 15

                    curl --fail --silent --show-error \
                    http://localhost:8081/Job_Portal/ \
                    > /dev/null

                    echo "Application is running successfully."
                '''
            }
        }
    }
}

stage('Docker Cleanup') {
    steps {
        sh '''
            docker image prune -f
            docker builder prune -f
        '''
    }
}