docker build -t sregor/fibomultiapp-client:latest -t sregor/fibomultiapp-client:$SHA -f ./client/Dockerfile ./client
docker build -t sregor/fibomultiapp-server:latest -t sregor/fibomultiapp-server:$SHA -f ./server/Dockerfile ./server
docker build -t sregor/fibomultiapp-worker:latest -t sregor/fibomultiapp-worker:$SHA -f ./worker/Dockerfile ./worker

docker push sregor/fibomultiapp-client:latest
docker push sregor/fibomultiapp-server:latest
docker push sregor/fibomultiapp-worker:latest

docker push sregor/fibomultiapp-client:$SHA
docker push sregor/fibomultiapp-server:$SHA
docker push sregor/fibomultiapp-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=sregor/multi-client:$SHA
kubectl set image deployments/server-deployment server=sregor/multi-server:$SHA
kubectl set image deployments/worker-deployment client=sregor/multi-worker:$SHA