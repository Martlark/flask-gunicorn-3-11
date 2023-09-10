# flask-gunicorn-3-11
Python 3.11 Flask server using Gunicorn container.

Includes:

* Support for sqlalchemy
* Migration of database
* Gunicorn options
* Database pre and post start scripts
* Scripts to run before starting server

Upgrades to latest Pip, starts the DB, performs any
migrations to the database structure, then loads and runs Flask app using Gunicorn.

Assumes code starts from main.py using `app` as the application variable. 

NOTE: Flask and other package dependencies should be defined in your application's
`requirements.txt` file.  This image does not include Flask or SQLAlchemy by default.

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

#### Examples

Example Dockerfile and Python source can be found in the `martlark` directory.

## Options

Environment variables can be used to change the container startup process.

Container will check for scripts in the `/persist/` folder which
can be mapped into the container using the `volume` directive.

Docker compose volumes example:
    
    version: '3.7'
    
    services:
      app:
        build: martlark
        ports:
          - "18008:80"
        volumes:
          - ./persist:/persist
        environment:
          GUNICORN_THREADS: 4
        restart: unless-stopped


### Script to run before start

    /persist/before.sh

### Use SQLALCHEMY

Set environment variable SQLALCHEMY_DATABASE_URI to enable SQLAlchemy database use.

### Script to run before starting db and migration

    /persist/before_db.sh

### Options for waiting for db to start

When `SQLALCHEMY_DATABASE_URI` environment variable is set
the container will wait for the database to start
then run any migrations.

#### Retry attempts

Container will wait for the database to be ready and retry this many times.

    DB_READY_RETRIES=20

#### Seconds to wait between db ready retries

    DB_READY_SLEEP_SECONDS=2

### Flask application file

This environment variable defines the app to be used
for flask commands. By default, this is `main.py`.

    FLASK_APP=main.py

### Migration command

Migration will be done using `flask-migrate`. Reference: https://flask-migrate.readthedocs.io/en/latest/

For Alembic refer to their documentation. Reference: https://alembic.sqlalchemy.org/en/latest/index.html

If you do not want any migrations then set `FLASK_DB_UPGRADE` to `true`.

Override the migration command when not using `flask-migrate`.

    FLASK_DB_UPGRADE="flask db upgrade"

### Script to run after starting db and migration

Run a script after the database is up and migration is completed.

    /persist/after_db.sh

###   Gunicorn configuration

Options to control how Gunicorn is started.

#### Flask python app module and `app` variable

Use this environment variable to change the default value of `main:app`.

    GUNICORN_MAIN="main:app"

#### Number of threads

Use this environment variable to change the default value of `2`.

    GUNICORN_THREADS="2"

#### Server Port

    Exposed port is always 80
