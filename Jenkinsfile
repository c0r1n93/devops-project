pipeline {
    agent any

    environment {
        DOCKER_HUB_REPO = 'corinelaure/my-java-app'
        IMAGE_NAME = 'my-java-app'
        IMAGE_TAG = 'latest'
    }

    stages {

        stage('Clone Repository') {
            steps {
                git branch:'main', url: 'https://github.com/c0r1n93/devops-project.git'
            }
        }

        stage('Build Application') {
            steps {
                sh 'mvn clean package'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh "docker build -t ${DOCKER_HUB_REPO}:${IMAGE_TAG} ."
            }
        }

        stage('login to Docker Image') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub-credentials')]) {
                    sh "echo 'Logged in to Docker Hub'"
                }
            }
        }
        stage('Push Docker Image') {
            steps {
                sh "docker tag ${IMAGE_NAME}:${IMAGE_TAG} ${DOCKER_HUB_REPO}:${IMAGE_TAG}"
                sh "docker push ${DOCKER_HUB_REPO}:${IMAGE_TAG}"
            }
        }

    }
    
}    
    
	
