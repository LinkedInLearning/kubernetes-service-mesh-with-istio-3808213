#!/bin/bash

set -x

# Install Istio components
helm install istio-base istio/base -n istio-system --create-namespace --set defaultRevision=default --wait
helm install istiod istio/istiod --namespace istio-system --set profile=ambient --wait
helm install istio-cni istio/cni -n istio-system --set profile=ambient --wait
helm install ztunnel istio/ztunnel -n istio-system --wait
helm install istio-ingressgateway istio/gateway -n istio-ingress --create-namespace --wait

# Wait for Istio components to be up and running
echo "Waiting for Istio components to be deployed..."
kubectl wait --for=condition=available --timeout=600s deployment -n istio-system --all

# Check if Istio is installed correctly
helm ls -n istio-system
kubectl get pods -n istio-system

# Apply Bookinfo application
kubectl apply -f bookinfo-gateway.yaml -n bookinfo
kubectl apply -f bookinfo.yaml -n bookinfo

# Wait for the Bookinfo workload to be up and running
echo "Waiting for Bookinfo workload to be deployed..."
kubectl wait --for=condition=available --timeout=600s deployment -n bookinfo --all

# Apply PeerAuthentication for strict mTLS
kubectl apply -f PeerAuthentication.yaml -n bookinfo

echo "Istio installation and Bookinfo application completed successfully!"
