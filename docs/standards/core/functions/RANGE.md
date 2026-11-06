# RANGE

Array [**Core**](../README.md) standard function. Returns a sub-array from the `first_index` up to the `last_index`.

## Overloads

### Overload 1

Signature: `RANGE(array <Array>, first_index <Number>, last_index <Number>)`

Collection template:

| # | Name |   | Base type | Extended type | Any type | Multiple | Optional |
| - | :--: | - | :-------: | :-----------: | :------: | :------: | :------: |
| 1 | array | | Array | - | false | false | false |
| 2 | first_index | | Number | - | false | false | false |
| 3 | last_index | | Number | - | false | false | false |

Algorithm:

- Converts both indices with `@array_indexing` in the same way as [GET](GET.md)
- If an index is not a whole number or is not a valid index of `array`, returns an `INVALID_INDEX_ERROR`
- If `first_index` is greater than `last_index`, returns an `INVALID_INDEX_ERROR`
- Otherwise, returns a new array with the elements from `first_index` up to and including `last_index`

Examples:

| array | first_index | last_index | RANGE(array, first_index, last_index) |
| :-: | :-: | :-: | :-------: |
| [ 1, 2, 3, 4, 5 ] | 1 | 3 | [ 2, 3, 4 ] |
| [ 10, 20, 30 ] | 0 | 1 | [ 10, 20 ] |

## Errors

- [`INVALID_INDEX_ERROR`](../errors/INVALID_INDEX_ERROR.md) - an index is not a whole number, is outside of the array, or `first_index` is greater than `last_index`.
- [`ARGUMENT_ERROR`](../errors/ARGUMENT_ERROR.md) - the arguments match no overload. If one of the arguments is an **Error**, that **Error** is returned instead (see [Evaluation](../../../semantics/evaluation.md#3-function-call)).


## Reference

- [Core standard](../README.md)
