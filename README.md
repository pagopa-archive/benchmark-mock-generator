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

| Tool                                            | Let you override endpoints | Let you keep state | Validate requests | Let you write assertion | Capable of recording | Capable of reproducing | Require the language |
|-------------------------------------------------|:--------------------------:|:------------------:|:-----------------:|:-----------------------:|:--------------------:|:----------------------:|:--------------------:|
| [mockoon](https://mockoon.com/cli/)             | no* [1]                    | no                 | yes               | no                      | yes                  | no                     | custom* [2]          |
| [prism](https://stoplight.io/open-source/prism) | no                         | no* [3]            | yes               | no                      | no* [4]              | no                     | no                   |
|                                                 |                            |                    |                   |                         |                      |                        |                      |

1. It is possible to override an endpoint given a Mockoon's file format; it is not possible to override an endpoint given an `open-api` ([more details here](https://mockoon.com/docs/latest/openapi/openapi-specification-compatibility/)).
2. Mockoon implements `Handlebars`, `Faker.js v5.5.3`, and a set of custom helpers to create dynamic responses. ([more details here](https://mockoon.com/docs/latest/templating/overview/)).
3. Based on prism [roadmap](https://github.com/stoplightio/prism#-roadmap), at some point the data persistence feature will be available, allowing Prism to act like a sandbox, no ETA is provided.
4. Based on prism [roadmap](https://github.com/stoplightio/prism#-roadmap), at some point the recording/learning mode feature will be available, no ETA is provided.

## Details

### Mockoon

To run it execute the following command:

``` sh
npm run mockoon:start
```
