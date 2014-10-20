Docker Orchestration
====================

This is a simple example of how to orchestrate some of 
your Docker containers.

The next diagram shows the 4 different containers that are orchestrated 
on this example, and the links between them:

           ========
          |        |
          | Nginx  |
          |        |
           ========
           /      \
          /        \
     ========      ========
    |        |    |        |
    | Django |    | Flask  |
    |        |    |        |
     ========      ========
        |
        |
     ========
    |        |
    |   DB   |
    |        |
     ========


Nginx port 80 will be exported to localhost and:

http://localhost --> There is a Proxy Pass that redirects everything (except /search) to the Django App
http://localhost/search --> There is a Proxy Pass that redirects everything under /search to the Flask App

Requirements
============

You will need to have docker installed

Usage
=====

To build your containers just run the ```build.sh``` script.
This generate the docker images and run the different containers 
with their links.

The build.sh script removes (if they exist) the previous containers.

```
./build.sh
```

Clean utility
=============

I have found a nice utility from [@davide-ceretti](https://github.com/davide-ceretti):

https://github.com/davide-ceretti/scripts/blob/master/reset_docker.sh

which cleans all the images and containers.

This will remove all your image and containers so use with caution

```
./clean.sh
```
