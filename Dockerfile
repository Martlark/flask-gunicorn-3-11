FROM python:3.11.4-bullseye

# runs from this dir
WORKDIR /app

# upgrade pip
RUN pip install -U pip

# gunicorn and SQL utils
RUN pip install gunicorn[eventlet]==20.1.0
RUN pip install sqlalchemy-utils==0.40.0

COPY . /app

RUN mkdir -p /persist

EXPOSE 80

# start server

ENTRYPOINT [ "bash", "entrypoint.sh" ]


# add these Docker commands to:
# * copy requirements.txt file
# * install your requirements
# * copy your app files
#
# FROM flask-gunicorn-3-11
# COPY requirements.txt /tmp/
# RUN pip install -r /tmp/requirements.txt
# COPY . /app
