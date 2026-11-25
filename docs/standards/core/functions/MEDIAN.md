# MEDIAN

Statistical [**Core**](../README.md) standard function. Returns the middle value of numbers.

## Overloads

### Overload 1

Signature: `MEDIAN(numbers <Array<Number>>)`

Collection template:

| # | Name |   | Base type | Extended type | Any type | Multiple | Optional |
| - | :--: | - | :-------: | :-----------: | :------: | :------: | :------: |
| 1 | numbers | | Array&lt;Number&gt; | - | false | false | false |

Algorithm:

- If the array is empty, returns an `OPERATION_ERROR`
- Orders the numbers from the smallest to the largest
- Returns the middle number for an odd number of elements, or the mean of the two middle numbers for an even number

Examples:

| Formula | Result |
| :------ | :----- |
| `MEDIAN([3, 1, 2])` | `2` |
| `MEDIAN([4, 1, 3, 2])` | `2.5` |
| `MEDIAN([7])` | `7` |

## Errors

- [`OPERATION_ERROR`](../errors/OPERATION_ERROR.md) - the array is empty.
- [`ARGUMENT_ERROR`](../errors/ARGUMENT_ERROR.md) - the arguments match no overload. If one of the arguments is an **Error**, that **Error** is returned instead (see [Evaluation](../../../semantics/evaluation.md#3-function-call)).


## Reference

- [Core standard](../README.md)
- [`AVG`](AVG.md)
