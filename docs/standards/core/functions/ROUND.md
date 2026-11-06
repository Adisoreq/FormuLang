# ROUND

Arithmetical [**Core**](../README.md) standard function. Rounds the number automatically to the specified precision.

## Overloads

### Overload 1

Signature: `ROUND(number <Number>, precision <Number>)`

Collection template:

| # | Name |   | Base type | Extended type | Any type | Multiple | Optional |
| - | :--: | - | :-------: | :-----------: | :------: | :------: | :------: |
| 1 | number | | Number | - | false | false | false |
| 2 | precision | | Number | - | false | false | false |

Algorithm:

- If `precision` is not a whole number, returns an `OPERATION_ERROR`
- Returns the number with no more than `precision` decimal places that is nearest to `number`
- If two numbers are equally near, returns the one farther from zero, e.g. `ROUND(4.5, 0)` is `5` and `ROUND(-4.5, 0)` is `-5`
- A negative `precision` rounds to tens, hundreds, etc., e.g. `ROUND(125, -1)` is `130`

Examples:

| number | precision | ROUND(number, precision) |
| :-: | :-: | :-------: |
| 4.21 | 1 | 4.2 |
| 4.26 | 1 | 4.3 |
| 4.5 | 0 | 5 |

## Errors

- [`OPERATION_ERROR`](../errors/OPERATION_ERROR.md) - `precision` is not a whole number.
- [`ARGUMENT_ERROR`](../errors/ARGUMENT_ERROR.md) - the arguments match no overload. If one of the arguments is an **Error**, that **Error** is returned instead (see [Evaluation](../../../semantics/evaluation.md#3-function-call)).


## Reference

- [Core standard](../README.md)
