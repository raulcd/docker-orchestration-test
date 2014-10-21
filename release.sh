if [ "$#" -ne 1 ]; then
    echo "The script needs only one argument which is the name of the tag"
    exit 1
fi
DOCKER_REGISTRY=10.9.3.206:5000
echo "Generating new Release"
echo "Building and uploading to "$DOCKER_REGISTRY" django:"$1" tag"
docker build -t $DOCKER_REGISTRY/django:$1 ./django-docker/
docker push $DOCKER_REGISTRY/django:$1
echo "Building and uploading to "$DOCKER_REGISTRY" flask:"$1" tag"
docker build -t $DOCKER_REGISTRY/flask:$1 ./flask-docker/
docker push $DOCKER_REGISTRY/flask:$1
echo "Building and uploading to "$DOCKER_REGISTRY" nginx:"$1" tag"
docker build -t $DOCKER_REGISTRY/nginx:$1 ./nginx-docker/
docker push $DOCKER_REGISTRY/nginx:$1
