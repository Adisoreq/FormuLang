# INSERT

Array [**Core**](../README.md) standard function. Since `core-1.3`. Returns a copy of an array with a value inserted at an index.

`INSERT` does not change its argument: it returns a new array.

## Overloads

### Overload 1

Signature: `INSERT(array <Array>, index <Number>, value <Any>)`

Collection template:

| # | Name |   | Base type | Extended type | Any type | Multiple | Optional |
| - | :--: | - | :-------: | :-----------: | :------: | :------: | :------: |
| 1 | array | | Array | - | false | false | false |
| 2 | index | | Number | - | false | false | false |
| 3 | value | | - | - | true | false | false |

Algorithm:

- Subtracts `@array_indexing` from `index`, in the same way as [`GET`](GET.md)
- If the result is not a whole number from `0` to `LEN(array)`, returns an `INVALID_INDEX_ERROR`
- Returns a new **Array** in which `value` is at `index` and the elements from `index` onwards move one place further
- `index` equal to the length (with `@array_indexing` = `0`: `LEN(array)`) adds `value` at the end, like [`APPEND`](APPEND.md)

Examples (`@array_indexing` = `0`):

| Formula | Result |
| :------ | :----- |
| `INSERT([1, 3], 1, 2)` | `[1, 2, 3]` |
| `INSERT([2, 3], 0, 1)` | `[1, 2, 3]` |
| `INSERT([1, 2], 2, 3)` | `[1, 2, 3]` |
| `INSERT([1, 2], 3, 4)` | `[INVALID_INDEX_ERROR (7)] ...` |
| `INSERT([1, 2], -1, 0)` | `[INVALID_INDEX_ERROR (7)] ...` |

## Errors

- [`INVALID_INDEX_ERROR`](../errors/INVALID_INDEX_ERROR.md) - `index` is not a whole number, or is outside of the range from the first index to the length of the array.
- [`ARGUMENT_ERROR`](../errors/ARGUMENT_ERROR.md) - the arguments match no overload. If one of the arguments is an **Error**, that **Error** is returned instead (see [Evaluation](../../../semantics/evaluation.md#3-function-call)).


## Reference

- [Core standard](../README.md)
- [`APPEND`](APPEND.md), [`PUT`](PUT.md), [`REMOVE`](REMOVE.md)
