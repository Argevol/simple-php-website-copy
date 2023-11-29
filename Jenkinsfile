pipeline {
    agent any

    environment {
        DOCKER_HOST = 'tcp://localhost:2375' // Set your Docker host here
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build and Run') {
            steps {
                script {
                    // Build Docker image using docker-compose
                    sh 'docker-compose -f docker-compose-nginx.yml up -d'
                }
            }
        }

        stage('Wait for Container') {
            steps {
                script {
                    // Wait for the PHP container to be up and running
                    sh 'until docker exec my-php-website ps aux | grep -q "nginx"; do sleep 1; done'
                }
            }
        }

        stage('Cleanup') {
            steps {
                script {
                    // Stop and remove Docker container
                    sh 'docker-compose -f docker-compose-nginx.yml down'
                }
            }
        }
    }
}
