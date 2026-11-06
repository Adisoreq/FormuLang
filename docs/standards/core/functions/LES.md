# LES

Comparison [**Core**](../README.md) standard function. Checks if `a` is lesser than `b`.

## Overloads

### Overload 1

Signature: `LES(a <Number>, b <Number>)`

Collection template:

| # | Name |   | Base type | Extended type | Any type | Multiple | Optional |
| - | :--: | - | :-------: | :-----------: | :------: | :------: | :------: |
| 1 | a | | Number | - | false | false | false |
| 2 | b | | Number | - | false | false | false |

Algorithm:

- Returns `true` if `a` is less than `b`; otherwise returns `false`

Examples:

|  a  |  b  | LES(a, b) |
| :-: | :-: | :-------: |
| 3 | 5 | true |
| 5 | 3 | false |
| 5 | 5 | false |

## Errors

- [`ARGUMENT_ERROR`](../errors/ARGUMENT_ERROR.md) - the arguments match no overload. If one of the arguments is an **Error**, that **Error** is returned instead (see [Evaluation](../../../semantics/evaluation.md#3-function-call)).


## Reference

- [Core standard](../README.md)
