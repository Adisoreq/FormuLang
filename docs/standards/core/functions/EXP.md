# EXP

Arithmetical [**Core**](../README.md) standard function. Raises Euler's number `E` to the power of `base`. Alias for `POW(E, base)`.

## Overloads

### Overload 1

Signature: `EXP(base <Number>)`

Collection template:

| # | Name |   | Base type | Extended type | Any type | Multiple | Optional |
| - | :--: | - | :-------: | :-----------: | :------: | :------: | :------: |
| 1 | base | | Number | - | false | false | false |

Algorithm:

- Returns `E` raised to the power of `base`, the same result as `POW(E, base)`

Examples:

| base | EXP(base) |
| :-: | :-------: |
| 0 | 1 |
| 1 | 2.718281828459045 |
| 2 | 7.38905609893065 |

## Errors

- [`OPERATION_ERROR`](../errors/OPERATION_ERROR.md) - the result is not a finite number (for example, it is too large).
- [`ARGUMENT_ERROR`](../errors/ARGUMENT_ERROR.md) - the arguments match no overload. If one of the arguments is an **Error**, that **Error** is returned instead (see [Evaluation](../../../semantics/evaluation.md#3-function-call)).


## Reference

- [Core standard](../README.md)
