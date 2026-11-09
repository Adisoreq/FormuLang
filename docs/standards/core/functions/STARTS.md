# STARTS

Text [**Core**](../README.md) standard function. Checks if the text begins with the specified part.

## Overloads

### Overload 1

Signature: `STARTS(text <Text>, part <Text>)`

Collection template:

| # | Name |   | Base type | Extended type | Any type | Multiple | Optional |
| - | :--: | - | :-------: | :-----------: | :------: | :------: | :------: |
| 1 | text | | Text | - | false | false | false |
| 2 | part | | Text | - | false | false | false |

Algorithm:

- Returns `true` if the first `LEN(part)` characters of `text` are the same as `part` (case-sensitive), otherwise `false`
- Every text begins with `""`

Examples:

| Formula | Result |
| :--- | :--- |
| `STARTS("FormuLang", "Form")` | `true` |
| `STARTS("FormuLang", "form")` | `false` |
| `STARTS("ab", "abc")` | `false` |
| `STARTS("abc", "")` | `true` |

## Errors

- [`ARGUMENT_ERROR`](../errors/ARGUMENT_ERROR.md) - the arguments match no overload. If one of the arguments is an **Error**, that **Error** is returned instead (see [Evaluation](../../../semantics/evaluation.md#3-function-call)).


## Reference

- [Core standard](../README.md)
- [`ENDS`](ENDS.md), [`CONTAINS`](CONTAINS.md)
