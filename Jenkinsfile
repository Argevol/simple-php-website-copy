pipeline {
    agent any

    environment {
        registry = 'cheapyd'
        imageName = 'simple-php-website'
        dockerImage = "${registry}/${imageName}"
        dockerhubToken = credentials('dockerhub-credentials')
    }

    stages {
        stage('Checkout') {
            steps {
                script {
                    // Checkout the code from SCM
                    checkout scm
                }
            }
        }

        stage('Build') {
            steps {
                script {
                    // Build Docker image
                    sh "docker build -t ${dockerImage} ."
                }
            }
        }

        stage('Push to DockerHub') {
            steps {
                script {
                    // Push Docker image to DockerHub
                    withCredentials([string(credentialsId: 'dockerhub-credentials', variable: 'DOCKERHUB_TOKEN')]) {
                        sh "docker login -u ${registry} -p ${DOCKERHUB_TOKEN}"
                        sh "docker push ${dockerImage}"
                    }
                }
            }
        }

        stage('Deploy') {
            steps {
                script {
                    // Deploy using Docker and NGINX
                    sh 'docker-compose up -d'
                }
            }
        }
    }
}
