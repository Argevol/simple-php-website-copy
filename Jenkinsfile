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
                checkout scm
            }
        }

        stage('Build and Push to DockerHub') {
            steps {
                script {
                    docker.build dockerImage, "-f Dockerfile ."
                    sh "docker login -u cheapyd -p ${dockerhubToken}"
                    sh "docker push ${dockerImage}"
                }
            }
        }

        stage('Run Docker Container') {
            steps {
                script {
                    sh "docker-compose up -d"
                }
            }
        }
    }
}
