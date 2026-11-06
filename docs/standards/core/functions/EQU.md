# EQU

Comparison [**Core**](../README.md) standard function. Checks if values are identical.

## Overloads

### Overload 1

Signature: `EQU(a <Any>, b <Any>)`

Collection template:

| # | Name |   | Base type | Extended type | Any type | Multiple | Optional |
| - | :--: | - | :-------: | :-----------: | :------: | :------: | :------: |
| 1 | a | | - | - | true | false | false |
| 2 | b | | - | - | true | false | false |

Algorithm:

- If `a` and `b` have different base types, returns `false`
- **Null**: returns `true`
- **Boolean**, **Number**, **Text**: returns `true` if the values are the same (texts are compared character by character, case-sensitive)
- **Array**: returns `true` if both arrays have the same length and `EQU` returns `true` for every pair of elements at the same index
- **Object**: returns `true` if both objects have the same extended type, the same set of keys, and `EQU` returns `true` for the values of every key
- **Delegate**: returns `true` if both refer to the same named function or to the same lambda function
- **Error**: returns `true` if both errors have the same code and the same details

Examples:

|  a  |  b  | EQU(a, b) |
| :-: | :-: | :-------: |
| 5 | 5 | true |
| 5 | 6 | false |
| "a" | "a" | true |

## Errors

None. The argument accepts **Any type**, so an **Error** argument is received as a value and is not propagated.


## Reference

- [Core standard](../README.md)
