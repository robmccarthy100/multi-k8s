docker build -t robmccarthy/multi-client:latest -t robmccarthy/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t robmccarthy/multi-server:latest -t robmccarthy/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t robmccarthy/multi-worker:latest -t robmccarthy/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push robmccarthy/multi-client:latest
docker push robmccarthy/multi-server:latest
docker push robmccarthy/multi-worker:latest

docker push robmccarthy/multi-client:$SHA
docker push robmccarthy/multi-server:$SHA
docker push robmccarthy/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=robmccarthy/multi-client:$SHA
kubectl set image deployments/server-deployment server=robmccarthy/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=robmccarthy/multi-worker:$SHA
