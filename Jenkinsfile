pipeline {
    agent any

    environment {
        registry = 'cheapyd'
        imageName = 'simple-php-website'
        dockerImage = "${registry}/${imageName}"
        dockerhubToken = 'dckr_pat_ww_g--d1OctECw8_g7VTd5MPIYQ'
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
                    sh "docker login -u ${registry} -p ${dockerhubToken}"
                    sh "docker push ${dockerImage}"
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
