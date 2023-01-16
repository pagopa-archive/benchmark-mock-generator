# Start open-api-mocker with Docker

# Listen on port 8080

docker run -v "$PWD/docs/openapi/pn.json:/app/schema.json" -p "8080:8080" jormaechea/open-api-mocker -s /app/schema.json -p 8080
