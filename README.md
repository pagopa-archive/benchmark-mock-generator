# Benchmark Mock Generator

## Goal

Benchmark a bunch of tools that, given an `OpenAPI` produce a mock. Evaluate the following requirements:

1. Let you override specific endpoints.
2. Let you keep some state between successive API calls.
3. Validate the request's payload.
4. Let you write some assertions.
5. Capable of recording network calls
6. Capable of reproducing recorded calls.

## Summary

| Tool                                | Let you override endpoints | Let you keep state | Validate requests | Let you write assertion | Capable of recording | Capable of reproducing |
|-------------------------------------|:--------------------------:|:------------------:|:-----------------:|:-----------------------:|:--------------------:|:----------------------:|
| [mockoon](https://mockoon.com/cli/) | no* [1]                    | no                 | yes               | no                      | yes                  | no                     |
|                                     |                            |                    |                   |                         |                      |                        |

1. `mockoon` does allow to override endpoint providing its format, it does not allow overriding endpoint given a open-api ([details](https://mockoon.com/docs/latest/openapi/openapi-specification-compatibility/))

## Details

### Mockoon

To run it execute the following command:

``` sh
npm run mockoon:start
```
