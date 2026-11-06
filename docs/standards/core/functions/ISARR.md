# ISARR

Type [**Core**](../README.md) standard function. Checks if value's base type is `Array`.

## Overloads

### Overload 1

Signature: `ISARR(value <Any>)`

Collection template:

| # | Name |   | Base type | Extended type | Any type | Multiple | Optional |
| - | :--: | - | :-------: | :-----------: | :------: | :------: | :------: |
| 1 | value | | - | - | true | false | false |

Algorithm:

- Returns `true` if the base type of `value` is **Array**; otherwise returns `false`

Examples:

| value | ISARR(value) |
| :-: | :-------: |
| [ 1, 2, 3 ] | true |
| 5 | false |
| "text" | false |

## Errors

None. The argument accepts **Any type**, so an **Error** argument is received as a value and is not propagated.


## Reference

- [Core standard](../README.md)
