# Installing Istio

## Prepare the Environment
You’ll need a Kubernetes cluster to proceed. If you don’t have a cluster, you can use kind or any other supported Kubernetes platform.

These steps require you to have a cluster running a supported version of Kubernetes (1.27, 1.28, 1.29, 1.30).

### Install Kind and create a local cluster
A tool for running local Kubernetes clusters, by following the Kind installation guide.
https://kind.sigs.k8s.io/docs/user/quick-start/

```bash
# Install Kind with Homebrew ( Mac Package Manager)
brew install kind

# Create a local cluster
kind create cluster --name istio-cluster
```

### Install Kubectl 
Follow kubectl’s installation guide to set it up for managing your Kind cluster
https://kubernetes.io/docs/tasks/tools/#kubectl

```bash 
brew install kubectl

# Test to ensure the version you installed is up to date
kubectl version --client
```

### Install Helm 
Install Helm, which is useful for managing Istio and other Kubernetes packages, by following the Helm installation guide
https://helm.sh/docs/intro/install/

```bash
brew install helm

# Verify the version
helm version
```

## Prerequisites: 
Before we install, let’s review the prerequisites

1. Download the Istio release
2. Complete any platform-specific setups.
3. Install or upgrade the Kubernetes Gateway API CRDs if your cluster doesn’t already include them.

### Download Istio Release

We’ll first download the Istio command-line tool, istioctl, then install Istio in our Kubernetes cluster using the ambient profile.

After installation, we'll verify that Istio’s core components, such as Istiod and Ztunnel, are running and configured correctly to manage traffic in our mesh.

In this segment, we’ll download the Istio release archive, which includes essential components like the istioctl binary, Helm charts, installation profiles, and sample applications such as Bookinfo, then install Istio in our Kubernetes cluster using the ambient profile. Istio is configured using a command line tool called istioctl. 


Let’s the following steps to go through the download and verification process:

```bash
#To get the latest Istio release, use:
curl -L https://istio.io/downloadIstio | sh -

#For a specific version, specify both the version and architecture like below 

curl -L https://istio.io/downloadIstio | ISTIO_VERSION=1.23.2 TARGET_ARCH=x86_64 sh -

# After downloading, move to the package directory and add istioctl to your path to access it easily.
# For example, if the package is istio-1.23.2:, run 
cd istio-1.23.2

# Add the istioctl client to your path (Linux or macOS):
export PATH=$PWD/bin:$PATH

# Verifying the Istio CLI Installation: Let's make sure that the Istio CLI is working correctly. I’ll check the version with this command
istioctl version

```

### Complete any platform-specific setups:

Certain Kubernetes environments require you to set various Istio configuration options to support them. (show the official link with the different platform and prerequisites link below )


## Install or Upgrade the k8s Gateway API CRDs

*Note* That the Kubernetes Gateway API CRDs do not come installed by default on most Kubernetes clusters, so make sure they are installed before using the Gateway API, so I’ll run this command to install them.
We will use the Kubernetes Gateway API to configure traffic routing


```bash
kubectl get crd gateways.gateway.networking.k8s.io &> /dev/null || \
  { kubectl apply -f https://github.com/kubernetes-sigs/gateway-api/releases/download/v1.1.0/standard-install.yaml\ }

```

## Installing Istio
Next, it’s time to install Istio in our cluster. I’ll use this command to install it with the ambient profile. 

After installation, we'll verify that Istio’s core components, such as Istiod and Ztunnel, are running and configured correctly to manage traffic in our mesh.

```bash
istioctl install --set profile=ambient --skip-confirmation
```

Installation might take a minute, but once it’s done, we should see a confirmation that all components have been successfully installed.


## Verifying the Installation
To ensure everything is set up correctly, let’s verify the installation with this command

```bash
istioctl verify-install
```

Awesome! We have successfully installed Istio with support for ambient mode.

Let's confirm the Istio components are running 
Use the following command to verify that the Istio components (such as Istiod and Ztunnel) are running in the istio-system namespace.

```bash
kubectl get pods -n istio-system

```

