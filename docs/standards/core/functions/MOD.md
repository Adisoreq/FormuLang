# MOD

Arithmetical [**Core**](../README.md) standard function. Returns the remainder of division between 2 elements.

## Overloads

### Overload 1

Signature: `MOD(a <Number>, b <Number>)`

Collection template:

| # | Name |   | Base type | Extended type | Any type | Multiple | Optional |
| - | :--: | - | :-------: | :-----------: | :------: | :------: | :------: |
| 1 | a | | Number | - | false | false | false |
| 2 | b | | Number | - | false | false | false |

Algorithm:

- If `b` is `0`, returns an `OPERATION_ERROR`
- Otherwise, returns `a - b * q`, where `q` is the quotient `a / b` with the fractional part removed (rounded toward zero)
- The result has the same sign as `a`, e.g. `MOD(-7, 3)` is `-1`

Examples:

|  a  |  b  | MOD(a, b) |
| :-: | :-: | :-------: |
| 10 | 3 | 1 |
| 7 | 4 | 3 |
| 8 | 2 | 0 |

## Errors

- [`OPERATION_ERROR`](../errors/OPERATION_ERROR.md) - `b` is `0`.
- [`ARGUMENT_ERROR`](../errors/ARGUMENT_ERROR.md) - the arguments match no overload. If one of the arguments is an **Error**, that **Error** is returned instead (see [Evaluation](../../../semantics/evaluation.md#3-function-call)).


## Reference

- [Core standard](../README.md)
