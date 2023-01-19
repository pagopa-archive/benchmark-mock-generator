#!/bin/sh

docker run -ti --rm -p 8080:8080 -v "$PWD/docs:/opt/imposter/config" outofcoffee/imposter-openapi
