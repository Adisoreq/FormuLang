# PROD

Array [**Core**](../README.md) standard function. Calculates the product of all elements in the array.

## Overloads

### Overload 1

Signature: `PROD(array <Array<Number>>)`

Collection template:

| # | Name |   | Base type | Extended type | Any type | Multiple | Optional |
| - | :--: | - | :-------: | :-----------: | :------: | :------: | :------: |
| 1 | array | | Array&lt;Number&gt; | - | false | false | false |

Algorithm:

- Returns the product of all elements
- An empty array returns `1`

Examples:

| array | PROD(array) |
| :-: | :-------: |
| [ 1, 2, 3 ] | 6 |
| [ 2, 2, 2 ] | 8 |

## Errors

- [`OPERATION_ERROR`](../errors/OPERATION_ERROR.md) - the result is not a finite number (for example, it is too large).
- [`ARGUMENT_ERROR`](../errors/ARGUMENT_ERROR.md) - the arguments match no overload, e.g. an element of the array is not a **Number**. If one of the arguments, or an element of an array argument, is an **Error**, that **Error** is returned instead (see [Evaluation](../../../semantics/evaluation.md#3-function-call)).


## Reference

- [Core standard](../README.md)
