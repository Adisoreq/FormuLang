# CLAMP

Arithmetical [**Core**](../README.md) standard function. Clamps the value to the range between min and max.

## Overloads

### Overload 1

Signature: `CLAMP(value <Number>, min <Number>, max <Number>)`

Collection template:

| # | Name |   | Base type | Extended type | Any type | Multiple | Optional |
| - | :--: | - | :-------: | :-----------: | :------: | :------: | :------: |
| 1 | value | | Number | - | false | false | false |
| 2 | min | | Number | - | false | false | false |
| 3 | max | | Number | - | false | false | false |

Algorithm:

- If `min` is greater than `max`, returns an `OPERATION_ERROR`
- If `value` is less than `min`, returns `min`
- If `value` is greater than `max`, returns `max`
- Otherwise, returns `value`

Examples:

| value | min | max | CLAMP(value, min, max) |
| :-: | :-: | :-: | :-------: |
| 5 | 0 | 10 | 5 |
| -3 | 0 | 10 | 0 |
| 15 | 0 | 10 | 10 |

## Errors

- [`OPERATION_ERROR`](../errors/OPERATION_ERROR.md) - `min` is greater than `max`.
- [`ARGUMENT_ERROR`](../errors/ARGUMENT_ERROR.md) - the arguments match no overload. If one of the arguments is an **Error**, that **Error** is returned instead (see [Evaluation](../../../semantics/evaluation.md#3-function-call)).


## Reference

- [Core standard](../README.md)
