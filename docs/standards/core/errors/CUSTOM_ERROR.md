# CUSTOM_ERROR

[**Core**](../README.md) standard error. Code: `1`.

User's custom error invoked by the [`ERROR`](../functions/ERROR.md) function.

## Cause

Evaluating `ERROR(message)`. The `message` becomes the details of the error.

## Example

| Formula | Result |
| :------ | :----- |
| `ERROR("Not negative!")` | `[CUSTOM_ERROR (1)] Not negative!` |
| `IF($x < 0, 1, ERROR("Not negative!"))` | `1` for `$x < 0`, otherwise `[CUSTOM_ERROR (1)] Not negative!` |

> **Note:** The error is an ordinary value. It aborts the execution only if it reaches the root of a sequence; it is discarded if the branch containing it is not selected by `IF`.

## Reference

- [Core errors](README.md)
- [`ERROR`](../functions/ERROR.md)
