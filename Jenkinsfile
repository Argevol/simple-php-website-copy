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
                    dockerComposeExec(service: 'php', command: 'sh -c', args: 'php -r "copy(\'https://getcomposer.org/installer\', \'composer-setup.php\');"')
                    dockerComposeExec(service: 'php', command: 'sh -c', args: 'php composer-setup.php --install-dir=/usr/local/bin --filename=composer')
                    dockerComposeExec(service: 'php', command: 'composer', args: 'install --no-interaction --no-ansi')
                    dockerComposeExec(service: 'php', command: 'vendor/bin/phpunit')

                    // Clean up Docker containers
                    sh 'docker-compose down'
                }
            }
        }

        stage('Deploy') {
            steps {
                script {
                    // Deploy the application
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

def dockerComposeExec(Map config) {
    // Helper function to run docker-compose exec
    sh "docker-compose exec ${config.service} ${config.command} ${config.args}"
}
