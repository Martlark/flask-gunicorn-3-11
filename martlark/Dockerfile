FROM martlark/flask-gunicorn-3-11:latest

# copy over our requirements.txt file
COPY requirements.txt /tmp/
# install required python packages
RUN pip install -r /tmp/requirements.txt

# copy over our app code
COPY . /app
