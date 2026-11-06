# GEQ

Comparison [**Core**](../README.md) standard function. Checks if `a` is greater than or equal to `b`.

## Overloads

### Overload 1

Signature: `GEQ(a <Number>, b <Number>)`

Collection template:

| # | Name |   | Base type | Extended type | Any type | Multiple | Optional |
| - | :--: | - | :-------: | :-----------: | :------: | :------: | :------: |
| 1 | a | | Number | - | false | false | false |
| 2 | b | | Number | - | false | false | false |

Algorithm:

- Returns `true` if `a` is greater than or equal to `b`; otherwise returns `false`

Examples:

|  a  |  b  | GEQ(a, b) |
| :-: | :-: | :-------: |
| 5 | 5 | true |
| 6 | 5 | true |
| 4 | 5 | false |

## Errors

- [`ARGUMENT_ERROR`](../errors/ARGUMENT_ERROR.md) - the arguments match no overload. If one of the arguments is an **Error**, that **Error** is returned instead (see [Evaluation](../../../semantics/evaluation.md#3-function-call)).


## Reference

- [Core standard](../README.md)
