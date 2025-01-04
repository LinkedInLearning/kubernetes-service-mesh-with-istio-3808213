# Deploying Sample App  -  

## BookInfo Sample App deployment

```bash 
kubectl apply -f https://raw.githubusercontent.com/istio/istio/release-1.23/samples/bookinfo/platform/kube/bookinfo.yaml

kubectl apply -f https://raw.githubusercontent.com/istio/istio/release-1.23/samples/bookinfo/platform/kube/bookinfo-versions.yaml

```

Once done, we can verify that it’s up and running by checking our pods

```bash
kubectl get pods
```

After confirming the pods are running, our next step is to make the productpage service accessible externally using an ingress gateway.

Deploy and configure the ingress gateway

```bash
kubectl apply -f https://raw.githubusercontent.com/istio/istio/release-1.23/samples/bookinfo/gateway-api/bookinfo-gateway.yaml
```

And to make it work with our local environment, let’s annotate the gateway service to use the ClusterIP type instead of a load balancer. Here’s how to do that:

```bash
kubectl annotate gateway bookinfo-gateway networking.istio.io/service-type=ClusterIP --namespace=default
```

To check the status of the gateway, run:

```bash
kubectl get gateway
```

## Accessing the Application:

Now we’re ready to access the app! Run this command to set up port forwarding:

```bash
kubectl port-forward svc/bookinfo-gateway-istio 8080:80
```

Then, open a browser and go to http://localhost:8080/productpage to view the BookInfo application. The app should load, and as you refresh, you’ll notice that reviews and ratings change. That’s because Istio is distributing requests across different versions of the reviews service!


