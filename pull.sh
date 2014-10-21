if [ "$#" -ne 1 ]; then
    echo "The script needs only one argument which is the name of the tag"
    exit 1
fi

DOCKER_REGISTRY=10.9.3.206:5000
i
echo "Remove previous docker containers if they exist"
running_containers=`docker ps -a | awk {'print $1"\t"$2'} | grep -e 'nginx' -e 'django' -e 'flask' | awk {'print $1'}`
for i in $running_containers
do
    echo "Stopping cotainer id: " $i
    docker stop $i 1>/dev/null
    echo "Removing container id:" $i
    docker rm $i 1>/dev/null
done

echo "Starting postgres:latest Container"
docker run --name db -d postgres
echo "Starting django:"$1" Container"
docker run --link db:db $DOCKER_REGISTRY/django:$1 python manage.py migrate 
docker run -d -p 8000:8000 --link db:db --name web_backend -v `pwd`/django-docker/:/code $DOCKER_REGISTRY/django:$1 python manage.py runserver 0.0.0.0:8000
echo "Starting flask:"$1" Container"
docker run -d -p 5000:5000 --name search_backend  $DOCKER_REGISTRY/flask:$1
echo "Starting nginx:"$1" Container"
docker run -d -p 80:80 --link web_backend:web_backend --link search_backend:search_backend --name nginx $DOCKER_REGISTRY/nginx:$1

