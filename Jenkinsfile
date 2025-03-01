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
                withCredentials([usernamePassword(credentialsId: 'dockerhub-credentials', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                   sh "docker login -u ${DOCKER_USER} -p ${DOCKER_PASS}"
                }

            }
        }
        
        stage('Push Docker Image') {
            steps {
                sh "docker tag ${IMAGE_NAME}:${IMAGE_TAG} ${DOCKER_HUB_REPO}:${IMAGE_TAG}"
                sh "docker push ${DOCKER_HUB_REPO}:${IMAGE_TAG}"
            }
        }
        stage('Deploy on EC2') {
            steps {
                sshagent(['deploy-server-ssh']) {
                    sh '''
                    ssh -o StrictHostKeyChecking=no ubuntu@54.89.31.61 <<EOF
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
    
	
