# Goal 

## Step 1: Route all traffic to version 1 (v1) of the services to ensure consistent behavior.

## Step 2: Route traffic based on user identity (e.g., route Jason's traffic to reviews:v2 with star ratings).

- Open bookinfo app  http://localhost:80/productpage 

- Refresh the page multiple times to observe the default randomized routing behavior of Istio.

## Step 2

kubectl apply -f destination-rule-all.yaml

Verify the subsets are correctly defined

kubectl get destinationrules -o yaml



