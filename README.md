### Python with Nginx image

This image only containe python, nginx and supervisor.

You need to install your server (uwsgi or other)

Feel free to override the nginx and supervisor files.

## Supported tags and respective `Dockerfile` links

* [`python3.8`, `latest` _(Dockerfile)_]()

# python-nginx

**Docker** image with **Python** and **Nginx** for web applications in **Python 3.8** and above, in a single container.


## Description

This [**Docker**](https://www.docker.com/) image allows you to create [**Python**](https://www.python.org/) web applications that run with [**Nginx**](http://nginx.org/en/) in a single container.

The combination of uWSGI with Nginx is a [common way to deploy Python web applications like Flask and Django](http://flask.pocoo.org/docs/1.0/deploying/uwsgi/). It is widely used in the industry and would give you decent performance. (*)

### * Note on performance and features

If you are starting a new project, you might benefit from a newer and faster framework based on ASGI instead of WSGI (Flask and Django are WSGI-based).

You could use an ASGI framework like:

* [**FastAPI**](https://github.com/tiangolo/fastapi) (which is based on Starlette) with this Docker image: [**tiangolo/uvicorn-gunicorn-fastapi**](https://github.com/tiangolo/uvicorn-gunicorn-fastapi-docker).
* [**Starlette**](https://github.com/encode/starlette) directly, with this Docker image: [**tiangolo/uvicorn-gunicorn-starlette**](https://github.com/tiangolo/uvicorn-gunicorn-starlette-docker).
* Or any other ASGI framework with this Docker image: [**tiangolo/uvicorn-gunicorn**](https://github.com/tiangolo/uvicorn-gunicorn-docker).

FastAPI, or Starlette, would give you about 800% (8x) the performance achievable with this image (**tiangolo/uwsgi-nginx**). [You can see the third-party benchmarks here](https://www.techempower.com/benchmarks/#section=test&runid=a979de55-980d-4721-a46f-77298b3f3923&hw=ph&test=fortune&l=zijzen-7).

Also, if you want to use new technologies like WebSockets it would be easier (and *possible*) with a newer framework based on ASGI, like FastAPI or Starlette. As the standard ASGI was designed to be able to handle asynchronous code like the one needed for WebSockets.


## How to use

* You shouldn't have to clone the GitHub repo. You should use it as a base image for other images, using this in your `Dockerfile`:

```Dockerfile
FROM er5bus/python-nginx:python3.8

# Your Dockerfile code...

```
* By default it will try to find a uWSGI config file in `/tmp/uwsgi.ini`.

## Advanced usage

## Technical details

The combination of uWSGI with Nginx is a [common way to deploy Python web applications](http://flask.pocoo.org/docs/1.0/deploying/uwsgi/).

Roughly:

* **Nginx** is a web server, it takes care of the HTTP connections and also can serve static files directly and more efficiently.

* **uWSGI** is an application server, that's what runs your Python code and it talks with Nginx.

* **Your Python code** has the actual web application, and is run by uWSGI.

This image takes advantage of already slim and optimized existing Docker images (based on Debian as [recommended by Docker](https://docs.docker.com/engine/userguide/eng-image/dockerfile_best-practices/)) and implements Docker best practices.

It uses the official Python Docker image, installs uWSGI and on top of that, with the least amount of modifications, adds the official Nginx image (as of 2016-02-14).

And it controls all these processes with Supervisord.

---

There's the rule of thumb that you should have "one process per container".

That helps, for example, isolating an app and its database in different containers.

But if you want to have a "micro-services" approach you may want to [have more than one process in one container](https://valdhaus.co/writings/docker-misconceptions/) if they are all related to the same "service", and you may want to include your Flask code, uWSGI and Nginx in the same container (and maybe run another container with your database).

That's the approach taken in this image.

---


## Tests

All the image tags, configurations, environment variables are tested.

## Updates

Updates are announced in the releases.

You can click the "watch" button at the top right and select "Releases only" to receive an email notification when there's a new release.

## License

This project is licensed under the terms of the Apache license.
