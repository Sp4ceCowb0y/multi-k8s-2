docker build -t rfiguerasdegea/multi-client:latest -t rfiguerasdegea/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t rfiguerasdegea/multi-server:latest -t rfiguerasdegea/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t rfiguerasdegea/multi-worker:latest -t rfiguerasdegea/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push rfiguerasdegea/multi-client:latest
docker push rfiguerasdegea/multi-server:latest
docker push rfiguerasdegea/multi-worker:latest

docker push rfiguerasdegea/multi-client:$SHA
docker push rfiguerasdegea/multi-server:$SHA
docker push rfiguerasdegea/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=rfiguerasdegea/multi-server:$SHA
kubectl set image deployments/client-deployment client=rfiguerasdegea/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=rfiguerasdegea/multi-worker:$SHA
