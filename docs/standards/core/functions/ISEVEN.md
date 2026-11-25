# ISEVEN

Type [**Core**](../README.md) standard function. Checks if the value is an even whole number.

## Overloads

### Overload 1

Signature: `ISEVEN(value <Any>)`

Collection template:

| # | Name |   | Base type | Extended type | Any type | Multiple | Optional |
| - | :--: | - | :-------: | :-----------: | :------: | :------: | :------: |
| 1 | value | | - | - | true | false | false |

Algorithm:

- Returns `true` if `value` is a whole **Number** divisible by `2`; otherwise returns `false`
- A value of another type (e.g. **Text** or `null`) gives `false`; the function never returns an **Error**

Examples:

| Formula | Result |
| :------ | :----- |
| `ISEVEN(4)` | `true` |
| `ISEVEN(0)` | `true` |
| `ISEVEN(-3)` | `false` |
| `ISEVEN(2.5)` | `false` |
| `ISEVEN(null)` | `false` |

## Errors

None. The argument accepts **Any type**, so an **Error** argument is received as a value and is not propagated.


## Reference

- [Core standard](../README.md)
- [`ISNUM`](ISNUM.md)
