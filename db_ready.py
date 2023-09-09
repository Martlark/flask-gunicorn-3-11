"""
Script to wait for the database to be ready.  Often when db starts at the same time as the
main app you have to wait for it to become ready.
"""
import os
import sys
import time

from dotenv import load_dotenv
from sqlalchemy_utils import database_exists
from config import Config
import logging

if os.path.isfile(".env"):
    print("reading .env config")
    load_dotenv()

logging.basicConfig(
    format="%(levelname)s:%(message)s", level=os.getenv("LOG_LEVEL", "INFO")
)

db_uri = os.getenv("SQLALCHEMY_DATABASE_URI")
retries = int(os.getenv("DB_READY_RETRIES", 20))
sleep_seconds = float(os.getenv("DB_READY_SLEEP_SECONDS", 2))
count = 0

while True:
    count += 1
    try:
        logging.info(f"Connecting to local admin db")
        time.sleep(sleep_seconds)
        database_exists(db_uri)
        logging.info(f"Database ready after {sleep_seconds*count} seconds")
        break
    except Exception as e:
        logging.exception(e)
        if count >= retries:
            logging.info(f"db_ready retries {retries} exceeded.  Database not ready")
            sys.exit(1)
