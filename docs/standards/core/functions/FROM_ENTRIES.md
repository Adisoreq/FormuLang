# FROM_ENTRIES

Object [**Core**](../README.md) standard function. Since `core-1.3`. Creates an object from an array of `[key, value]` pairs.

It builds objects whose keys are computed, e.g. one key for every period: `FROM_ENTRIES(MAP([20, 50], (p) => ["period" + TEXT(p), p * 2]))` is `{ period20: 40, period50: 100 }`.

## Overloads

### Overload 1

Signature: `FROM_ENTRIES(entries <Array>)`

Collection template:

| # | Name |   | Base type | Extended type | Any type | Multiple | Optional |
| - | :--: | - | :-------: | :-----------: | :------: | :------: | :------: |
| 1 | entries | | Array | - | false | false | false |

Algorithm:

- If an element of `entries` is not an **Array** of exactly 2 elements whose first element is a **Text**, returns an `ARGUMENT_ERROR`
- If a key is not a valid identifier (see [naming restrictions](../../../syntax/naming.md#naming-restrictions)), returns an `INVALID_KEY_ERROR`
- Returns a new **Object** without an extended type, with the keys in the order of their first pair; if a key appears more than once, the value of its last pair wins (like [`MERGE`](MERGE.md))

Examples:

| Formula | Result |
| :--- | :--- |
| `FROM_ENTRIES([ ["a", 1], ["b", 2] ])` | `{ a: 1, b: 2 }` |
| `FROM_ENTRIES([ ])` | `{ }` |
| `FROM_ENTRIES([ ["a", 1], ["a", 2] ])` | `{ a: 2 }` |
| `FROM_ENTRIES([ ["a", 1, 2] ])` | `[ARGUMENT_ERROR (6)] ...` |
| `FROM_ENTRIES([ [1, "a"] ])` | `[ARGUMENT_ERROR (6)] ...` |
| `FROM_ENTRIES([ ["first name", 1] ])` | `[INVALID_KEY_ERROR (8)] ...` |

## Errors

- [`ARGUMENT_ERROR`](../errors/ARGUMENT_ERROR.md) - the arguments match no overload, or an element of `entries` is not a pair with a **Text** key. If one of the arguments is an **Error**, that **Error** is returned instead (see [Evaluation](../../../semantics/evaluation.md#3-function-call)).
- [`INVALID_KEY_ERROR`](../errors/INVALID_KEY_ERROR.md) - a key is not a valid identifier.


## Reference

- [Core standard](../README.md)
- [`ENTRIES`](ENTRIES.md), [`MERGE`](MERGE.md)
