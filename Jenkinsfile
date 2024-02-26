pipeline {
    agent any
    
    environment {
        DOCKER_HUB_USERNAME = credentials('anup88')
        DOCKER_HUB_PASSWORD = credentials('home12345')
        DOCKER_HUB_REPO = 'anup88/laravel-app'
        DOCKERFILE_PATH = 'Dockerfile'
    }
    
    stages {
        stage('Build Docker Image') {
            steps {
                script {
                    // Build Docker image from specific Dockerfile
                    docker.build("${DOCKER_HUB_REPO}:${env.BUILD_NUMBER}", "-f ${DOCKERFILE_PATH} .")
                }
            }
        }
        
        stage('Push to Docker Hub') {
            steps {
                script {
                    // Login to Docker Hub and push Docker image
                    docker.withRegistry('https://index.docker.io/v1/', DOCKER_HUB_USERNAME, DOCKER_HUB_PASSWORD) {
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
