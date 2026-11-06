# XOR

Logical [**Core**](../README.md) standard function. Checks if exactly one of two provided arguments is true.

## Overloads

### Overload 1

Signature: `XOR(a <Boolean>, b <Boolean>)`

Collection template:

| # | Name |   | Base type | Extended type | Any type | Multiple | Optional |
| - | :--: | - | :-------: | :-----------: | :------: | :------: | :------: |
| 1 | a | | Boolean | - | false | false | false |
| 2 | b | | Boolean | - | false | false | false |

Algorithm:

- Returns `true` if exactly one of `a` and `b` is `true`; otherwise returns `false`

Examples:

|  a  |  b  | XOR(a, b) |
| :-: | :-: | :-------: |
| false | false | false |
| true | false | true |
| false | true | true |
| true | true | false |

## Errors

- [`ARGUMENT_ERROR`](../errors/ARGUMENT_ERROR.md) - the arguments match no overload. If one of the arguments is an **Error**, that **Error** is returned instead (see [Evaluation](../../../semantics/evaluation.md#3-function-call)).


## Reference

- [Core standard](../README.md)
