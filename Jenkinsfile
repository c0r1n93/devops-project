pipeline {
    agent any

    environment {
        DOCKER_HUB_REPO = 'corinelaure/my-java-app'
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
                sh "docker build -t ${DOCKER_HUB_REPO}:latest ."
            }
        }

        stage('Push Docker Image') {
            steps {
                withCredentials([usernamePassword(credentials
Id: 'dockerhub-credentials', passwordVariable: 'DOCKER_HUB_PASSWORD', usernameVariable: 'DOCKER_HUB_USERNAME')]) {
                    sh "docker push ${DOCKER_HUB_REPO}:latest"
                }
            }
        }
    }
}
