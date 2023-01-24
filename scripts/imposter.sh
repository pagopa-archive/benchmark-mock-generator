#!/bin/sh

docker run -ti --rm -p 8080:8080 -v "$PWD/docs/openapi:/opt/imposter/config/openapi" -v "$PWD/docs/imposter:/opt/imposter/config" outofcoffee/imposter-openapi
