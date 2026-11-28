# REMOVE

Array and object [**Core**](../README.md) standard function. Since `core-1.3`. Returns a copy of an array without the element at an index, or a copy of an object without a key.

`REMOVE` does not change its argument: it returns a new array or object.

## Overloads

### Overload 1: Array index

Signature: `REMOVE(array <Array>, index <Number>)`

Collection template:

| # | Name |   | Base type | Extended type | Any type | Multiple | Optional |
| - | :--: | - | :-------: | :-----------: | :------: | :------: | :------: |
| 1 | array | | Array | - | false | false | false |
| 2 | index | | Number | - | false | false | false |

Algorithm:

- If there is no element at `index` ([`HAS`](HAS.md) is `false`), returns an `INVALID_INDEX_ERROR`
- Returns a new **Array** without that element; the elements after it move one place back

Examples (`@array_indexing` = `0`):

| Formula | Result |
| :------ | :----- |
| `REMOVE([1, 2, 3], 0)` | `[2, 3]` |
| `REMOVE([1, 2, 3], 2)` | `[1, 2]` |
| `$a = [1, 2, 3]` <br> `REMOVE($a, LEN($a) - 1)` | `[1, 2]` (the array without its last element) |
| `REMOVE([1], 5)` | `[INVALID_INDEX_ERROR (7)] ...` |

---

### Overload 2: Object key

Signature: `REMOVE(object <Object>, key <Text>)`

Collection template:

| # | Name |   | Base type | Extended type | Any type | Multiple | Optional |
| - | :--: | - | :-------: | :-----------: | :------: | :------: | :------: |
| 1 | object | | Object | - | false | false | false |
| 2 | key | | Text | - | false | false | false |

Algorithm:

- If `object` has no value stored under `key`, returns an `INVALID_KEY_ERROR`
- Returns a new **Object** without an extended type, with the other keys in their order

Examples:

| Formula | Result |
| :------ | :----- |
| `REMOVE({ a: 1, b: 2 }, "a")` | `{ b: 2 }` |
| `REMOVE({ a: 1 }, "a")` | `{ }` |
| `REMOVE({ a: 1 }, "b")` | `[INVALID_KEY_ERROR (8)] ...` |

## Errors

- [`INVALID_INDEX_ERROR`](../errors/INVALID_INDEX_ERROR.md) - there is no element at `index`.
- [`INVALID_KEY_ERROR`](../errors/INVALID_KEY_ERROR.md) - the object has no value stored under `key`.
- [`ARGUMENT_ERROR`](../errors/ARGUMENT_ERROR.md) - the arguments match no overload. If one of the arguments is an **Error**, that **Error** is returned instead (see [Evaluation](../../../semantics/evaluation.md#3-function-call)).


## Reference

- [Core standard](../README.md)
- [`APPEND`](APPEND.md), [`INSERT`](INSERT.md), [`PUT`](PUT.md), [`HAS`](HAS.md)
