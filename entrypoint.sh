#!/bin/sh
# exit if any errors
set -e

if [ -x "/persist/before.sh" ]
then
  . "/persist/before.sh"
fi
# shellcheck disable=SC2086
export PYTHONPATH="${PYTHONPATH}:."
# shellcheck disable=SC2039
if [ -v SQLALCHEMY_DATABASE_URI ]
then
  # do any db requirements
  # setup before db
  if [ -x "/persist/before_db.sh" ]
  then
    . "/persist/before_db.sh"
  fi
  # wait for the database to be ready
  python db_ready.py
  # apply any upgrades
  export FLASK_APP=${FLASK_APP:-main.py}
  ${FLASK_DB_UPGRADE:-flask db upgrade}
  #
  # setup after db
  if [ -x "/persist/after_db.sh" ]
  then
    . "/persist/after_db.sh"
  fi
fi
# start the server
gunicorn -c gunicorn_conf.py "${GUNICORN_MAIN:-main:app}" --threads "${GUNICORN_THREADS:-2}" -b 0.0.0.0:80
