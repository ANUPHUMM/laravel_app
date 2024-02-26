pipeline {
    agent any
    
    environment {
        DOCKER_HUB_USERNAME = credentials('docker-hub-username')
        DOCKER_HUB_PASSWORD = credentials('docker-hub-password')
        DOCKER_HUB_REPO = 'your-docker-hub-username/laravel-app'
        DOCKER_IMAGE_NAME = 'laravel-app'
    }
    
    stages {
        stage('Build Docker Image') {
            steps {
                script {
                    // Build Docker image
                    docker.build("${DOCKER_HUB_REPO}:${env.BUILD_NUMBER}")
                }
            }
        }
        
        stage('Push to Docker Hub') {
            steps {
                script {
                    // Login to Docker Hub
                    docker.withRegistry('https://index.docker.io/v1/', DOCKER_HUB_USERNAME, DOCKER_HUB_PASSWORD) {
                        // Push Docker image to Docker Hub
                        docker.image("${DOCKER_HUB_REPO}:${env.BUILD_NUMBER}").push()
                        // Tag and push latest
                        docker.image("${DOCKER_HUB_REPO}:${env.BUILD_NUMBER}").tag("${DOCKER_HUB_REPO}:latest")
                        docker.image("${DOCKER_HUB_REPO}:latest").push()
                    }
                }
            }
        }
    }
}
