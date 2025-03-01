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
                withDockerRegistry([credentialsId: 'docker-hub-credentials', url: 'https://index.docker.io/v2/']) {
                    sh "docker tag my-java-app:latest ${DOCKER_HUB_REPO}:latest"
                    sh "docker push ${DOCKER_HUB_REPO}:latest"
                }
            }
        }
    }
}
