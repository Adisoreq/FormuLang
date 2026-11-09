# CONTAINS

Text and array [**Core**](../README.md) standard function. Checks if a text contains the specified part, or if an array contains the specified value.

## Overloads

### Overload 1: Text

Signature: `CONTAINS(text <Text>, part <Text>)`

Collection template:

| # | Name |   | Base type | Extended type | Any type | Multiple | Optional |
| - | :--: | - | :-------: | :-----------: | :------: | :------: | :------: |
| 1 | text | | Text | - | false | false | false |
| 2 | part | | Text | - | false | false | false |

Algorithm:

- Returns `true` if `part` occurs in `text` (case-sensitive), otherwise `false`. Equivalent of `!ISNULL(FIND(text, part))`
- Every text contains `""`

Examples:

| Formula | Result |
| :--- | :--- |
| `CONTAINS("FormuLang", "mu")` | `true` |
| `CONTAINS("FormuLang", "MU")` | `false` |

---

### Overload 2: Array

Signature: `CONTAINS(array <Array>, value <Any>)`

Collection template:

| # | Name |   | Base type | Extended type | Any type | Multiple | Optional |
| - | :--: | - | :-------: | :-----------: | :------: | :------: | :------: |
| 1 | array | | Array | - | false | false | false |
| 2 | value | | - | - | true | false | false |

Algorithm:

- Returns `true` if [`EQU`](EQU.md) returns `true` for `value` and at least one element of `array`, otherwise `false`. Equivalent of `!ISNULL(FIND(array, value))`

Examples:

| Formula | Result |
| :--- | :--- |
| `CONTAINS([1, 2, 3], 2)` | `true` |
| `CONTAINS([1, 2, 3], "2")` | `false` |
| `CONTAINS([], null)` | `false` |

## Errors

- [`ARGUMENT_ERROR`](../errors/ARGUMENT_ERROR.md) - the arguments match no overload. If no overload matches and one of the arguments is an **Error**, that **Error** is returned instead (see [Evaluation](../../../semantics/evaluation.md#3-function-call)). The `value` of the array overload accepts **Any type**, so an **Error** `value` is compared like any other value.


## Reference

- [Core standard](../README.md)
- [`FIND`](FIND.md)
- [`ANY`](ANY.md) - checks elements with a condition
