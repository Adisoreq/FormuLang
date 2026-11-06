# POW

Arithmetical [**Core**](../README.md) standard function. Raises base to the power of exponent.

## Overloads

### Overload 1

Signature: `POW(base <Number>, exp <Number>)`

Collection template:

| # | Name |   | Base type | Extended type | Any type | Multiple | Optional |
| - | :--: | - | :-------: | :-----------: | :------: | :------: | :------: |
| 1 | base | | Number | - | false | false | false |
| 2 | exp | | Number | - | false | false | false |

Algorithm:

- If `base` is `0` and `exp` is less than `0`, returns an `OPERATION_ERROR`
- If `base` is less than `0` and `exp` is not a whole number, returns an `OPERATION_ERROR` (the result is not a real number)
- Otherwise, returns `base` raised to the power of `exp`. `POW(0, 0)` is `1`

Examples:

| base | exp | POW(base, exp) |
| :-: | :-: | :-------: |
| 2 | 3 | 8 |
| 5 | 0 | 1 |
| 4 | 0.5 | 2 |

## Errors

- [`OPERATION_ERROR`](../errors/OPERATION_ERROR.md) - `base` is `0` and `exp` is negative, `base` is negative and `exp` is not a whole number, or the result is not a finite number.
- [`ARGUMENT_ERROR`](../errors/ARGUMENT_ERROR.md) - the arguments match no overload. If one of the arguments is an **Error**, that **Error** is returned instead (see [Evaluation](../../../semantics/evaluation.md#3-function-call)).


## Reference

- [Core standard](../README.md)
