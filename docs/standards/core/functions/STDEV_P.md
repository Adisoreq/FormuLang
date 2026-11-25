# STDEV_P

Statistical [**Core**](../README.md) standard function. Calculates the population standard deviation of numbers (e.g. the one used by Bollinger Bands).

## Overloads

### Overload 1

Signature: `STDEV_P(numbers <Array<Number>>)`

Collection template:

| # | Name |   | Base type | Extended type | Any type | Multiple | Optional |
| - | :--: | - | :-------: | :-----------: | :------: | :------: | :------: |
| 1 | numbers | | Array&lt;Number&gt; | - | false | false | false |

Algorithm:

- If the array is empty, returns an `OPERATION_ERROR`
- Returns the square root of [`VAR_P`](VAR_P.md)

Examples:

| Formula | Result |
| :------ | :----- |
| `STDEV_P([2, 4, 4, 4, 5, 5, 7, 9])` | `2` |
| `STDEV_P([5])` | `0` |

## Errors

- [`OPERATION_ERROR`](../errors/OPERATION_ERROR.md) - the array is empty.
- [`ARGUMENT_ERROR`](../errors/ARGUMENT_ERROR.md) - the arguments match no overload. If one of the arguments is an **Error**, that **Error** is returned instead (see [Evaluation](../../../semantics/evaluation.md#3-function-call)).


## Reference

- [Core standard](../README.md)
- [`AVG`](AVG.md)
