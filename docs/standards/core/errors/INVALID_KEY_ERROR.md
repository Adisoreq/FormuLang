# INVALID_KEY_ERROR

[**Core**](../README.md) standard error. Code: `8`.

Trying to access an object variable with non-existent key.

## Cause

[`GET`](../functions/GET.md) (or the `object.key` / `object["key"]` operator) receives a key that is not present in the object, including any text that is not a valid identifier.

## Example

| Formula | Result |
| :------ | :----- |
| `{"name": "Ada"}.age` | `[INVALID_KEY_ERROR (8)] ...` |

## Reference

- [Core errors](README.md)
- [`GET`](../functions/GET.md)
- [Object type](../types/Object.md)
