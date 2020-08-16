docker build -t vasanthsumanath/multi-client:latest -t vasanthsumanath/multi-client:${SHA} ./client
docker build -t vasanthsumanath/multi-server:latest -t vasanthsumanath/multi-server:${SHA} ./server
docker build -t vasanthsumanath/multi-worker:latest -t vasanthsumanath/multi-worker:${SHA} ./worker

docker push vasanthsumanath/multi-client:latest
docker push vasanthsumanath/multi-server:latest
docker push vasanthsumanath/multi-worker:latest
docker push vasanthsumanath/multi-client:${SHA}
docker push vasanthsumanath/multi-server:${SHA}
docker push vasanthsumanath/multi-worker:${SHA}

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=vasanthsumanath/multi-server:${SHA}
kubectl set image deployments/client-deployment client=vasanthsumanath/multi-client:${SHA}
kubectl set image deployments/worker-deployment worker=vasanthsumanath/multi-worker:${SHA}
