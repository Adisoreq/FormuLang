# ISTEXT

Type [**Core**](../README.md) standard function. Checks if value's base type is `Text`.

## Overloads

### Overload 1

Signature: `ISTEXT(value <Any>)`

Collection template:

| # | Name |   | Base type | Extended type | Any type | Multiple | Optional |
| - | :--: | - | :-------: | :-----------: | :------: | :------: | :------: |
| 1 | value | | - | - | true | false | false |

Algorithm:

- Returns `true` if the base type of `value` is **Text**; otherwise returns `false`

Examples:

| value | ISTEXT(value) |
| :-: | :-------: |
| "text" | true |
| 5 | false |
| true | false |

## Errors

None. The argument accepts **Any type**, so an **Error** argument is received as a value and is not propagated.


## Reference

- [Core standard](../README.md)
