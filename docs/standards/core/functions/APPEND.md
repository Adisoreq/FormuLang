# APPEND

Array [**Core**](../README.md) standard function. Since `core-1.3`. Returns a copy of an array with a value added at the end.

Like every Core function, `APPEND` does not change its argument: it returns a new array. To keep the result, store it: `$levels = APPEND($levels, HIGH[I])`.

## Overloads

### Overload 1

Signature: `APPEND(array <Array>, value <Any>)`

Collection template:

| # | Name |   | Base type | Extended type | Any type | Multiple | Optional |
| - | :--: | - | :-------: | :-----------: | :------: | :------: | :------: |
| 1 | array | | Array | - | false | false | false |
| 2 | value | | - | - | true | false | false |

Algorithm:

- Returns a new **Array** with the elements of `array` followed by `value`
- An array `value` is added as one element; to join two arrays, use [`CONCAT`](CONCAT.md)

Examples:

| Formula | Result |
| :------ | :----- |
| `APPEND([1, 2], 3)` | `[1, 2, 3]` |
| `APPEND([], "a")` | `["a"]` |
| `APPEND([1], null)` | `[1, null]` |
| `APPEND([1], [2])` | `[1, [2]]` |

## Errors

- [`ARGUMENT_ERROR`](../errors/ARGUMENT_ERROR.md) - the arguments match no overload. If one of the arguments is an **Error**, that **Error** is returned instead (see [Evaluation](../../../semantics/evaluation.md#3-function-call)).


## Reference

- [Core standard](../README.md)
- [`INSERT`](INSERT.md), [`PUT`](PUT.md), [`REMOVE`](REMOVE.md), [`CONCAT`](CONCAT.md)
