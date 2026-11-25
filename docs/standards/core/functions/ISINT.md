# ISINT

Type [**Core**](../README.md) standard function. Checks if the value is a whole number.

## Overloads

### Overload 1

Signature: `ISINT(value <Any>)`

Collection template:

| # | Name |   | Base type | Extended type | Any type | Multiple | Optional |
| - | :--: | - | :-------: | :-----------: | :------: | :------: | :------: |
| 1 | value | | - | - | true | false | false |

Algorithm:

- Returns `true` if `value` is a **Number** without a fractional part; otherwise returns `false`
- A value of another type (e.g. **Text** or `null`) gives `false`; the function never returns an **Error**

Examples:

| Formula | Result |
| :------ | :----- |
| `ISINT(4)` | `true` |
| `ISINT(-4)` | `true` |
| `ISINT(4.5)` | `false` |
| `ISINT("4")` | `false` |
| `ISINT(null)` | `false` |

## Errors

None. The argument accepts **Any type**, so an **Error** argument is received as a value and is not propagated.


## Reference

- [Core standard](../README.md)
- [`ISNUM`](ISNUM.md)
