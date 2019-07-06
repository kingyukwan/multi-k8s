docker build -t kingyukwan/multi-client:lastest -t kingyukwan/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t kingyukwan/multi-server:lastest -t kingyukwan/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t kingyukwan/multi-worker:lastest -t kingyukwan/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push kingyukwan/multi-client:lastest
docker push kingyukwan/multi-server:lastest
docker push kingyukwan/multi-worker:lastest

docker push kingyukwan/multi-client:$SHA
docker push kingyukwan/multi-server:$SHA
docker push kingyukwan/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=kingyukwan/multi-server:$SHA
kubectl set image deployments/client-deployment client=kingyukwan/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=kingyukwan/multi-worker:$SHA