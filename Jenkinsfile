pipeline {
    agent any

    stages {
        stage('Print Docker Host Configuration') {
            steps {
                script {
                    echo "DOCKER_HOST: ${env.DOCKER_HOST}"
                }
            }
        }

        stage('Print Docker Daemon Status') {
            steps {
                script {
                    sh 'docker info'
                }
            }
        }

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
                    sh(script: 'docker-compose exec php sh -c "php -r \"copy(\'https://getcomposer.org/installer\', \'composer-setup.php\');\""', shell: '/bin/bash')
                    sh(script: 'docker-compose exec php sh -c "php composer-setup.php --install-dir=/usr/local/bin --filename=composer"', shell: '/bin/bash')
                    sh(script: 'docker-compose exec php sh -c "composer install --no-interaction --no-ansi"', shell: '/bin/bash')
                    sh(script: 'docker-compose exec php vendor/bin/phpunit', shell: '/bin/bash')
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
