pipeline {
    agent any
    environment {
        ECR_REGISTRY = "495671352321.dkr.ecr.us-west-2.amazonaws.com"
        REPO_NAME = "lesson-5-ecr"
        IMAGE_TAG = "${env.BUILD_NUMBER}"
    }
    stages {
        stage('Build') {
            steps {
                script {
                    // Збираємо образ
                    sh "docker build -t ${REPO_NAME}:${IMAGE_TAG} ."
                }
            }
        }
        stage('Push') {
            steps {
                script {
                    // Авторизація та пуш
                    sh "aws ecr get-login-password --region us-west-2 | docker login --username AWS --password-stdin ${ECR_REGISTRY}"
                    sh "docker tag ${REPO_NAME}:${IMAGE_TAG} ${ECR_REGISTRY}/${REPO_NAME}:${IMAGE_TAG}"
                    sh "docker push ${ECR_REGISTRY}/${REPO_NAME}:${IMAGE_TAG}"
                }
            }
        }
    }
}