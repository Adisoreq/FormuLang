# AND

Logical [**Core**](../README.md) standard function. Checks if both arguments are true.

## Overloads

### Overload 1

Signature: `AND(a <Boolean>, b <Boolean>)`

Collection template:

| # | Name |   | Base type | Extended type | Any type | Multiple | Optional |
| - | :--: | - | :-------: | :-----------: | :------: | :------: | :------: |
| 1 | a | | Boolean | - | false | false | false |
| 2 | b | | Boolean | - | false | false | false |

Algorithm:

- Returns `true` if both `a` and `b` are `true`; otherwise returns `false`
- Both arguments are computed before the call (no short-circuit evaluation)

Examples:

|  a  |  b  | AND(a, b) |
| :-: | :-: | :-------: |
| true | true | true |
| true | false | false |
| false | false | false |

## Errors

- [`ARGUMENT_ERROR`](../errors/ARGUMENT_ERROR.md) - the arguments match no overload. If one of the arguments is an **Error**, that **Error** is returned instead (see [Evaluation](../../../semantics/evaluation.md#3-function-call)).


## Reference

- [Core standard](../README.md)
