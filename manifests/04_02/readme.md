kubectl create ns bar 

kubectl label namespace bar istio.io/dataplane-mode=ambient

kubectl apply -f your-httpbin-deployment.yaml

kubectl exec "$(kubectl get pod -l app=curl -n bar -o jsonpath={.items..metadata.name})" -n bar -- curl "http://productpage.bookinfo:9080" -s -o /dev/null -w "%{http_code}\n"

for from in "foo" "bar" "legacy"; do for to in "foo" "bar" "legacy"; do kubectl exec "$(kubectl get pod -l app=curl -n ${from} -o jsonpath={.items..metadata.name})" -c curl -n ${from} -- curl "http://httpbin.${to}:8000/ip" -s -o /dev/null -w "curl.${from} to httpbin.${to}: %{http_code}\n"; done; done
