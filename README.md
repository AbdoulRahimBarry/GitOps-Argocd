# Argo CD-GitOps for Kubernetes
This project allows you to install Argo CD, argo cd is a declarative, GitOps continuous delivery tool for Kubernetes.

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


## Installing Argo CD
Check in `value.yaml` the custom configurations

### Exposing the Argo CD dashboard
The dashboard access could be achieved through a port-forward
```
kubectl -n argocd port-forward svc/argocd-server 8080:443
```

Now head to http://127.0.0.1:8080 and you should be able to see the Argo CD dashboard

## Ingress controller, TLS and HTTPS access

If you want to manage external access to services in a cluster, TLS and HTTPS access [see here](https://github.com/AbdoulRahimBarry/traefik-cert-manager-letsencrypt)

## Exposing the Argo CD dashboard
You can access the dasboard in your owner dns.
Check `ingressroute.yaml` file to have example. Executed objects in order

## Usage

```
cd GitOps-Argocd/tools/staging/
terraform init
terraform plan
terraform apply
```

*If you want to manage external access to services in a cluster, TLS and HTTPS access*
```
kubectl apply -f certificate.yaml
kubectl apply -f ingressroute.yaml
```

## Reference
* [Argocd documentation](https://argoproj.github.io/argo-cd/)
* [argoproj argocd-helm](https://github.com/argoproj/argo-helm)
* [traefik-cert-manager-letsencrypt](https://github.com/AbdoulRahimBarry/traefik-cert-manager-letsencrypt)
