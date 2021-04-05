# Argo CD-GitOps for Kubernetes
Argo CD is a declarative, GitOps continuous delivery tool for Kubernetes.

## How it works
Argo CD follows the GitOps pattern of using Git repositories as the source of truth for defining the desired application state.

## Note:
This project has been tested on a GKE cluster, but can work on any cluster.

## Requirements
With the command helm version, make sure that you have:
* Helm v3 [installed](https://helm.sh/docs/intro/)
## Provider
* Helm
* Kubernetes

## Create GKE cluster
```
gcloud container clusters create cluster_name --project project_name --zone zone_name
```

## Connect to the Cluster
* Get the kubeConfig file of the cluster

```
gcloud container clusters get-credentials cluster_name --zone zone_name --project project_name
```

I used Helm and kubernetes provider in Terraform to install and configure Argocd
