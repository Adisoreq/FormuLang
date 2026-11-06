# ISOBJ

Type [**Core**](../README.md) standard function. Checks if value's base type is `Object`.

## Overloads

### Overload 1

Signature: `ISOBJ(value <Any>)`

Collection template:

| # | Name |   | Base type | Extended type | Any type | Multiple | Optional |
| - | :--: | - | :-------: | :-----------: | :------: | :------: | :------: |
| 1 | value | | - | - | true | false | false |

Algorithm:

- Returns `true` if the base type of `value` is **Object**; otherwise returns `false`
- Values of extended types return `true`, because they are derived from **Object**

Examples:

| value | ISOBJ(value) |
| :-: | :-------: |
| `{ name: "Ada" }` | true |
| \[ 1, 2, 3 \] | false |
| 5 | false |
| "text" | false |

> **Note:** [Extended types](../../../core/types.md#extended-types) are derived from the **Object** type, so `ISOBJ` returns `true` for their values as well.

## Errors

None. The argument accepts **Any type**, so an **Error** argument is received as a value and is not propagated.


## Reference

- [Core standard](../README.md)
- [Core functions](README.md)
- [Object type](../types/Object.md)
