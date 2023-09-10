# example start app for flask-gunicorn-3-11

import datetime
import os
import sys

DOCKER_TAG = "flask-gunicorn-3-11"

from flask import Flask

app = Flask(__name__)


@app.route("/")
def hello_world():
    today = datetime.datetime.utcnow()
    return f"Hello, {DOCKER_TAG}.  It is {today}"
