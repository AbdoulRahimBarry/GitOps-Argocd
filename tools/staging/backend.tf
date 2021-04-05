terraform {
  backend "gcs" {
    bucket  = "devops-clusters-state"
    prefix  = "terraform/state/argocd/tools/staging"
  }
}