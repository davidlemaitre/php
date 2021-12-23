TAG ?= latest
IMAGE = davidlemaitre/php

build: build-8.0

build-8.0:
	docker build -t $(IMAGE):$(TAG) 8.0/bullseye/fpm

build-7.4:
	docker build -t $(IMAGE):$(TAG) 7.4/buster/fpm

build-7.3:
	docker build -t $(IMAGE):$(TAG) 7.3/stretch/fpm

build-7.0:
	docker build -t $(IMAGE):$(TAG) 7.0/stretch/fpm

shell:
	docker run --rm -it $(IMAGE):$(TAG) bash
