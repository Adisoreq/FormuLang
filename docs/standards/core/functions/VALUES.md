# VALUES

Object [**Core**](../README.md) standard function. Since `core-1.3`. Returns the values of an object.

## Overloads

### Overload 1

Signature: `VALUES(object <Object>)`

Collection template:

| # | Name |   | Base type | Extended type | Any type | Multiple | Optional |
| - | :--: | - | :-------: | :-----------: | :------: | :------: | :------: |
| 1 | object | | Object | - | false | false | false |

Algorithm:

- Returns a new array with the value of every key of `object`, in the order of [`KEYS`](KEYS.md): `VALUES(o)` is `MAP(KEYS(o), (k) => o[k])`
- Values of nested objects are taken as a whole

Examples:

| Formula | Result |
| :--- | :--- |
| `VALUES({ name: "Ada", age: 36 })` | `[ "Ada", 36 ]` |
| `VALUES({})` | `[ ]` |
| `ALL(VALUES({ a: true, b: false }), (c) => c)` | `false` |
| `SUM(VALUES({ trend: 2, entry: 1 }))` | `3` |

## Errors

- [`ARGUMENT_ERROR`](../errors/ARGUMENT_ERROR.md) - the arguments match no overload. If one of the arguments is an **Error**, that **Error** is returned instead (see [Evaluation](../../../semantics/evaluation.md#3-function-call)).


## Reference

- [Core standard](../README.md)
- [`KEYS`](KEYS.md), [`ENTRIES`](ENTRIES.md)
- [Object type](../types/Object.md)
