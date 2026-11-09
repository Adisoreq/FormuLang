# ATAN2

Trigonometric [**Core**](../README.md) standard function. Calculates the angle between the positive X axis and the point `(x, y)`. The result is in radians.

## Overloads

### Overload 1

Signature: `ATAN2(y <Number>, x <Number>)`

Collection template:

| # | Name |   | Base type | Extended type | Any type | Multiple | Optional |
| - | :--: | - | :-------: | :-----------: | :------: | :------: | :------: |
| 1 | y | | Number | - | false | false | false |
| 2 | x | | Number | - | false | false | false |

The order of the parameters (`y` first) is the same as in most programming languages, and the opposite of the spreadsheet function `ATAN2(x, y)`.

Algorithm:

- If both `y` and `x` are `0`, returns `0`
- Otherwise, returns the angle between `-PI` (exclusive) and `PI` (inclusive) from the positive X axis to the point `(x, y)`
- The sign of the result is the sign of `y`. If `y` is `0` and `x` is negative, returns `PI`
- Unlike `ATAN(y / x)`, the result depends on the quadrant of the point, and `x` can be `0`

Examples (results rounded to 16 significant digits):

| y | x | ATAN2(y, x) |
| :-: | :-: | :-------: |
| 1 | 1 | 0.7853981633974483 |
| 1 | -1 | 2.356194490192345 |
| -1 | -1 | -2.356194490192345 |
| 1 | 0 | 1.570796326794897 |
| 0 | -1 | 3.141592653589793 |
| 0 | 0 | 0 |

## Errors

- [`ARGUMENT_ERROR`](../errors/ARGUMENT_ERROR.md) - the arguments match no overload. If one of the arguments is an **Error**, that **Error** is returned instead (see [Evaluation](../../../semantics/evaluation.md#3-function-call)).


## Reference

- [Core standard](../README.md)
- [Trigonometric functions](README.md#8-trigonometric-functions)
- [`ATAN`](ATAN.md)
