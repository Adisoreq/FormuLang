# UNKNOWN_SYMBOL_ERROR

[**Core**](../README.md) standard error. Code: `5`.

A function, a constant or a context variable with a non-existent identifier is being used.

## Cause

- A function call refers to an identifier that is not defined by the loaded standards.
- A constant refers to an identifier that is not defined by the loaded standards or the environment.
- A formula reads a context variable (`$` sigil) that does not exist, e.g. because of a typo in its name.

A variable that is declared but has no value causes [`UNDEFINED_ERROR`](UNDEFINED_ERROR.md) instead. An environment variable (`@` sigil) that does not exist causes [`ENVIRONMENT_ERROR`](ENVIRONMENT_ERROR.md).

## Example

| Formula | Result |
| :------ | :----- |
| `NOSUCHFUNC(1)` | `[UNKNOWN_SYMBOL_ERROR (5)] Function "NOSUCHFUNC" is not defined.` |
| `$total = 10` <br> `$totl * 2` | `[UNKNOWN_SYMBOL_ERROR (5)] Variable "totl" is not defined.` |

## Reference

- [Core errors](README.md)
- [Core functions](../functions/README.md)
- [Evaluation](../../../semantics/evaluation.md#2-direct-extraction)
- [Naming](../../../syntax/naming.md)
