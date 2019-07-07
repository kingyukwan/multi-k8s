docker build -t ufo843/multi-client:lastest -t ufo843/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t ufo843/multi-server:lastest -t ufo843/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t ufo843/multi-worker:lastest -t ufo843/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push ufo843/multi-client:lastest
docker push ufo843/multi-server:lastest
docker push ufo843/multi-worker:lastest

docker push ufo843/multi-client:$SHA
docker push ufo843/multi-server:$SHA
docker push ufo843/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=ufo843/multi-server:$SHA
kubectl set image deployments/client-deployment client=ufo843/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=ufo843/multi-worker:$SHA