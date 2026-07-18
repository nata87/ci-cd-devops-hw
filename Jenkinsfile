pipeline {
    agent any
    environment {
        ECR_REGISTRY = "495671352321.dkr.ecr.us-west-2.amazonaws.com"
        REPO_NAME = "lesson-5-ecr"
        IMAGE_TAG = "${env.BUILD_NUMBER}"
    }
    stages {
        stage('Build and Push') {
            steps {
                container('kaniko') {
                    sh """
                    /kaniko/executor \
                    --context=`pwd` \
                    --dockerfile=Dockerfile \
                    --destination=${ECR_REGISTRY}/${REPO_NAME}:${IMAGE_TAG} \
                    --destination=${ECR_REGISTRY}/${REPO_NAME}:latest
                    """
                }
            }
        }
        stage('Update Manifest') {
            steps {
                // Використовуємо контейнер з git (зазвичай це 'jnlp' або окремий 'git')
                container('jnlp') {
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