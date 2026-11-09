# HAS

Object and array [**Core**](../README.md) standard function. Checks if an object has a value stored under the specified key, or if an array has an element at the specified index.

`HAS` is the counterpart of [`GET`](GET.md): `HAS(x, k)` is `true` exactly when `GET(x, k)` does not return an `INVALID_KEY_ERROR` or an `INVALID_INDEX_ERROR`. It checks the **key or index**, not the value; to check if an array has a value, use [`CONTAINS`](CONTAINS.md).

## Overloads

### Overload 1: Object key

Signature: `HAS(object <Object>, key <Text>)`

Collection template:

| # | Name |   | Base type | Extended type | Any type | Multiple | Optional |
| - | :--: | - | :-------: | :-----------: | :------: | :------: | :------: |
| 1 | object | | Object | - | false | false | false |
| 2 | key | | Text | - | false | false | false |

Algorithm:

- Returns `true` if `object` has the exact key `key` (case-sensitive), otherwise `false`
- A key that stores `null` exists, so `HAS` returns `true` for it
- A `key` that is not a valid identifier is never present in an object, so `HAS` returns `false` for it

Examples:

| Formula | Result |
| :--- | :--- |
| `HAS({ name: "Ada" }, "name")` | `true` |
| `HAS({ name: "Ada" }, "Name")` | `false` |
| `HAS({ x: null }, "x")` | `true` |
| `$o = { a: 1 }` <br> `IF(HAS($o, "b"), $o.b, 0)` | `0` |

In the last example `$o.b` returns an `INVALID_KEY_ERROR`, but it is in the branch that `IF` does not select, so it is discarded. See [`IF`](IF.md).

---

### Overload 2: Array index

Signature: `HAS(array <Array>, index <Number>)`

Collection template:

| # | Name |   | Base type | Extended type | Any type | Multiple | Optional |
| - | :--: | - | :-------: | :-----------: | :------: | :------: | :------: |
| 1 | array | | Array | - | false | false | false |
| 2 | index | | Number | - | false | false | false |

Algorithm:

- Subtracts `@array_indexing` from `index`, in the same way as [`GET`](GET.md)
- Returns `true` if the result is a whole number from `0` to `LEN(array) - 1`, otherwise `false`
- An `index` that is not a whole number returns `false`, not an error
- An element that is `null` exists, so `HAS` returns `true` for its index

Examples:

| Formula | Result |
| :--- | :--- |
| `HAS([10, 20, 30], 2)` | `true` |
| `HAS([10, 20, 30], 3)` | `false` |
| `HAS([10, 20, 30], 3)` with `@array_indexing` = `1` | `true` |
| `HAS([10, 20, 30], -1)` | `false` |
| `HAS([10, 20, 30], 1.5)` | `false` |
| `HAS([], 0)` | `false` |
| `HAS([10, 20], 1)` <br> `CONTAINS([10, 20], 1)` | `true` <br> `false` |

The last example shows the difference: `HAS` checks that the index `1` exists, `CONTAINS` checks that an element equals `1`.

## Errors

- [`ARGUMENT_ERROR`](../errors/ARGUMENT_ERROR.md) - the arguments match no overload, e.g. `HAS(array, "1")` or `HAS(object, 1)`. If one of the arguments is an **Error**, that **Error** is returned instead (see [Evaluation](../../../semantics/evaluation.md#3-function-call)).


## Reference

- [Core standard](../README.md)
- [`KEYS`](KEYS.md), [`GET`](GET.md), [`CONTAINS`](CONTAINS.md)
- [`INVALID_KEY_ERROR`](../errors/INVALID_KEY_ERROR.md), [`INVALID_INDEX_ERROR`](../errors/INVALID_INDEX_ERROR.md)
