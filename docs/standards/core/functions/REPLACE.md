# REPLACE

Text [**Core**](../README.md) standard function. Replaces every occurrence of a text with another text.

## Overloads

### Overload 1

Signature: `REPLACE(text <Text>, search <Text>, replacement <Text>)`

Collection template:

| # | Name |   | Base type | Extended type | Any type | Multiple | Optional |
| - | :--: | - | :-------: | :-----------: | :------: | :------: | :------: |
| 1 | text | | Text | - | false | false | false |
| 2 | search | | Text | - | false | false | false |
| 3 | replacement | | Text | - | false | false | false |

Algorithm:

- If `search` is `""`, returns an `OPERATION_ERROR`
- Finds every occurrence of `search` in `text`, from left to right, without overlaps, in the same way as [`SPLIT`](SPLIT.md)
- Returns a new text in which every occurrence is replaced with `replacement`. The comparison is case-sensitive. `replacement` is not searched again, and `text` is not changed
- If `search` does not occur in `text`, returns `text`

The result is the same as `JOIN(SPLIT(text, search), replacement)`.

Examples:

| Formula | Result |
| :--- | :--- |
| `REPLACE("a-b-c", "-", ", ")` | `"a, b, c"` |
| `REPLACE("aaaa", "aa", "b")` | `"bb"` |
| `REPLACE("Hello", "l", "")` | `"Heo"` |
| `REPLACE("abc", "x", "y")` | `"abc"` |
| `REPLACE("abc", "", "y")` | `[OPERATION_ERROR (3)] ...` |

## Errors

- [`OPERATION_ERROR`](../errors/OPERATION_ERROR.md) - `search` is `""`.
- [`ARGUMENT_ERROR`](../errors/ARGUMENT_ERROR.md) - the arguments match no overload. If one of the arguments is an **Error**, that **Error** is returned instead (see [Evaluation](../../../semantics/evaluation.md#3-function-call)).


## Reference

- [Core standard](../README.md)
- [`SPLIT`](SPLIT.md), [`JOIN`](JOIN.md)
