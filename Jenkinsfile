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
    }
}