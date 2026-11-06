# ARGUMENT_ERROR

[**Core**](../README.md) standard error. Code: `6`.

Function is being invoked with arguments that don't match any of its overloads, or a lambda function is invoked with a number of arguments different from the number of its parameters.

## Cause

- No overload of a named function matches the given arguments and none of the arguments is an **Error**.
- A lambda is invoked with a wrong number of arguments. Argument types of lambdas are not validated.

## Behavior

If no overload matches and one of the arguments is an [**Error**](../types/Error.md), the leftmost such **Error** is propagated instead of `ARGUMENT_ERROR`.

## Example

| Formula | Result |
| :------ | :----- |
| `ABS("text")` | `[ARGUMENT_ERROR (6)] ...` |
| `MAP([1, 2], (a, b) => a)` | `[ARGUMENT_ERROR (6)] ...` - lambda needs 2 arguments, receives 1 |

## Reference

- [Core errors](README.md)
- [Function call](../../../implementation/function_call.md)
- [Argument collection template](../../../implementation/argument_collection_template.md)
- [Evaluation](../../../semantics/evaluation.md#3-function-call)
