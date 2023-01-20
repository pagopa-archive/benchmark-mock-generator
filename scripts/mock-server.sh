#!/bin/sh

docker run -ti --rm -p 8080:8080 -v "$PWD/docs:/config" --env MOCKSERVER_INITIALIZATION_JSON_PATH=/config/mockserver-config.json mockserver/mockserver -serverPort 8080
