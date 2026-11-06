# CEIL

Arithmetical [**Core**](../README.md) standard function. Rounds the number up to the specified precision.

## Overloads

### Overload 1

Signature: `CEIL(number <Number>, precision <Number>)`

Collection template:

| # | Name |   | Base type | Extended type | Any type | Multiple | Optional |
| - | :--: | - | :-------: | :-----------: | :------: | :------: | :------: |
| 1 | number | | Number | - | false | false | false |
| 2 | precision | | Number | - | false | false | false |

Algorithm:

- If `precision` is not a whole number, returns an `OPERATION_ERROR`
- Returns the smallest number that is greater than or equal to `number` and has no more than `precision` decimal places
- A negative `precision` rounds to tens, hundreds, etc., e.g. `CEIL(123, -1)` is `130`

Examples:

| number | precision | CEIL(number, precision) |
| :-: | :-: | :-------: |
| 4.21 | 1 | 4.3 |
| 4.2 | 0 | 5 |
| -4.26 | 1 | -4.2 |

## Errors

- [`OPERATION_ERROR`](../errors/OPERATION_ERROR.md) - `precision` is not a whole number.
- [`ARGUMENT_ERROR`](../errors/ARGUMENT_ERROR.md) - the arguments match no overload. If one of the arguments is an **Error**, that **Error** is returned instead (see [Evaluation](../../../semantics/evaluation.md#3-function-call)).


## Reference

- [Core standard](../README.md)
