echo "Remove previous docker containers"
running_containers=`docker ps -a | awk {'print $1"\t"$2'} | grep -e 'nginx' -e 'django' -e 'flask' | awk {'print $1'}`
for i in $running_containers
do
    echo "Stopping cotainer id: " $i
    docker stop $i 1>/dev/null
    echo "Removing container id:" $i
    docker rm $i 1>/dev/null
done
# Postgres image exposes port 5432
docker run --name db -d postgres
docker build -t django:latest ./django-docker/
docker run --link db:db django python manage.py migrate 
docker run -d -p 8000:8000 --link db:db --name web_backend -v `pwd`/django-docker/:/code django python manage.py runserver 0.0.0.0:8000
docker build -t flask:latest ./flask-docker/
docker run -p 5000:5000 --name search_backend flask &
sleep 3
docker build -t nginx:latest ./nginx-docker/
docker run -d -p 80:80 --link web_backend:web_backend --link search_backend:search_backend --name nginx nginx
