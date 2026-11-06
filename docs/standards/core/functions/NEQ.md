# NEQ

Comparison [**Core**](../README.md) standard function. Checks if values are different.

## Overloads

### Overload 1

Signature: `NEQ(a <Any>, b <Any>)`

Collection template:

| # | Name |   | Base type | Extended type | Any type | Multiple | Optional |
| - | :--: | - | :-------: | :-----------: | :------: | :------: | :------: |
| 1 | a | | - | - | true | false | false |
| 2 | b | | - | - | true | false | false |

Algorithm:

- Returns `NOT(EQU(a, b))`. See [EQU](EQU.md) for the comparison rules

Examples:

|  a  |  b  | NEQ(a, b) |
| :-: | :-: | :-------: |
| 5 | 6 | true |
| 5 | 5 | false |
| "a" | "b" | true |

## Errors

None. The argument accepts **Any type**, so an **Error** argument is received as a value and is not propagated.


## Reference

- [Core standard](../README.md)
