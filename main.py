# start app for meinheld-gunicorn-flask-docker starter
# from /app

import os
import sys

from flask import Flask

app_path = "/app"
if os.path.isdir(app_path):
    sys.path.insert(0, app_path)
    os.chdir(app_path)

app = Flask(__name__)

@app.route('/')
def hello_world():
    return 'Hello, flask-gunicorn-3-11'