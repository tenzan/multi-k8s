docker build -t tenzan/multi-client:latest -t tenzan/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t tenzan/multi-server:latest -t tenzan/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t tenzan/multi-worker:latest -t tenzan/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push tenzan/multi-client:latest
docker push tenzan/multi-server:latest
docker push tenzan/multi-worker:latest

docker push tenzan/multi-client:$SHA
docker push tenzan/multi-server:$SHA
docker push tenzan/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=tenzan/multi-client:$SHA
kubectl set image deployments/server-deployment server=tenzan/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=tenzan/multi-worker:$SHA