pipeline {
    agent any

    environment {
        registry = 'cheapyd'
        imageName = 'simple-php-website'
        dockerImage = "${registry}/${imageName}"
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build and Push to DockerHub') {
            steps {
                script {
                    docker.build dockerImage, "-f Dockerfile ."
                    docker.withRegistry('https://registry.hub.docker.com', 'dockerhub_credentials') {
                        dockerImage.push()
                    }
                }
            }
        }
    }
}
