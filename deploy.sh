IMAGE_NAME="sniaregistry.azurecr.io/emulator:latest"
#IMAGE_NAME="venkatarr/emulator"
docker build . -t $IMAGE_NAME
#docker login -u venkatarr -p $DOCKER_HUB
docker login sniaregistry.azurecr.io -u SniaRegistry -p drQPORZNaKUVJyeIMT5KCidI7Br=UIJV
docker push $IMAGE_NAME
#IMAGE_NAME="venkatarr/emulator:${BUILD_NUMBER}"
#IMAGE_NAME="venkatarr/emulator"
#kubectl run emulator --image=$IMAGE_NAME --port=5000
kubectl create -f /home/ramana/workspace/SNIA_AZURE/depemu.yaml
kubectl create -f /home/ramana/workspace/SNIA_AZURE/depserv.yaml
