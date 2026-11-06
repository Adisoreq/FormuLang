# AVG

Array [**Core**](../README.md) standard function. Calculates the mean average value of numbers in an array.

## Overloads

### Overload 1

Signature: `AVG(array <Array<Number>>)`

Collection template:

| # | Name |   | Base type | Extended type | Any type | Multiple | Optional |
| - | :--: | - | :-------: | :-----------: | :------: | :------: | :------: |
| 1 | array | | Array&lt;Number&gt; | - | false | false | false |

Algorithm:

- If the array is empty, returns an `OPERATION_ERROR`
- Otherwise, returns `DIV(SUM(array), LEN(array))`

Examples:

| array | AVG(array) |
| :-: | :-------: |
| [ 1, 2, 3 ] | 2 |
| [ 10, 20, 30 ] | 20 |

## Errors

- [`OPERATION_ERROR`](../errors/OPERATION_ERROR.md) - the array is empty.
- [`ARGUMENT_ERROR`](../errors/ARGUMENT_ERROR.md) - the arguments match no overload, e.g. an element of the array is not a **Number**. If one of the arguments, or an element of an array argument, is an **Error**, that **Error** is returned instead (see [Evaluation](../../../semantics/evaluation.md#3-function-call)).


## Reference

- [Core standard](../README.md)
