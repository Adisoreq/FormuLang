# MERGE

Object [**Core**](../README.md) standard function. Returns a new object with the keys of two objects; the value of the second object wins.

## Overloads

### Overload 1

Signature: `MERGE(object1 <Object>, object2 <Object>)`

Collection template:

| # | Name |   | Base type | Extended type | Any type | Multiple | Optional |
| - | :--: | - | :-------: | :-----------: | :------: | :------: | :------: |
| 1 | object1 | | Object | - | false | false | false |
| 2 | object2 | | Object | - | false | false | false |

Algorithm:

- Creates a new **Object** without an extended type; the arguments are not changed
- Adds every key of `object1`, in its order, with the value of `object2` if `object2` has the key, otherwise with the value of `object1`
- Then adds the keys of `object2` that `object1` does not have, in their order
- The merge is shallow: a nested object is taken as a whole, not merged

Examples:

| Formula | Result |
| :------ | :----- |
| `MERGE({ a: 1, b: 2 }, { b: 3, c: 4 })` | `{ a: 1, b: 3, c: 4 }` |
| `MERGE({ a: 1 }, { })` | `{ a: 1 }` |
| `MERGE(PREV, { count: PREV.count + 1 })` | the previous state with a new `count` |

## Errors

- [`ARGUMENT_ERROR`](../errors/ARGUMENT_ERROR.md) - the arguments match no overload. If one of the arguments is an **Error**, that **Error** is returned instead (see [Evaluation](../../../semantics/evaluation.md#3-function-call)).


## Reference

- [Core standard](../README.md)
- [`KEYS`](KEYS.md)
