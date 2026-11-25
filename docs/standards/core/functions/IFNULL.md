# IFNULL

Control flow [**Core**](../README.md) standard function. Returns the value, or a replacement if the value is `null`.

## Overloads

### Overload 1

Signature: `IFNULL(value <Any>, fallback <Any>)`

Collection template:

| # | Name |   | Base type | Extended type | Any type | Multiple | Optional |
| - | :--: | - | :-------: | :-----------: | :------: | :------: | :------: |
| 1 | value | | - | - | true | false | false |
| 2 | fallback | | - | - | true | false | false |

Algorithm:

- If `value` is `null`, returns `fallback`
- Otherwise returns `value` unchanged, including an **Error**

Examples:

| Formula | Result |
| :------ | :----- |
| `IFNULL(null, 0)` | `0` |
| `IFNULL(5, 0)` | `5` |
| `IFNULL(PREV, 0)` | `0` in the first iteration, then the previous result |
| `IFNULL(FIND("abc", "z"), -1)` | `-1` |

## Errors

None. Both arguments accept **Any type**, so an **Error** argument is received as a value and is not propagated.


## Reference

- [Core standard](../README.md)
- [`ISNULL`](ISNULL.md)
- [`IFERR`](IFERR.md)
