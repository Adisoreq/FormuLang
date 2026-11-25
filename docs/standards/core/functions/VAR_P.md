# VAR_P

Statistical [**Core**](../README.md) standard function. Calculates the population variance of numbers.

## Overloads

### Overload 1

Signature: `VAR_P(numbers <Array<Number>>)`

Collection template:

| # | Name |   | Base type | Extended type | Any type | Multiple | Optional |
| - | :--: | - | :-------: | :-----------: | :------: | :------: | :------: |
| 1 | numbers | | Array&lt;Number&gt; | - | false | false | false |

Algorithm:

- If the array is empty, returns an `OPERATION_ERROR`
- Returns the mean of the squared differences from the mean: `SUM((x - AVG(numbers))^2) / n`, where `n` is the number of elements

Examples:

| Formula | Result |
| :------ | :----- |
| `VAR_P([2, 4, 4, 4, 5, 5, 7, 9])` | `4` |
| `VAR_P([5])` | `0` |

## Errors

- [`OPERATION_ERROR`](../errors/OPERATION_ERROR.md) - the array is empty.
- [`ARGUMENT_ERROR`](../errors/ARGUMENT_ERROR.md) - the arguments match no overload. If one of the arguments is an **Error**, that **Error** is returned instead (see [Evaluation](../../../semantics/evaluation.md#3-function-call)).


## Reference

- [Core standard](../README.md)
- [`AVG`](AVG.md)
