# Benchmark Mock Generator

## Goal

Benchmark a bunch of tool that given an `OpenAPI` produces a mock. Evaluate the following requirements:

1. Let you override specific endpoints
2. Let you keep some state between successive API calls
3. Validate requests payload
4. Let you write some assertion
5. Can record network calls
6. Can reply the recorded calls

## Summary

| Tool                                | Let you override endpoint | Let you keep some state | Validates requests | Let you write assertion | Can record network calls | Can replay the recorded calls |
|-------------------------------------|:-------------------------:|:-----------------------:|:------------------:|:-----------------------:|:------------------------:|:-----------------------------:|
| [mockoon](https://mockoon.com/cli/) | no* [1]                   | no                      | yes                | no                      | yes                      | no                            |
|                                     |                           |                         |                    |                         |                          |                               |

1. `mockoon` does allow to override endpoint providing its format, it does not allow overriding endpoint given a open-api ([details](https://mockoon.com/docs/latest/openapi/openapi-specification-compatibility/))

## Details

### Mockoon

To run it execute the following command:

``` sh
npm run mockoon:start
```
