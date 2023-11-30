pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                script {
                    docker.image('php:7.4-apache').inside {
                        sh 'php -S 0.0.0.0:8080'
                    }
                }
            }
        }
    }

    post {
        success {
            echo 'Build succeeded! Pushing to DockerHub...'
            script {
                docker.withRegistry('https://registry.hub.docker.com', 'dockerhub_credentials') {
                    app = docker.build('yourdockerhubusername/simple-php-website', '.')
                    app.push()
                }
            }
        }
    }
}
