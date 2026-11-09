# ENDS

Text [**Core**](../README.md) standard function. Checks if the text ends with the specified part.

## Overloads

### Overload 1

Signature: `ENDS(text <Text>, part <Text>)`

Collection template:

| # | Name |   | Base type | Extended type | Any type | Multiple | Optional |
| - | :--: | - | :-------: | :-----------: | :------: | :------: | :------: |
| 1 | text | | Text | - | false | false | false |
| 2 | part | | Text | - | false | false | false |

Algorithm:

- Returns `true` if the last `LEN(part)` characters of `text` are the same as `part` (case-sensitive), otherwise `false`
- Every text ends with `""`

Examples:

| Formula | Result |
| :--- | :--- |
| `ENDS("report.csv", ".csv")` | `true` |
| `ENDS("report.csv", ".CSV")` | `false` |
| `ENDS("abc", "")` | `true` |

## Errors

- [`ARGUMENT_ERROR`](../errors/ARGUMENT_ERROR.md) - the arguments match no overload. If one of the arguments is an **Error**, that **Error** is returned instead (see [Evaluation](../../../semantics/evaluation.md#3-function-call)).


## Reference

- [Core standard](../README.md)
- [`STARTS`](STARTS.md), [`CONTAINS`](CONTAINS.md)
