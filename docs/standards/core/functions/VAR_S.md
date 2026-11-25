# VAR_S

Statistical [**Core**](../README.md) standard function. Calculates the sample variance of numbers.

## Overloads

### Overload 1

Signature: `VAR_S(numbers <Array<Number>>)`

Collection template:

| # | Name |   | Base type | Extended type | Any type | Multiple | Optional |
| - | :--: | - | :-------: | :-----------: | :------: | :------: | :------: |
| 1 | numbers | | Array&lt;Number&gt; | - | false | false | false |

Algorithm:

- If the array has fewer than 2 elements, returns an `OPERATION_ERROR`
- Returns `SUM((x - AVG(numbers))^2) / (n - 1)`, where `n` is the number of elements

Examples:

| Formula | Result |
| :------ | :----- |
| `VAR_S([1, 3])` | `2` |
| `VAR_S([2, 4, 4, 4, 5, 5, 7, 9])` | `4.571428571428571` |

## Errors

- [`OPERATION_ERROR`](../errors/OPERATION_ERROR.md) - the array has fewer than 2 elements.
- [`ARGUMENT_ERROR`](../errors/ARGUMENT_ERROR.md) - the arguments match no overload. If one of the arguments is an **Error**, that **Error** is returned instead (see [Evaluation](../../../semantics/evaluation.md#3-function-call)).


## Reference

- [Core standard](../README.md)
- [`AVG`](AVG.md)
