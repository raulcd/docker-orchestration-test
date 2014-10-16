FROM ubuntu
RUN apt-get update
RUN apt-get install -y nginx python-pip
RUN mkdir -p /usr/local/code
ADD . /usr/local/code
WORKDIR /usr/local/code
RUN pip install -r requirements.txt
RUN echo "daemon off;" >> "/etc/nginx/nginx.conf"
WORKDIR /usr/local/code/scripts
EXPOSE 80
CMD ./entrypoint.sh
