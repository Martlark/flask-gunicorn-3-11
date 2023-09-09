version := $(shell cat VERSION)

login:
	docker login

versions: login
	docker build . --build-arg $(version)=0.0.1 -t martlark/flask-gunicorn-3-11

push: versions
	docker push martlark/flask-gunicorn-3-11:$(version)
	docker push martlark/flask-gunicorn-3-11:latest
