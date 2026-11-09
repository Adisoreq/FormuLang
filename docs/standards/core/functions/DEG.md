# DEG

Trigonometric [**Core**](../README.md) standard function. Converts an angle from radians to degrees.

## Overloads

### Overload 1

Signature: `DEG(radians <Number>)`

Collection template:

| # | Name |   | Base type | Extended type | Any type | Multiple | Optional |
| - | :--: | - | :-------: | :-----------: | :------: | :------: | :------: |
| 1 | radians | | Number | - | false | false | false |

Algorithm:

- Returns `radians * 180 / PI`

Examples:

| radians | DEG(radians) |
| :-: | :-------: |
| 3.141592653589793 | 180 |
| 1.5707963267948966 | 90 |
| -0.7853981633974483 | -45 |

## Errors

- [`ARGUMENT_ERROR`](../errors/ARGUMENT_ERROR.md) - the arguments match no overload. If one of the arguments is an **Error**, that **Error** is returned instead (see [Evaluation](../../../semantics/evaluation.md#3-function-call)).


## Reference

- [Core standard](../README.md)
- [Trigonometric functions](README.md#8-trigonometric-functions)
- [`RAD`](RAD.md)
