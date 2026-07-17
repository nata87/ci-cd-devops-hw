resource "helm_release" "jenkins" {
  name             = "jenkins"
  repository       = "https://charts.jenkins.io"
  chart            = "jenkins"
  namespace        = "jenkins"
  create_namespace = true
  version          = "5.7.2" # Використовуйте версію колеги для стабільності
  wait             = false
  timeout          = 600

  
  values = [
    file("${path.module}/values.yaml")
  ]
}