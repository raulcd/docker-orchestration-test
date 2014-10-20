FROM python:2.7
ADD . /code
WORKDIR /code
RUN pip install -r requirements.txt
RUN apt-get update
RUN pip install gunicorn
EXPOSE 5000
CMD gunicorn -b 0.0.0.0:5000 api:app
