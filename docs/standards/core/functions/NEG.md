# NEG

Arithmetical [**Core**](../README.md) standard function. Negates the number.

## Overloads

### Overload 1

Signature: `NEG(num <Number>)`

Collection template:

| # | Name |   | Base type | Extended type | Any type | Multiple | Optional |
| - | :--: | - | :-------: | :-----------: | :------: | :------: | :------: |
| 1 | num | | Number | - | false | false | false |

Algorithm:

- Returns `0 - num`. `NEG(0)` is `0`

Examples:

| num | NEG(num) |
| :-: | :-------: |
| 5 | -5 |
| -5 | 5 |
| 0 | 0 |

## Errors

- [`ARGUMENT_ERROR`](../errors/ARGUMENT_ERROR.md) - the arguments match no overload. If one of the arguments is an **Error**, that **Error** is returned instead (see [Evaluation](../../../semantics/evaluation.md#3-function-call)).


## Reference

- [Core standard](../README.md)
