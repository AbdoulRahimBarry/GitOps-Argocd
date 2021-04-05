###################################################
##                                               ##
##         INSTALLATION ARGOCD VIA HELM          ##
##                                               ##
###################################################

provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}

provider "kubernetes" {
  config_path    = "~/.kube/config"
  config_context = "user to context ==> kubectl config current-context"
}

resource "kubernetes_namespace" "argocd" {
  metadata {
    annotations = {
      name      = "argocd"
    }
    name        = "argocd"
  }
}

resource "kubernetes_namespace" "france" {
  metadata {
    annotations = {
      name      = "france"
    }
    name        = "france"
  }
}

resource "helm_release" "argocd" {
  name       = "argocd"
  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"

  values = [
   file("values.yaml")
  ]

   depends_on = [ kubernetes_secret.ssh-repos, kubernetes_namespace.argocd ]
   namespace  = kubernetes_namespace.argocd.metadata[0].name

}

resource "kubernetes_secret" "ssh-repos" {
  metadata {
    name = "ssh-repos"
    namespace  = kubernetes_namespace.argocd.metadata[0].name
  }

  data = {
     "githubPrivateKey" = file(pathexpand("~/.ssh/id_rsa"))
  }
   depends_on = [ kubernetes_namespace.argocd ]
}

resource "kubernetes_secret" "resistry-gcr" {
  metadata {
    name = "resistry-gcr"
    namespace  = kubernetes_namespace.france.metadata[0].name
  }

  data = {
    ".dockerconfigjson" = file(pathexpand("~/.docker/config.json"))
  }
  type = "kubernetes.io/dockerconfigjson"
  depends_on = [ kubernetes_namespace.france ]

}
