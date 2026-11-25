# ISODD

Type [**Core**](../README.md) standard function. Checks if the value is an odd whole number.

## Overloads

### Overload 1

Signature: `ISODD(value <Any>)`

Collection template:

| # | Name |   | Base type | Extended type | Any type | Multiple | Optional |
| - | :--: | - | :-------: | :-----------: | :------: | :------: | :------: |
| 1 | value | | - | - | true | false | false |

Algorithm:

- Returns `true` if `value` is a whole **Number** that is not divisible by `2`; otherwise returns `false`
- A value of another type (e.g. **Text** or `null`) gives `false`; the function never returns an **Error**

Examples:

| Formula | Result |
| :------ | :----- |
| `ISODD(3)` | `true` |
| `ISODD(-3)` | `true` |
| `ISODD(4)` | `false` |
| `ISODD(2.5)` | `false` |
| `ISODD("3")` | `false` |

## Errors

None. The argument accepts **Any type**, so an **Error** argument is received as a value and is not propagated.


## Reference

- [Core standard](../README.md)
- [`ISNUM`](ISNUM.md)
