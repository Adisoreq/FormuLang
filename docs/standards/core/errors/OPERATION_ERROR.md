# OPERATION_ERROR

[**Core**](../README.md) standard error. Code: `3`.

Invoked operation or function has failed while executing.

## Cause

A function matched its overload but could not compute the result, e.g. a division by zero.

## Behavior

An [**Error**](../types/Error.md) received as an argument is propagated unchanged instead of being wrapped in this error.

## Example

| Formula | Result |
| :------ | :----- |
| `DIV(1, 0)` | `[OPERATION_ERROR (3)] ...` |
| `ISERR(DIV(1, 0))` | `true` |

## Reference

- [Core errors](README.md)
- [`ISERR`](../functions/ISERR.md)
