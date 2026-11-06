# ERROR

Control flow [**Core**](../README.md) standard function. Returns an error with a custom message.

## Overloads

### Overload 1

Signature: `ERROR(message <Text>)`

Collection template:

| # | Name |   | Base type | Extended type | Any type | Multiple | Optional |
| - | :--: | - | :-------: | :-----------: | :------: | :------: | :------: |
| 1 | message | | Text | - | false | false | false |

Algorithm:

- Returns a new **Error** with the code `CUSTOM_ERROR` (`1`) and `message` as its details
- The call does not abort the execution by itself

Examples:

| message | ERROR(message) |
| :-: | :-------: |
| "Invalid input" | `Error`: "Invalid input" |
| "Division by zero" | `Error`: "Division by zero" |

> **Note:** `ERROR` only creates an **Error** value; it does not stop the execution by itself. The execution is aborted when the **Error** reaches the root of a sequence (directly or by being propagated through function calls). An **Error** that is handled earlier — for example by [`ISERR`](ISERR.md) or by a branch of [`IF`](IF.md) that is not selected — does not abort the execution. See [Evaluation](../../../semantics/evaluation.md#5-sequence-result).

## Errors

- [`ARGUMENT_ERROR`](../errors/ARGUMENT_ERROR.md) - the arguments match no overload. If one of the arguments is an **Error**, that **Error** is returned instead (see [Evaluation](../../../semantics/evaluation.md#3-function-call)).


## Reference

- [Core standard](../README.md)
