# FLOOR

Arithmetical [**Core**](../README.md) standard function. Rounds the number down to the specified precision.

## Overloads

### Overload 1

Signature: `FLOOR(number <Number>, precision <Number>)`

Collection template:

| # | Name |   | Base type | Extended type | Any type | Multiple | Optional |
| - | :--: | - | :-------: | :-----------: | :------: | :------: | :------: |
| 1 | number | | Number | - | false | false | false |
| 2 | precision | | Number | - | false | false | false |

Algorithm:

- If `precision` is not a whole number, returns an `OPERATION_ERROR`
- Returns the greatest number that is less than or equal to `number` and has no more than `precision` decimal places
- A negative `precision` rounds to tens, hundreds, etc., e.g. `FLOOR(129, -1)` is `120`

Examples:

| number | precision | FLOOR(number, precision) |
| :-: | :-: | :-------: |
| 4.29 | 1 | 4.2 |
| 4.8 | 0 | 4 |
| -4.21 | 1 | -4.3 |

## Errors

- [`OPERATION_ERROR`](../errors/OPERATION_ERROR.md) - `precision` is not a whole number.
- [`ARGUMENT_ERROR`](../errors/ARGUMENT_ERROR.md) - the arguments match no overload. If one of the arguments is an **Error**, that **Error** is returned instead (see [Evaluation](../../../semantics/evaluation.md#3-function-call)).


## Reference

- [Core standard](../README.md)
