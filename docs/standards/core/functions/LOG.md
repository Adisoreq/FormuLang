# LOG

Arithmetical [**Core**](../README.md) standard function. Calculates the logarithm of value with the specified base.

## Overloads

### Overload 1

Signature: `LOG(value <Number>, base <Number>)`

Collection template:

| # | Name |   | Base type | Extended type | Any type | Multiple | Optional |
| - | :--: | - | :-------: | :-----------: | :------: | :------: | :------: |
| 1 | value | | Number | - | false | false | false |
| 2 | base | | Number | - | false | false | false |

Algorithm:

- If `value` is `0` or less, returns an `OPERATION_ERROR`
- If `base` is `0` or less, or `base` is `1`, returns an `OPERATION_ERROR`
- Otherwise, returns the number `x` for which `POW(base, x)` equals `value`

Examples:

| value | base | LOG(value, base) |
| :-: | :-: | :-------: |
| 8 | 2 | 3 |
| 100 | 10 | 2 |
| 1 | 5 | 0 |

## Errors

- [`OPERATION_ERROR`](../errors/OPERATION_ERROR.md) - `value` is not greater than `0`, or `base` is not greater than `0`, or `base` is `1`.
- [`ARGUMENT_ERROR`](../errors/ARGUMENT_ERROR.md) - the arguments match no overload. If one of the arguments is an **Error**, that **Error** is returned instead (see [Evaluation](../../../semantics/evaluation.md#3-function-call)).


## Reference

- [Core standard](../README.md)
