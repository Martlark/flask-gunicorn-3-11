# flask-gunicorn-3-11
Python 3.11 Flask server using Gunicorn container.

Includes:

* Support for sqlalchemy
* Migration of database
* Gunicorn options
* Database pre and post start scripts
* Scripts to run before starting server

Upgrades to latest Pip, Installs from `requirements.txt`, starts the DB, performs any
migrations to the database structure, then loads and runs Flask app using Gunicorn.

## Example Dockerfile

    FROM martlark/flask-gunicorn-3-11

Assumes code starts from main.py using `app` as the application variable. 

### Example main.py
    
    # start app for flask-gunicorn-3-11
    # from /app
    
    import os
    
    from app.app import create_app
    
    
    app_path = "/app"
    if os.path.isdir(app_path):
        sys.path.insert(0, app_path)
        os.chdir(app_path)
    
    app = create_app()

### Example Dockerfile
    
    FROM flask-gunicorn-3-11
    
    # copy over our requirements.txt file
    COPY requirements.txt /tmp/
    # install required python packages
    RUN pip install -r /tmp/requirements.txt
    
    # copy over our app code
    COPY . /app
    

## Options

### Script to run before start

    /persist/before.sh

### Use SQLALCHEMY

Set environment variable SQLALCHEMY_DATABASE_URI to enable SQLalchemy use.

### Script to run before starting db and migration

    /persist/before_db.sh

### Options for waiting for db to start

#### Retry attempts

    DB_READY_RETRIES=20

#### Seconds to wait between retries

    DB_READY_SLEEP_SECONDS=2

### Flask application file

    FLASK_APP=main.py

### Migration command

Override the migration command.

    FLASK_DB_UPGRADE=flask db upgrade

### Script to run before starting db and migration

Run a script after the database is up and migration is completed.

    /persist/after_db.sh

###   Gunicorn configuration

Options to control how Gunicorn is started.

#### Flask python app module and `app` variable

    GUNICORN_MAIN="main:app"

#### Number of threads

    GUNICORN_THREADS="2"

#### Server Port

    Exposed port is always 80
