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
                sh 'docker build -t $DOCKER_HUB_REPO:latest .'
            }
        }

        stage('Push Docker Image') {
            steps {
                withDockerRegistry([credentialsId: 'docker-hub-credentials', url: '']) {
                    sh 'docker push $DOCKER_HUB_REPO:latest'
                }
            }
        }

        stage('Deploy on EC2') {
            steps {
                sshagent(['deploy-server-ssh']) {
                    sh '''
                    ssh -o StrictHostKeyChecking=no ubuntu@<DEPLOY-EC2-IP> <<EOF
                    docker pull $DOCKER_HUB_REPO:latest
                    docker stop my-java-app || true
                    docker rm my-java-app || true
                    docker run -d -p 8080:8080 --name my-java-app $DOCKER_HUB_REPO:latest
                    EOF
                    '''
                }
            }
        }
    }
}
