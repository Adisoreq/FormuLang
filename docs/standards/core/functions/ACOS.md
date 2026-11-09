# ACOS

Trigonometric [**Core**](../README.md) standard function. Calculates the arccosine (inverse cosine) of a number. The result is in radians.

## Overloads

### Overload 1

Signature: `ACOS(value <Number>)`

Collection template:

| # | Name |   | Base type | Extended type | Any type | Multiple | Optional |
| - | :--: | - | :-------: | :-----------: | :------: | :------: | :------: |
| 1 | value | | Number | - | false | false | false |

Algorithm:

- If `value` is less than `-1` or greater than `1`, returns an `OPERATION_ERROR`
- Otherwise, returns the angle `x` between `0` and `PI` (inclusive) for which `COS(x)` equals `value`

Examples (results rounded to 16 significant digits):

| value | ACOS(value) |
| :-: | :-------: |
| 1 | 0 |
| -1 | 3.141592653589793 |
| 0.5 | 1.047197551196598 |
| -2 | `OPERATION_ERROR` |

## Errors

- [`OPERATION_ERROR`](../errors/OPERATION_ERROR.md) - `value` is outside of the range from `-1` to `1`.
- [`ARGUMENT_ERROR`](../errors/ARGUMENT_ERROR.md) - the arguments match no overload. If one of the arguments is an **Error**, that **Error** is returned instead (see [Evaluation](../../../semantics/evaluation.md#3-function-call)).


## Reference

- [Core standard](../README.md)
- [Trigonometric functions](README.md#8-trigonometric-functions)
- [`DEG`](DEG.md) - converts radians to degrees
