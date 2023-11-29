pipeline {
    agent any

    stages {
        stage('Declarative: Checkout SCM') {
            steps {
                checkout scm
            }
        }

        stage('Print Docker Host Configuration') {
            steps {
                script {
                    echo "DOCKER_HOST: ${DOCKER_HOST}"
                }
            }
        }

        stage('Print Docker Daemon Status') {
            steps {
                sh 'docker info'
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
                    sh 'docker-compose up -d'
                    sh '''
                        docker-compose exec php sh -c "php -r 'copy(\'https://getcomposer.org/installer\', \'composer-setup.php\');'"
                    '''
                }
            }
        }
    }

    post {
        always {
            stage('Declarative: Post Actions') {
                steps {
                    sh 'docker-compose down'
                }
            }
        }
    }
}
