# RAD

Trigonometric [**Core**](../README.md) standard function. Converts an angle from degrees to radians.

## Overloads

### Overload 1

Signature: `RAD(degrees <Number>)`

Collection template:

| # | Name |   | Base type | Extended type | Any type | Multiple | Optional |
| - | :--: | - | :-------: | :-----------: | :------: | :------: | :------: |
| 1 | degrees | | Number | - | false | false | false |

Algorithm:

- Returns `degrees * PI / 180`

Examples:

| degrees | RAD(degrees) |
| :-: | :-------: |
| 180 | 3.141592653589793 |
| 90 | 1.5707963267948966 |
| -45 | -0.7853981633974483 |

## Errors

- [`ARGUMENT_ERROR`](../errors/ARGUMENT_ERROR.md) - the arguments match no overload. If one of the arguments is an **Error**, that **Error** is returned instead (see [Evaluation](../../../semantics/evaluation.md#3-function-call)).


## Reference

- [Core standard](../README.md)
- [Trigonometric functions](README.md#8-trigonometric-functions)
- [`DEG`](DEG.md)
