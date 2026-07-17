resource "helm_release" "argocd" {
  name             = "argo-cd"
  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argo-cd"
  namespace        = "argocd"
  create_namespace = true
  version          = "6.0.0" 
  wait       = false  # Додайте це!
  timeout    = 600
  

 values = [
    <<-EOT
    server:
      service:
        type: LoadBalancer
    controller:
      persistence:
        enabled: false
    repoServer:
      persistence:
        enabled: false
    EOT
  ]
}