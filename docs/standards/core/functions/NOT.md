# NOT

Logical [**Core**](../README.md) standard function. Inverts the boolean value.

## Overloads

### Overload 1

Signature: `NOT(val <Boolean>)`

Collection template:

| # | Name |   | Base type | Extended type | Any type | Multiple | Optional |
| - | :--: | - | :-------: | :-----------: | :------: | :------: | :------: |
| 1 | val | | Boolean | - | false | false | false |

Algorithm:

- Returns `false` if `val` is `true`, and `true` if `val` is `false`

Examples:

| val | NOT(val) |
| :-: | :-------: |
| true | false |
| false | true |

## Errors

- [`ARGUMENT_ERROR`](../errors/ARGUMENT_ERROR.md) - the arguments match no overload. If one of the arguments is an **Error**, that **Error** is returned instead (see [Evaluation](../../../semantics/evaluation.md#3-function-call)).


## Reference

- [Core standard](../README.md)
