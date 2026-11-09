# KEYS

Object [**Core**](../README.md) standard function. Returns the keys of an object.

## Overloads

### Overload 1

Signature: `KEYS(object <Object>)`

Collection template:

| # | Name |   | Base type | Extended type | Any type | Multiple | Optional |
| - | :--: | - | :-------: | :-----------: | :------: | :------: | :------: |
| 1 | object | | Object | - | false | false | false |

Algorithm:

- Returns a new array with every key of `object` as a **Text**
- The keys are in the order in which they were defined: for an object literal, from left to right; for an [extended type](../../../core/types.md#extended-types), in the order defined by the type
- Keys of nested objects are not included

Examples:

| Formula | Result |
| :--- | :--- |
| `KEYS({ name: "Ada", age: 36 })` | `[ "name", "age" ]` |
| `KEYS({})` | `[ ]` |
| `$o = { a: 1, b: 2 }` <br> `MAP(KEYS($o), (k) => $o[k])` | `[ 1, 2 ]` |

The last example returns the values of the object.

## Errors

- [`ARGUMENT_ERROR`](../errors/ARGUMENT_ERROR.md) - the arguments match no overload. If one of the arguments is an **Error**, that **Error** is returned instead (see [Evaluation](../../../semantics/evaluation.md#3-function-call)).


## Reference

- [Core standard](../README.md)
- [`HAS`](HAS.md), [`GET`](GET.md)
- [Object type](../types/Object.md)
