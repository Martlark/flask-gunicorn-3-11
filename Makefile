version := $(shell cat VERSION)

build:
	docker build . -t flask-gunicorn-3-11

run: build
	docker build test -t flask-gunicorn-3-11-test
	docker run --rm -it --publish 8123:80 --name flask-gunicorn-3-11-test flask-gunicorn-3-11-test

m-run:
	docker build martlark -t flask-gunicorn-3-11-martlark
	docker run --rm -it --publish 8123:80 --name flask-gunicorn-3-11-test flask-gunicorn-3-11-martlark

login:
	docker login

versions: login
	docker build . --build-arg VERSION=$(version) -t martlark/flask-gunicorn-3-11:$(version)

push: versions
	docker push martlark/flask-gunicorn-3-11:$(version)
	docker push martlark/flask-gunicorn-3-11:latest
