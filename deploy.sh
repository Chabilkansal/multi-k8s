docker build -t chabil/multi-client:latest -t chabil/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t chabil/multi-server:latest -t chabil/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t chabil/multi-worker:latest -t chabil/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push chabil/multi-client:latest
docker push chabil/multi-server:latest
docker push chabil/multi-worker:latest

docker push chabil/multi-client:$SHA
docker push chabil/multi-server:$SHA
docker push chabil/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=chabil/multi-server:$SHA
kubectl set image deployments/client-deployment client=chabil/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=chabil/multi-worker:$SHA