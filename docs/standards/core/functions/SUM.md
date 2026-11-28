# SUM

Array [**Core**](../README.md) standard function. Calculates the sum of all elements in the array.

## Overloads

### Overload 1

Signature: `SUM(array <Array<Number>>)`

Collection template:

| # | Name |   | Base type | Extended type | Any type | Multiple | Optional |
| - | :--: | - | :-------: | :-----------: | :------: | :------: | :------: |
| 1 | array | | Array&lt;Number&gt; | - | false | false | false |

Since `core-1.3`, the elements may also be `null` (see [Missing values](../README.md#missing-values)).

Algorithm:

- If an element is `null`, returns `null` (since `core-1.3`): `null` is not skipped
- Otherwise, returns the sum of all elements
- An empty array returns `0`

Examples:

| array | SUM(array) |
| :-: | :-------: |
| [ 1, 2, 3 ] | 6 |
| [ 5, 10, 15 ] | 30 |
| [ 1, null ] | null |
| [ ] | 0 |

## Errors

- [`OPERATION_ERROR`](../errors/OPERATION_ERROR.md) - the result is not a finite number (for example, it is too large).
- [`ARGUMENT_ERROR`](../errors/ARGUMENT_ERROR.md) - the arguments match no overload, e.g. an element of the array is neither a **Number** nor `null`. If one of the arguments, or an element of an array argument, is an **Error**, that **Error** is returned instead (see [Evaluation](../../../semantics/evaluation.md#3-function-call)).


## Reference

- [Core standard](../README.md)
