pipeline {
    agent any

    environment {
        registry = 'cheapyd'
        imageName = 'simple-php-website'
        dockerImage = "${registry}/${imageName}"
        dockerhubCredentials = 'dockerhub_credentials'
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
                    withDockerRegistry([credentialsId: dockerhubCredentials, url: 'https://registry.hub.docker.com']) {
                        dockerImage.push()
                    }
                }
            }
        }
    }
}
