pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build and Test') {
            steps {
                script {
                    // Start Docker containers
                    sh 'docker-compose up -d'

                    // Install dependencies and run tests
                    sh 'docker-compose exec php composer install'
                    sh 'docker-compose exec php vendor/bin/phpunit'
                }
            }
        }

        stage('Deploy') {
            steps {
                script {
                    // Deploy the application
                    sh 'docker-compose down'
                    sh 'docker-compose up -d'
                }
            }
        }
    }

    post {
        always {
            // Clean up Docker containers
            sh 'docker-compose down'
        }
    }
}
