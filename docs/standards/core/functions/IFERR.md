# IFERR

Control flow [**Core**](../README.md) standard function. Returns the value, or a replacement if the value is an **Error**.

## Overloads

### Overload 1

Signature: `IFERR(value <Any>, fallback <Any>)`

Collection template:

| # | Name |   | Base type | Extended type | Any type | Multiple | Optional |
| - | :--: | - | :-------: | :-----------: | :------: | :------: | :------: |
| 1 | value | | - | - | true | false | false |
| 2 | fallback | | - | - | true | false | false |

Algorithm:

- If `value` is an **Error** (with any code), returns `fallback`
- Otherwise returns `value` unchanged

Examples:

| Formula | Result |
| :------ | :----- |
| `IFERR(DIV(1, 0), 0)` | `0` |
| `IFERR(5, 0)` | `5` |
| `IFERR([1, 2][5], null)` | `null` |

## Errors

None. Both arguments accept **Any type**, so an **Error** argument is received as a value and is not propagated. An **Error** in `fallback` is returned when it is selected.


## Reference

- [Core standard](../README.md)
- [`ISERR`](ISERR.md)
- [`IFNULL`](IFNULL.md)
