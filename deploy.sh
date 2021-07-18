docker build -t alextrep/multi-client:latest -t alextrep/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t alextrep/multi-server:latest -t alextrep/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t alextrep/multi-worker:latest -t alextrep/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push alextrep/multi-client:latest
docker push alextrep/multi-server:latest
docker push alextrep/multi-worker:latest

docker push alextrep/multi-client:$SHA
docker push alextrep/multi-server:$SHA
docker push alextrep/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=alextrep/multi-client:$SHA
kubectl set image deployments/server-deployment server=alextrep/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=alextrep/multi-worker:$SHA