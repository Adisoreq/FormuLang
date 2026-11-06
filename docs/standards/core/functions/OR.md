# OR

Logical [**Core**](../README.md) standard function. Checks if at least one argument is true.

## Overloads

### Overload 1

Signature: `OR(a <Boolean>, b <Boolean>)`

Collection template:

| # | Name |   | Base type | Extended type | Any type | Multiple | Optional |
| - | :--: | - | :-------: | :-----------: | :------: | :------: | :------: |
| 1 | a | | Boolean | - | false | false | false |
| 2 | b | | Boolean | - | false | false | false |

Algorithm:

- Returns `true` if `a`, `b`, or both are `true`; otherwise returns `false`
- Both arguments are computed before the call (no short-circuit evaluation)

Examples:

|  a  |  b  | OR(a, b) |
| :-: | :-: | :-------: |
| true | false | true |
| false | false | false |
| true | true | true |

## Errors

- [`ARGUMENT_ERROR`](../errors/ARGUMENT_ERROR.md) - the arguments match no overload. If one of the arguments is an **Error**, that **Error** is returned instead (see [Evaluation](../../../semantics/evaluation.md#3-function-call)).


## Reference

- [Core standard](../README.md)
