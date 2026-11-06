# SUCCESS

[**Core**](../README.md) standard error. Code: `0`.

Operation executed successfully.

## Behavior

An [**Error**](../types/Error.md) with this code never aborts the execution, even when it is returned by the root of a sequence. It is returned by assignments and other procedures.

## Example

| Formula | Result |
| :------ | :----- |
| `$x = 4` | `[SUCCESS (0)]` - the execution continues |

## Reference

- [Core errors](README.md)
- [Evaluation](../../../semantics/evaluation.md#5-sequence-result)
