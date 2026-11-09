# COS

Trigonometric [**Core**](../README.md) standard function. Calculates the cosine of an angle given in radians.

## Overloads

### Overload 1

Signature: `COS(angle <Number>)`

Collection template:

| # | Name |   | Base type | Extended type | Any type | Multiple | Optional |
| - | :--: | - | :-------: | :-----------: | :------: | :------: | :------: |
| 1 | angle | | Number | - | false | false | false |

Algorithm:

- Returns the cosine of `angle`, where `angle` is in radians. The result is between `-1` and `1`

Examples (results rounded to 16 significant digits):

| angle | COS(angle) |
| :-: | :-------: |
| 0 | 1 |
| 3.141592653589793 | -1 |
| 1.0471975511965976 | 0.5 |

## Errors

- [`ARGUMENT_ERROR`](../errors/ARGUMENT_ERROR.md) - the arguments match no overload. If one of the arguments is an **Error**, that **Error** is returned instead (see [Evaluation](../../../semantics/evaluation.md#3-function-call)).


## Reference

- [Core standard](../README.md)
- [Trigonometric functions](README.md#8-trigonometric-functions)
- [`RAD`](RAD.md) - converts degrees to radians
