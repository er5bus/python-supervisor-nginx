### Supervisor, Python with Nginx

This image only containe python, nginx and supervisor. 
Use it as base image for Monolithic application.

You need to install your server (uwsgi or other)

Feel free to override the nginx and supervisor files.

## Supported tags and respective `Dockerfile` links

* [`python3.7`, `python3.8`, `python3.9` _(Dockerfile)_]()

**Docker** image with **Supervisor**, **Python** and **Nginx** for web applications in **Python 3.8** and above, in a single container.

## Description

This [**Docker**](https://www.docker.com/) image allows you to create [**Python**](https://www.python.org/) web applications that run with [**Nginx**](http://nginx.org/en/) in a single container.

The combination of uWSGI with Nginx is a [common way to deploy Python web applications like Flask and Django](http://flask.pocoo.org/docs/1.0/deploying/uwsgi/). It is widely used in the industry and would give you decent performance. (*)

## How to use

* You shouldn't have to clone the GitHub repo. You should use it as a base image for other images, using this in your `Dockerfile`:

```Dockerfile
FROM er5bus/python-supervisor-nginx:python3.8

# Your Dockerfile code...

```
* Specify your uWSGI config file in `UWSGI_INI` env variable.
* Specify your nginx configuration
* Feel free to override supervisor file 

## Tests

All the image tags, configurations, environment variables are tested.

## License

This project is licensed under the terms of the Apache license.
