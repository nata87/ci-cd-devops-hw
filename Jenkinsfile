pipeline {
  agent {
    kubernetes {
      yaml """
apiVersion: v1
kind: Pod
spec:
  serviceAccountName: default
  containers:
    - name: kaniko
      image: gcr.io/kaniko-project/executor:v1.16.0-debug
      imagePullPolicy: Always
      command:
        - sleep
      args:
        - 99d
"""
    }
  }

  environment {
    ECR_REGISTRY = "495671352321.dkr.ecr.us-west-2.amazonaws.com"
    IMAGE_NAME   = "lesson-5-ecr"
    IMAGE_TAG    = "${env.BUILD_NUMBER}"
  }

  stages {
    stage('Build & Push Docker Image') {
      steps {
        container('kaniko') {
          withCredentials([usernamePassword(credentialsId: '4087ff39-0114-475d-b6f3-926b6fd116c8', usernameVariable: 'AWS_ACCESS_KEY_ID', passwordVariable: 'AWS_SECRET_ACCESS_KEY')]) {
            sh '''
              # Експортуємо змінні для автоматичної авторизації Kaniko в ECR
              export AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID
              export AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY
              export AWS_DEFAULT_REGION=us-west-2

              # Використовуємо контекст папки, де лежить Dockerfile
              /kaniko/executor \
                --context=`pwd`/docker/django_app \
                --dockerfile=Dockerfile \
                --destination=$ECR_REGISTRY/$IMAGE_NAME:$IMAGE_TAG \
                --cache=true \
                --insecure \
                --skip-tls-verify
            '''
          }
        }
      }
    }
    
    stage('Update Manifest') {
      steps {
        container('jnlp') {
          withCredentials([usernamePassword(credentialsId: 'ba1a3fa7-cce9-4ae5-9aaf-92dca2826c73', usernameVariable: 'GIT_USER', passwordVariable: 'GIT_TOKEN')]) {
            script {
              sh """
                # Повертаємося в корінь проекту
                cd /home/jenkins/agent/workspace/django-ci-cd
                
                # Шлях до файлу відповідно до структури вашого проекту
                VALUE_FILE="helm-chart/django-app/values.yaml"
                
                echo "Updating file: \$VALUE_FILE"
                sed -i 's|tag:.*|tag: \"${IMAGE_TAG}\"|' \$VALUE_FILE
                
                # Налаштування Git
                git config user.email 'jenkins@jenkins.com'
                git config user.name 'Jenkins'
                git remote set-url origin https://${GIT_USER}:${GIT_TOKEN}@github.com/nata87/ci-cd-devops-hw.git
                
                # Коміт та Push тільки якщо файл було змінено
                if [ -n "\$(git status --porcelain)" ]; then
                    git add \$VALUE_FILE
                    git commit -m 'Jenkins update image tag to ${IMAGE_TAG}'
                    git push origin main
                else
                    echo "No changes detected, skipping push."
                fi
              """
            }
          }
        }
      }
    }
  }
}