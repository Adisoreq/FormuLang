# MUL

Arithmetical [**Core**](../README.md) standard function. Returns the product of 2 elements.

## Overloads

### Overload 1

Signature: `MUL(a <Number>, b <Number>)`

Collection template:

| # | Name |   | Base type | Extended type | Any type | Multiple | Optional |
| - | :--: | - | :-------: | :-----------: | :------: | :------: | :------: |
| 1 | a | | Number | - | false | false | false |
| 2 | b | | Number | - | false | false | false |

Algorithm:

- Returns the product `a * b`

Examples:

|  a  |  b  | MUL(a, b) |
| :-: | :-: | :-------: |
| 3 | 4 | 12 |
| -2 | 5 | -10 |
| 0.5 | 4 | 2 |

## Errors

- [`OPERATION_ERROR`](../errors/OPERATION_ERROR.md) - the result is not a finite number (for example, it is too large).
- [`ARGUMENT_ERROR`](../errors/ARGUMENT_ERROR.md) - the arguments match no overload. If one of the arguments is an **Error**, that **Error** is returned instead (see [Evaluation](../../../semantics/evaluation.md#3-function-call)).


## Reference

- [Core standard](../README.md)
