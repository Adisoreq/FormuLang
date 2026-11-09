# ATAN

Trigonometric [**Core**](../README.md) standard function. Calculates the arctangent (inverse tangent) of a number. The result is in radians.

## Overloads

### Overload 1

Signature: `ATAN(value <Number>)`

Collection template:

| # | Name |   | Base type | Extended type | Any type | Multiple | Optional |
| - | :--: | - | :-------: | :-----------: | :------: | :------: | :------: |
| 1 | value | | Number | - | false | false | false |

Algorithm:

- Returns the angle `x` between `-PI / 2` and `PI / 2` (exclusive) for which `TAN(x)` equals `value`

Examples (results rounded to 16 significant digits):

| value | ATAN(value) |
| :-: | :-------: |
| 0 | 0 |
| 1 | 0.7853981633974483 |
| -1 | -0.7853981633974483 |

## Errors

- [`ARGUMENT_ERROR`](../errors/ARGUMENT_ERROR.md) - the arguments match no overload. If one of the arguments is an **Error**, that **Error** is returned instead (see [Evaluation](../../../semantics/evaluation.md#3-function-call)).


## Reference

- [Core standard](../README.md)
- [Trigonometric functions](README.md#8-trigonometric-functions)
- [`ATAN2`](ATAN2.md) - angle of a point, in all four quadrants
