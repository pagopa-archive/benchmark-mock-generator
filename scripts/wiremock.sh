#!/bin/sh

# Run wiremock
docker run -it \
  --name wiremock-studio \
  -p 9000:9000 \
  -p 8000-8100:8000-8100 \
  -v $PWD/wiremock:/home/wiremock \
  up9inc/wiremock-studio:2.32.0-18

# Create PN mock API
curl 'http://localhost:9000/api/v1/mock-apis' \
  -H 'Content-Type: application/json' \
  --data-raw '{"mockApi":{"name":"PN Mock Server","hostname":null,"port":8080,"ownerId":null,"ownerType":"USER","adminSecurityEnabled":false,"securitySettings":null}}' \
  --compressed

# Load PN OpenAPI spec
curl -v \
  --data-binary @docs/openapi/pn.yaml \
  http://localhost:8080/__admin/mocklab/imports
