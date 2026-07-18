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
                // Вказуємо, що цей етап має виконуватися в контейнері з назвою 'docker'
                container('docker') {
                    script {
                        sh "docker build -t ${REPO_NAME}:${IMAGE_TAG} ."
                    }
                }
            }
        }
        stage('Push') {
            steps {
                container('docker') {
                    withCredentials([usernamePassword(credentialsId: '4087ff39-0114-475d-b6f3-926b6fd116c8', usernameVariable: 'AWS_ACCESS_KEY_ID', passwordVariable: 'AWS_SECRET_ACCESS_KEY')]) {
                        sh "aws ecr get-login-password --region us-west-2 | docker login --username AWS --password-stdin ${ECR_REGISTRY}"
                        sh "docker tag ${REPO_NAME}:${IMAGE_TAG} ${ECR_REGISTRY}/${REPO_NAME}:${IMAGE_TAG}"
                        sh "docker push ${ECR_REGISTRY}/${REPO_NAME}:${IMAGE_TAG}"
                    }
                }
            }
        }
        stage('Update Manifest') {
            steps {
                container('docker') {
                    withCredentials([usernamePassword(credentialsId: 'ba1a3fa7-cce9-4ae5-9aaf-92dca2826c73', usernameVariable: 'GIT_USER', passwordVariable: 'GIT_TOKEN')]) {
                        script {
                            sh "sed -i 's|tag:.*|tag: \"${IMAGE_TAG}\"|' helm-chart/django-app/values.yaml"
                            sh "git config user.email 'jenkins@jenkins.com'"
                            sh "git config user.name 'Jenkins'"
                            sh "git remote set-url origin https://${GIT_USER}:${GIT_TOKEN}@github.com/nata87/ci-cd-devops-hw.git"
                            sh "git add helm-chart/django-app/values.yaml"
                            sh "git commit -m 'Jenkins update image tag to ${IMAGE_TAG}'"
                            sh "git push origin main"
                        }
                    }
                }
            }
        }
    }
}