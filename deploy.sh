docker build -t ngrieco/multi-client:latest -t ngrieco/multi-client:latest:$SHA -f ./client/Dockerfile ./client
docker build -t ngrieco/multi-server:latest -t ngrieco/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t ngrieco/multi-worker:latest -t ngrieco/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push ngrieco/multi-client:latest
docker push ngrieco/multi-server:latest
docker push ngrieco/multi-worker:latest

docker push ngrieco/multi-client:$SHA
docker push ngrieco/multi-server:$SHA
docker push ngrieco/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=ngrieco/multi-server:$SHA
kubectl set image deployments/client-deployment server=ngrieco/multi-client:$SHA
kubectl set image deployments/worker-deployment server=ngrieco/multi-worker:$SHA