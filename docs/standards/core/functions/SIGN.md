# SIGN

Arithmetical [**Core**](../README.md) standard function. Returns the sign of a number.

## Overloads

### Overload 1

Signature: `SIGN(num <Number>)`

Collection template:

| # | Name |   | Base type | Extended type | Any type | Multiple | Optional |
| - | :--: | - | :-------: | :-----------: | :------: | :------: | :------: |
| 1 | num | | Number | - | false | false | false |

Algorithm:

- If `num` is greater than `0`, returns `1`
- If `num` is less than `0`, returns `-1`
- Otherwise, returns `0`

Examples:

| num | SIGN(num) |
| :-: | :-------: |
| 42 | 1 |
| -0.5 | -1 |
| 0 | 0 |

## Errors

- [`ARGUMENT_ERROR`](../errors/ARGUMENT_ERROR.md) - the arguments match no overload. If one of the arguments is an **Error**, that **Error** is returned instead (see [Evaluation](../../../semantics/evaluation.md#3-function-call)).


## Reference

- [Core standard](../README.md)
- [`ABS`](ABS.md)
