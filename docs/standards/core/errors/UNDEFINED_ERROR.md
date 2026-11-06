# UNDEFINED_ERROR

[**Core**](../README.md) standard error. Code: `12`.

A variable without a value is being read.

## Cause

A formula reads a context variable that is declared but has no value yet (its state is [**Undefined**](../types/Undefined.md)), e.g. a variable declared with `$x` and used before an assignment.

The error is the result of the read itself, so the function that would receive the value is not called. Like any other **Error**, it is propagated to the root of the sequence and aborts the execution, unless a function that accepts **Any type** (e.g. [`ISERR`](../functions/ISERR.md)) receives it first.

The variable argument of [`SET`](../procedures/SET.md), [`INIT`](../procedures/INIT.md) and [`COND_SET`](../procedures/COND_SET.md) is not read, so an **Undefined** variable can always be assigned.

## Example

| Formula | Result |
| :------ | :----- |
| `$x` <br> `CLAMP($x, 0, 1)` | `[UNDEFINED_ERROR (12)] Variable "x" has no value.` |
| `$x` <br> `$x` | `[UNDEFINED_ERROR (12)] Variable "x" has no value.` |
| `$x` <br> `ISERR($x)` | `true` |
| `$x` <br> `$x = 1` <br> `$x + 1` | `2` |

## Reference

- [Core errors](README.md)
- [Undefined type](../types/Undefined.md)
- [Evaluation](../../../semantics/evaluation.md#2-direct-extraction)
- [`UNKNOWN_SYMBOL_ERROR`](UNKNOWN_SYMBOL_ERROR.md)
