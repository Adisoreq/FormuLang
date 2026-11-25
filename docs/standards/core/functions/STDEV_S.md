# STDEV_S

Statistical [**Core**](../README.md) standard function. Calculates the sample standard deviation of numbers.

## Overloads

### Overload 1

Signature: `STDEV_S(numbers <Array<Number>>)`

Collection template:

| # | Name |   | Base type | Extended type | Any type | Multiple | Optional |
| - | :--: | - | :-------: | :-----------: | :------: | :------: | :------: |
| 1 | numbers | | Array&lt;Number&gt; | - | false | false | false |

Algorithm:

- If the array has fewer than 2 elements, returns an `OPERATION_ERROR`
- Returns the square root of [`VAR_S`](VAR_S.md)

Examples:

| Formula | Result |
| :------ | :----- |
| `STDEV_S([1, 3])` | `1.4142135623730951` |

## Errors

- [`OPERATION_ERROR`](../errors/OPERATION_ERROR.md) - the array has fewer than 2 elements.
- [`ARGUMENT_ERROR`](../errors/ARGUMENT_ERROR.md) - the arguments match no overload. If one of the arguments is an **Error**, that **Error** is returned instead (see [Evaluation](../../../semantics/evaluation.md#3-function-call)).


## Reference

- [Core standard](../README.md)
- [`AVG`](AVG.md)
