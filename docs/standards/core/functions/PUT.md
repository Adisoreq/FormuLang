# PUT

Array and object [**Core**](../README.md) standard function. Since `core-1.3`. Returns a copy of an array with the element at an index replaced, or a copy of an object with a key set to a value.

`PUT` does not change its argument: it returns a new array or object. It is not the procedure [`SET`](../procedures/SET.md), which assigns a variable: `$o = PUT($o, "count", 1)` stores the new object in `$o`.

## Overloads

### Overload 1: Array index

Signature: `PUT(array <Array>, index <Number>, value <Any>)`

Collection template:

| # | Name |   | Base type | Extended type | Any type | Multiple | Optional |
| - | :--: | - | :-------: | :-----------: | :------: | :------: | :------: |
| 1 | array | | Array | - | false | false | false |
| 2 | index | | Number | - | false | false | false |
| 3 | value | | - | - | true | false | false |

Algorithm:

- If there is no element at `index` ([`HAS`](HAS.md) is `false`), returns an `INVALID_INDEX_ERROR`; to add an element, use [`APPEND`](APPEND.md) or [`INSERT`](INSERT.md)
- Returns a new **Array** with `value` at `index` and the other elements unchanged

Examples (`@array_indexing` = `0`):

| Formula | Result |
| :------ | :----- |
| `PUT([1, 2, 3], 1, 9)` | `[1, 9, 3]` |
| `PUT([1], 0, null)` | `[null]` |
| `PUT([1, 2], 2, 3)` | `[INVALID_INDEX_ERROR (7)] ...` |

---

### Overload 2: Object key

Signature: `PUT(object <Object>, key <Text>, value <Any>)`

Collection template:

| # | Name |   | Base type | Extended type | Any type | Multiple | Optional |
| - | :--: | - | :-------: | :-----------: | :------: | :------: | :------: |
| 1 | object | | Object | - | false | false | false |
| 2 | key | | Text | - | false | false | false |
| 3 | value | | - | - | true | false | false |

Algorithm:

- If `key` is not a valid identifier (see [naming restrictions](../../../syntax/naming.md#naming-restrictions)), returns an `INVALID_KEY_ERROR`
- Returns a new **Object** without an extended type: the same as `MERGE(object, { key: value })`. An existing key keeps its place and gets the new value; a new key is added at the end

Examples:

| Formula | Result |
| :------ | :----- |
| `PUT({ a: 1 }, "b", 2)` | `{ a: 1, b: 2 }` |
| `PUT({ a: 1, b: 2 }, "a", 3)` | `{ a: 3, b: 2 }` |
| `PUT({ }, "first name", 1)` | `[INVALID_KEY_ERROR (8)] ...` |

## Errors

- [`INVALID_INDEX_ERROR`](../errors/INVALID_INDEX_ERROR.md) - there is no element at `index`.
- [`INVALID_KEY_ERROR`](../errors/INVALID_KEY_ERROR.md) - `key` is not a valid identifier.
- [`ARGUMENT_ERROR`](../errors/ARGUMENT_ERROR.md) - the arguments match no overload. If one of the arguments is an **Error**, that **Error** is returned instead (see [Evaluation](../../../semantics/evaluation.md#3-function-call)).


## Reference

- [Core standard](../README.md)
- [`MERGE`](MERGE.md), [`REMOVE`](REMOVE.md), [`APPEND`](APPEND.md), [`INSERT`](INSERT.md)
