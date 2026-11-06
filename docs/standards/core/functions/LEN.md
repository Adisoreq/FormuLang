# LEN

Array [**Core**](../README.md) standard function. Returns the number of elements in the array.

## Overloads

### Overload 1

Signature: `LEN(array <Array>)`

Collection template:

| # | Name |   | Base type | Extended type | Any type | Multiple | Optional |
| - | :--: | - | :-------: | :-----------: | :------: | :------: | :------: |
| 1 | array | | Array | - | false | false | false |

Algorithm:

- Returns the number of elements in `array`. A nested array counts as one element

Examples:

| array | LEN(array) |
| :-: | :-------: |
| [ 1, 2, 3 ] | 3 |
| [ ] | 0 |

## Errors

- [`ARGUMENT_ERROR`](../errors/ARGUMENT_ERROR.md) - the arguments match no overload. If one of the arguments is an **Error**, that **Error** is returned instead (see [Evaluation](../../../semantics/evaluation.md#3-function-call)).


## Reference

- [Core standard](../README.md)
