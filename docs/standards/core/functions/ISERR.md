# ISERR

Type [**Core**](../README.md) standard function. Checks if value's base type is `Error`.

## Overloads

### Overload 1

Signature: `ISERR(value <Any>)`

Collection template:

| # | Name |   | Base type | Extended type | Any type | Multiple | Optional |
| - | :--: | - | :-------: | :-----------: | :------: | :------: | :------: |
| 1 | value | | - | - | true | false | false |

Algorithm:

- Returns `true` if the base type of `value` is **Error**; otherwise returns `false`

Examples:

| value | ISERR(value) |
| :-: | :-------: |
| `ERROR("Invalid input")` | true |
| 5 | false |
| "text" | false |

> **Note:** `ISERR` accepts any value, including an **Error**, so it handles the error instead of propagating it. For example, `ISERR(DIV(1, 0))` returns `true` and does not abort the execution.

## Errors

None. The argument accepts **Any type**, so an **Error** argument is received as a value and is not propagated.


## Reference

- [Core standard](../README.md)
