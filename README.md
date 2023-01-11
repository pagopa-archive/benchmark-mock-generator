# Benchmark Mock Generator

## Goal

Benchmark a bunch of tools that, given an `OpenAPI` produce a mock. Evaluate the following requirements:

1. Let you override specific endpoints.
2. Let you keep some state between successive API calls.
3. Validate the request's payload.
4. Let you write some assertions.
5. Capable of recording network calls
6. Capable of reproducing recorded calls.
7. Require the knowledge of a particular language.

## Summary

| Tool                                                                          | Let you override endpoints | Let you keep state | Validate requests | Let you write assertion | Capable of recording | Capable of reproducing | Require the language |
|-------------------------------------------------------------------------------|:--------------------------:|:------------------:|:-----------------:|:-----------------------:|:--------------------:|:----------------------:|:--------------------:|
| [mockoon](https://mockoon.com/cli/)                                           |          no* [1]           |         no         |        yes        |           no            |         yes          |           no           |     custom* [2]      |
| [nebula open api gen](https://github.com/ProtocolNebula/ts-openapi-generator) |             no             |         no         |        no         |           no            |          no          |           no           |          no          |

1. It is possible to override an endpoint given a Mockoon's file format; it is not possible to override an endpoint given an `open-api` ([more details here](https://mockoon.com/docs/latest/openapi/openapi-specification-compatibility/)).
2. Mockoon implements `Handlebars`, `Faker.js v5.5.3`, and a set of custom helpers to create dynamic responses. ([more details here](https://mockoon.com/docs/latest/templating/overview/)).

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

