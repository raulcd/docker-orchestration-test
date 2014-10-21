FROM python:2.7
RUN apt-get update
ADD . /code
WORKDIR /code
RUN pip install -r requirements.txt
EXPOSE 5000
CMD gunicorn -b 0.0.0.0:5000 api:app
