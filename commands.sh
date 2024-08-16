minikube start --cpus 4 --memory 8192
minikube addons enable metrics-server
minikube dashboard

mvn spring-boot:build-image -Pnative

minikube image load client:1.0.0

kubectl config set-context --current --namespace=spring-app
kubectl run spring-app --image=spring-app:0.0.2 --port=8080 --image-pull-policy Never

kubectl create deployment spring-app --port=8080 --image=spring-app:0.0.2
kubectl apply -f deployment.yaml

#kubectl get deployments
#kubectl get pods
#kubectl logs <pod id>
kubectl expose deployment spring-app --type=NodePort

minikube ssh
nc -vz host.minikube.internal 5432
ping host.minikube.internal
minikube service --all -n spring-app
minikube service client-service -n spring-app --url

#kubectl get services
kubectl delete -n spring-app pod
kubectl delete -n spring-app service spring-app-service

kubectl create clusterrolebinding service-reader-pod --clusterrole=service-reader --serviceaccount=default:default

kubectl create secret generic db-secret --from-literal=username=postgres --from-literal=password=12345

minikube addons enable ingress
minikube tunnel
minikube ip

kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.15.2/cert-manager.yaml
kubectl apply -f https://github.com/open-telemetry/opentelemetry-operator/releases/latest/download/opentelemetry-operator.yaml
