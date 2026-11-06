# ENVIRONMENT_ERROR

[**Core**](../README.md) standard error. Code: `10`.

Environment doesn't meet the requirements of the standard, or a formula refers to an environment element that doesn't exist.

## Cause

- A constant or variable required by the standard is missing from the environment or has a wrong type. Detected by [validation](../semantics/validation.md#environment-checks).
- A formula assigns or reads an environment variable that is not defined, e.g. `@x = 1` (see [Environment examples](../examples/environment_examples.md)).

## Behavior

Errors detected by validation always abort the execution, regardless of the `suppress_errors` environment variable.

## Example

| Situation | Result |
| :-------- | :----- |
| `suppress_errors` is set to `"yes"` | `[ENVIRONMENT_ERROR (10)] Environment variable "suppress_errors" is missing or is not of type Boolean.` |

## Reference

- [Core errors](README.md)
- [Core validation](../semantics/validation.md)
- [Environment](../../../core/environment.md)
