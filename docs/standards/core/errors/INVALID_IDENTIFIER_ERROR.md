# INVALID_IDENTIFIER_ERROR

[**Core**](../README.md) standard error. Code: `9`.

Trying to redefine existing primitive.

## Cause

Declaring a container or function with an identifier that is already defined by the environment.

## Example

| Formula | Result |
| :------ | :----- |
| `$array_indexing = 1` | `[INVALID_IDENTIFIER_ERROR (9)] "array_indexing" symbol is already defined by environment.` |

## Reference

- [Core errors](README.md)
- [Naming](../../../syntax/naming.md)
- [Context examples](../examples/context_examples.md)
