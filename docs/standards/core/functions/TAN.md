# TAN

Trigonometric [**Core**](../README.md) standard function. Calculates the tangent of an angle given in radians.

## Overloads

### Overload 1

Signature: `TAN(angle <Number>)`

Collection template:

| # | Name |   | Base type | Extended type | Any type | Multiple | Optional |
| - | :--: | - | :-------: | :-----------: | :------: | :------: | :------: |
| 1 | angle | | Number | - | false | false | false |

Algorithm:

- Calculates the tangent of `angle`, where `angle` is in radians: `SIN(angle) / COS(angle)`
- If the result is not finite, returns an `OPERATION_ERROR`
- Otherwise, returns the result

Examples (results rounded to 16 significant digits):

| angle | TAN(angle) |
| :-: | :-------: |
| 0 | 0 |
| 0.7853981633974483 | 1 |
| -0.7853981633974483 | -1 |

## Errors

- [`OPERATION_ERROR`](../errors/OPERATION_ERROR.md) - the result is not finite.
- [`ARGUMENT_ERROR`](../errors/ARGUMENT_ERROR.md) - the arguments match no overload. If one of the arguments is an **Error**, that **Error** is returned instead (see [Evaluation](../../../semantics/evaluation.md#3-function-call)).


## Reference

- [Core standard](../README.md)
- [Trigonometric functions](README.md#8-trigonometric-functions)
- [`ATAN`](ATAN.md)
