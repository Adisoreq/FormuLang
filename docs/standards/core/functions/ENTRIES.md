# ENTRIES

Object [**Core**](../README.md) standard function. Since `core-1.3`. Returns the keys and values of an object as an array of pairs.

## Overloads

### Overload 1

Signature: `ENTRIES(object <Object>)`

Collection template:

| # | Name |   | Base type | Extended type | Any type | Multiple | Optional |
| - | :--: | - | :-------: | :-----------: | :------: | :------: | :------: |
| 1 | object | | Object | - | false | false | false |

Algorithm:

- Returns a new array with one pair `[key, value]` for every key of `object`, in the order of [`KEYS`](KEYS.md); `key` is a **Text**
- [`FROM_ENTRIES`](FROM_ENTRIES.md) turns the pairs back into an object: `FROM_ENTRIES(ENTRIES(o))` has the same keys and values as `o`, without an extended type

Examples:

| Formula | Result |
| :--- | :--- |
| `ENTRIES({ a: 1, b: 2 })` | `[ ["a", 1], ["b", 2] ]` |
| `ENTRIES({})` | `[ ]` |
| `$o = { a: true, b: false }` <br> `MAP(FILTER(ENTRIES($o), (e) => e[1]), (e) => e[0])` | `[ "a" ]` (the keys of the met conditions) |

## Errors

- [`ARGUMENT_ERROR`](../errors/ARGUMENT_ERROR.md) - the arguments match no overload. If one of the arguments is an **Error**, that **Error** is returned instead (see [Evaluation](../../../semantics/evaluation.md#3-function-call)).


## Reference

- [Core standard](../README.md)
- [`FROM_ENTRIES`](FROM_ENTRIES.md), [`KEYS`](KEYS.md), [`VALUES`](VALUES.md)
