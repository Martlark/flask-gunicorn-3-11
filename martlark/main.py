# example start app for martlark/flask-gunicorn-3-11:latest

import datetime
import os
import sys

DOCKER_TAG = "flask-gunicorn-3-11-martlark"

from flask import Flask

app = Flask(__name__)


@app.route("/")
def hello_world():
    today = datetime.datetime.utcnow()
    return f"Hello, Running from docker martlark {DOCKER_TAG}.  It is {today}"
