FROM python:3.11.4-bullseye

# runs from this dir
WORKDIR /app

# upgrade pip
RUN pip install -U pip

# gunicord and utils
RUN pip install gunicorn==20.1.0 rq
RUN pip install sqlalchemy-utils==0.40.0

# copy over our requirements.txt file
COPY requirements.txt /tmp/
# install required python packages
RUN pip install -r /tmp/requirements.txt

# copy over our app code
COPY . /app

RUN mkdir -p /persist

# start server

ENTRYPOINT [ "bash", "entrypoint.sh" ]
