# SQRT

Arithmetical [**Core**](../README.md) standard function. Calculates the square root of a number. Alias for `ROOT(num, 2)`.

## Overloads

### Overload 1

Signature: `SQRT(num <Number>)`

Collection template:

| # | Name |   | Base type | Extended type | Any type | Multiple | Optional |
| - | :--: | - | :-------: | :-----------: | :------: | :------: | :------: |
| 1 | num | | Number | - | false | false | false |

Algorithm:

- If `num` is less than `0`, returns an `OPERATION_ERROR`
- Otherwise, returns the non-negative square root of `num`, the same result as `ROOT(num, 2)`

Examples:

| num | SQRT(num) |
| :-: | :-------: |
| 9 | 3 |
| 2 | 1.4142135623730951 |
| 0 | 0 |

## Errors

- [`OPERATION_ERROR`](../errors/OPERATION_ERROR.md) - `num` is negative.
- [`ARGUMENT_ERROR`](../errors/ARGUMENT_ERROR.md) - the arguments match no overload. If one of the arguments is an **Error**, that **Error** is returned instead (see [Evaluation](../../../semantics/evaluation.md#3-function-call)).


## Reference

- [Core standard](../README.md)
