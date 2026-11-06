# LN

Arithmetical [**Core**](../README.md) standard function. Calculates the natural logarithm of value. Alias for `LOG(value, E)`.

## Overloads

### Overload 1

Signature: `LN(value <Number>)`

Collection template:

| # | Name |   | Base type | Extended type | Any type | Multiple | Optional |
| - | :--: | - | :-------: | :-----------: | :------: | :------: | :------: |
| 1 | value | | Number | - | false | false | false |

Algorithm:

- If `value` is `0` or less, returns an `OPERATION_ERROR`
- Otherwise, returns the natural logarithm of `value`, the same result as `LOG(value, E)`

Examples:

| value | LN(value) |
| :-: | :-------: |
| 1 | 0 |
| 2.718281828459045 | 1 |
| 10 | 2.302585092994046 |

## Errors

- [`OPERATION_ERROR`](../errors/OPERATION_ERROR.md) - `value` is not greater than `0`.
- [`ARGUMENT_ERROR`](../errors/ARGUMENT_ERROR.md) - the arguments match no overload. If one of the arguments is an **Error**, that **Error** is returned instead (see [Evaluation](../../../semantics/evaluation.md#3-function-call)).


## Reference

- [Core standard](../README.md)
