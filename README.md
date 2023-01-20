# Benchmark Mock Generator

## Goal

Benchmark a bunch of tools that, given an `OpenAPI` produce a mock. Evaluate the following requirements:

1. Let you override specific endpoints.
2. Let you keep some state between successive API calls.
3. Validate the request's payload.
4. Let you write some assertions.
5. Capable of recording network calls.
6. Capable of reproducing recorded calls.
7. Require the knowledge of a particular language.

## Summary

| Tool                                                                           | Let you override endpoints | Let you keep state | Validate requests | Let you write assertion | Capable of recording | Capable of reproducing | Require the language |
|--------------------------------------------------------------------------------|:--------------------------:|:------------------:|:-----------------:|:-----------------------:|:--------------------:|:----------------------:|:--------------------:|
| [mockoon](https://mockoon.com/cli/)                                            |          no* [1]           |         no         |        yes        |           no            |         yes          |           no           |     custom* [2]      |
| [ts-openapi-generator](https://github.com/ProtocolNebula/ts-openapi-generator) |          yes [3]           |      yes* [4]      |        no         |           no            |       yes* [5]       |           no           |     custom* [6]      |
| [prism](https://stoplight.io/open-source/prism)                                |          yes* [9]          |      no* [7]       |        yes        |           no            |       no* [8]        |           no           |          no          |
| [imposter](https://www.imposter.sh/)                                           |         yes* [11]          |     yes* [12]      |     yes* [10]     |           no            |       no* [13]       |           no           |     custom* [14]     |
| [open-api-mocker](https://github.com/jormaechea/open-api-mocker)               |         yes* [15]          |         no         |        yes        |           no            |          no          |           no           |     custom* [15]     |
| [specmatic](https://specmatic.in/documentation.html)                           |            yes             |      yes [19]      |     yes [20]      |        yes* [21]        |       yes [22]       |          yes           |     custom [23]      |

1. It is possible to override an endpoint given a Mockoon's file format; it is not possible to override an endpoint given an `open-api` ([more details here](https://mockoon.com/docs/latest/openapi/openapi-specification-compatibility/)).
2. Mockoon implements `Handlebars`, `Faker.js v5.5.3`, and a set of custom helpers to create dynamic responses. ([more details here](https://mockoon.com/docs/latest/templating/overview/)).
3. Yep, updating the `routes.json` file ([more details here](https://www.npmjs.com/package/json-server#add-custom-routes)).
4. Not tested, but maybe it could. Documentation says it uses lowdb to store data.
5. Not tested, but it could be possible writing a custom middleware ([more details here](https://www.npmjs.com/package/json-server#add-middlewares)).
6. Endpoint's responses are retrieved from the `db.json` file generated. Another way is to generate data using JS ([more details here](https://www.npmjs.com/package/json-server#generate-random-data)).
7. Based on prism [roadmap](https://github.com/stoplightio/prism#-roadmap), at some point the data persistence feature will be available, allowing Prism to act like a sandbox, no ETA is provided.
8. Based on prism [roadmap](https://github.com/stoplightio/prism#-roadmap), at some point the recording/learning mode feature will be available, no ETA is provided.
9. [Prism](https://docs.stoplight.io/docs/prism/83dbbd75532cf-http-mocking#response-examples) allows you to override the return response through open-api examples.
10. Request validation must be enabled (more details [here](https://docs.imposter.sh/openapi_plugin/#validating-requests-against-the-specification)).
11. Based on documentation it allows to control the response in many ways, via [templates](https://docs.imposter.sh/templates/), [examples](https://docs.imposter.sh/openapi_plugin/#overriding-examples).
12. Based on documentation it allows to keep a state ([store](https://docs.imposter.sh/stores/), and [capture](https://docs.imposter.sh/data_capture/)).
13. Based on [documentation](https://docs.imposter.sh/metrics_logs_telemetry/#logs) it can log everything so somehow can be stored on a file.
14. Based on [documentation](https://docs.imposter.sh/scripting/) imposter use a custom notation and accept different scripting language.
15. [Open-api-mocker](https://github.com/jormaechea/open-api-mocker#customizing-generated-responses) allows you to override the return response through adding `x-faker` to the OpenAPI.
19. Based on [documentation](https://specmatic.in/documentation/authoring_contracts.html#from-an-existing-application-using-proxy-mode) it can use the proxy feature to persist requests and responses. 
20. More details [here](https://specmatic.in/Features.html#service-virtualisation). 
21. Maybe it is possible to use [custom assertions](https://specmatic.in/documentation/contract_tests.html#externalising-examples--test-cases). 
22. It could be possible using the logs. 
23. It is possible to use Gherkin to write the assertions. More details [here](https://specmatic.in/documentation/contract_tests.html#externalising-examples--test-cases)

## Details

### Mockoon

To run it execute the following command:

``` sh
npm run mockoon:start
```

### Nebula ts-openapi-generator

To run it, execute the following command:

``` sh
npm run nebula:start
```
This command will generate the models and fix some issues explained in the next section.

#### Issues

In general, the tool looks not enough mature and used.

It uses [json-server](https://www.npmjs.com/package/json-server) under the hood, but the quality of the generated files
doesn't look good, especially on endpoint's path with path parameters (take a look at the `routes.json` file generated).

It doesn't generate all the elements present in the `open-api` file (e.g. 
```text
Processing models from 'components'
  Processing model PreLoadBulkRequest
    ERROR: PreLoadBulkRequest not a correct Schema
    ERROR: ARRAY not supported on COMPONENTS SCHEMA
```
so the mock-server doesn't serve all the routes (e.g. the `POST /delivery/requests` doesn't work).

In general, a lot of customization described in the table above, ara available thanks to the `json-server` library.

##### Yaml vs JSON
When generating models from OpenAPI, if we are using the `.yaml` file, we gets an error.
``` sh
FATAL ERROR
Error: Function yaml.safeLoad is removed in js-yaml 4. Use yaml.load instead, which is now safe by default.
    at Object.safeLoad ([...]/node_modules/@protocolnebula/ts-openapi-generator/node_modules/js-yaml/index.js:10:11)
    at parseYAML ([...]/node_modules/@protocolnebula/ts-openapi-generator/build/utils/files.util.js:123:17)
    at FileReaderService.parseFile ([...]/node_modules/@protocolnebula/ts-openapi-generator/build/services/parsers/file-reader.service.js:121:51)
    at FileReaderService.<anonymous> ([...]/node_modules/@protocolnebula/ts-openapi-generator/build/services/parsers/file-reader.service.js:36:41)
    at Generator.next (<anonymous>)
    at fulfilled ([...]/node_modules/@protocolnebula/ts-openapi-generator/build/services/parsers/file-reader.service.js:5:58)
    at process.processTicksAndRejections (node:internal/process/task_queues:95:5)
```
To solve this issue, we should use the `.json` file available in `docs/openapi/pn.json`. Note that this file is the very
same as the `pn.yaml` file, but in a different format.

##### Code generator
In order to run the mock server, we need to update the generated code, or to move a file in a proper location.
This second option is the simplest one, and it has been encoded in a script available in the `package.json` file.

##### Postinstall
Postinstall script is required with this version [more details here](https://github.com/ProtocolNebula/ts-openapi-generator#installation-electric_plug)

### Prism

To run it execute the following command:

``` sh
npm run prism:start
```

### open-api-mocker

To run it execute the following command:

``` sh
npm run mocker:start
```

Note that the run command executes a shell script which downloads and runs the Docker image.
As it is, the container will accept requests on port `8080`.

#### Issues
It has some issues when running directly using Node.js; using Docker it works fine.
The Dockerfile runs an old version of Node: version 10.

### Imposter

To run it execute the following command:

``` sh
npm run imposter:start
```

Visit `http://localhost:8080/_spec` to get the API specifications. Visit `http://localhost:8080/system/store/preload-request/preload` to lookup the key `preload` of the `perload-request` database.

### Specmatic

To run it execute the following command:

``` sh
npm run specmatic:start
```

#### Issues
It doesn't work with the `pn.yaml` file, because specmatic has some issues with the parsing of the file.
In order to try the tool, there is the `employee.yaml` file, which is a very simple OpenAPI file.

