# TRUNC

Arithmetical [**Core**](../README.md) standard function. Cuts off the digits of the number after the specified precision (rounds towards zero).

## Overloads

### Overload 1

Signature: `TRUNC(number <Number>, precision <Number>)`

Collection template:

| # | Name |   | Base type | Extended type | Any type | Multiple | Optional |
| - | :--: | - | :-------: | :-----------: | :------: | :------: | :------: |
| 1 | number | | Number | - | false | false | false |
| 2 | precision | | Number | - | false | false | false |

Algorithm:

- If `precision` is not a whole number, returns an `OPERATION_ERROR`
- Returns the number with no more than `precision` decimal places that is nearest to `number` and not farther from zero than `number`
- For a positive `number` the result is the same as `FLOOR(number, precision)`, for a negative one the same as `CEIL(number, precision)`
- A negative `precision` cuts off tens, hundreds, etc., e.g. `TRUNC(129, -1)` is `120`

Examples:

| number | precision | TRUNC(number, precision) |
| :-: | :-: | :-------: |
| 4.29 | 1 | 4.2 |
| -4.29 | 1 | -4.2 |
| 7.9 | 0 | 7 |
| -7.9 | 0 | -7 |

## Errors

- [`OPERATION_ERROR`](../errors/OPERATION_ERROR.md) - `precision` is not a whole number.
- [`ARGUMENT_ERROR`](../errors/ARGUMENT_ERROR.md) - the arguments match no overload. If one of the arguments is an **Error**, that **Error** is returned instead (see [Evaluation](../../../semantics/evaluation.md#3-function-call)).


## Reference

- [Core standard](../README.md)
- [`ROUND`](ROUND.md), [`CEIL`](CEIL.md), [`FLOOR`](FLOOR.md)
