# Argo CD - Declarative GitOps CD for Kubernetes
Argo CD is a declarative, GitOps continuous delivery tool for Kubernetes.

Application definitions, configurations, and environments should be declarative and version controlled

## How it works
Argo CD follows the GitOps pattern of using Git repositories as the source of truth for defining the desired application state.

For this project the kubernetes manifest has been specified in:

- Plain directory of YAML manifests
- [kustomize](https://kustomize.io/) applications

Argo CD is implemented as a kubernetes controller which continuously monitors running applications and compares the current, live state against the desired target state (as specified in the Git repo)

## Prerequisites
To automate the deployment of Argocd and maintain the state of the infrastructure, we will use terraform for installation.
- Download the binaries [Terraform](https://www.terraform.io/downloads.html) and move then in `/usr/local/bin`
- Install the binairie kubeclt

## Installation

1. Clone the project [here](https://github.com/telemaqueHQ/DevOps)
2. move to `DevOps/terraform/argocd/front/staging`
3. Edit:
	config_context
4. make sure you have:
	ssh-key in `$HOME/.ssh/id_rsa` with the name or change the ssh-key name
5. make sure you have kubeconfig file in the same path

## Description
I installed argo with [argocd helm](https://github.com/argoproj/argo-helm) and [chart](https://github.com/argoproj/argo-helm/tree/master/charts/argo-cd)
I advise you to look at the values.yaml file in order to understand the overload variables
1. namespace argocd: allows to deploy argocd application
2. ssh-repos: allows to load the repositories where the manifests are located to deploy the applications in argocd
3. resistry-gcr: secret to connect to the google container registry

## How to run the application
1. move to `DevOps/terraform/argocd/front/staging`
2. run the command line:
	- `terraform init`
	- `terraform plan`
	- `terraform apply`

## How to tests

run the command line `kubectl -n argocd port-forward service/argocd-server 8080:80`

You can get the dashboard on your browser by typing `localhost:8080`

**User:** admin
**Password:** Pod_name-argocd-server,(e.g argocd-server-8775454bb-vhn88)

## Other elements
To complete the CICD chain, here is the continuous integration chain with [jenkins](https://github.com/telemaqueHQ/DevOps/tree/master/terraform/jenkins)

## Reference
1. Argocd [documentation](https://argoproj.github.io/argo-cd/)
2. argoproj [argocd-helm](https://github.com/argoproj/argo-helm)
