pipeline {
    agent any

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
                    sh 'until docker exec my-php-website ps aux | grep -q "nginx: master process"; do sleep 1; done'
                }
            }
        }
    }

    post {
        always {
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
}
