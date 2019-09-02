docker build -t doutside/multi-client:latest -t doutside/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t doutside/multi-server:latest -t doutside/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t doutside/multi-worker:latest -t doutside/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push doutside/multi-client:latest
docker push doutside/multi-server:latest
docker push doutside/multi-worker:latest

docker push doutside/multi-client:$SHA
docker push doutside/multi-server:$SHA
docker push doutside/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=doutside/multi-server:$SHA
kubectl set image deployments/client-deployment client=doutside/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=doutside/multi-worker:$SHA