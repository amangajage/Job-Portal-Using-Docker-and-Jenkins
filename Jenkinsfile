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
                bat 'docker build -t job-portal .'
            }
        }

        stage('Test') {
            steps {
                bat 'docker images job-portal'
            }
        }
    }
}