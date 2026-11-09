# SUBSTR

Text [**Core**](../README.md) standard function. Returns a part of the text that starts at the specified position.

Positions of characters follow `@array_indexing`, in the same way as array indices: with the default `@array_indexing` = `0`, the first character is at position `0`.

## Overloads

### Overload 1: To the end

Signature: `SUBSTR(text <Text>, start <Number>)`

Collection template:

| # | Name |   | Base type | Extended type | Any type | Multiple | Optional |
| - | :--: | - | :-------: | :-----------: | :------: | :------: | :------: |
| 1 | text | | Text | - | false | false | false |
| 2 | start | | Number | - | false | false | false |

Algorithm:

- Equivalent of `SUBSTR(text, start, LEN(text) - (start - @array_indexing))`: returns the characters from `start` to the end of `text`

Examples:

| Formula | Result |
| :--- | :--- |
| `SUBSTR("FormuLang", 5)` | `"Lang"` |
| `SUBSTR("FormuLang", 9)` | `""` |

---

### Overload 2: Length

Signature: `SUBSTR(text <Text>, start <Number>, length <Number>)`

Collection template:

| # | Name |   | Base type | Extended type | Any type | Multiple | Optional |
| - | :--: | - | :-------: | :-----------: | :------: | :------: | :------: |
| 1 | text | | Text | - | false | false | false |
| 2 | start | | Number | - | false | false | false |
| 3 | length | | Number | - | false | false | false |

Algorithm:

- Subtracts `@array_indexing` from `start`, so `0` is the position of the first character
- If `start` is not a whole number, or is less than `0` or greater than `LEN(text)`, returns an `INVALID_INDEX_ERROR`. `LEN(text)` itself is allowed: it is the position right after the last character
- If `length` is not a whole number or is negative, returns an `OPERATION_ERROR`
- If `start + length` is greater than `LEN(text)`, returns an `INVALID_INDEX_ERROR`
- Otherwise, returns a new text with `length` characters of `text`, beginning at `start`. `text` is not changed

Examples:

| Formula | Result |
| :--- | :--- |
| `SUBSTR("FormuLang", 0, 5)` | `"Formu"` |
| `SUBSTR("FormuLang", 1, 5)` with `@array_indexing` = `1` | `"Formu"` |
| `SUBSTR("abc", 1, 0)` | `""` |
| `SUBSTR("abc", 1, 5)` | `[INVALID_INDEX_ERROR (7)] ...` |

## Errors

- [`INVALID_INDEX_ERROR`](../errors/INVALID_INDEX_ERROR.md) - `start` is not a whole number, is outside of the text, or the part would end after the last character.
- [`OPERATION_ERROR`](../errors/OPERATION_ERROR.md) - `length` is not a whole number or is negative.
- [`ARGUMENT_ERROR`](../errors/ARGUMENT_ERROR.md) - the arguments match no overload. If one of the arguments is an **Error**, that **Error** is returned instead (see [Evaluation](../../../semantics/evaluation.md#3-function-call)).


## Reference

- [Core standard](../README.md)
- [`LEN`](LEN.md)
- [`FIND`](FIND.md)
- [`RANGE`](RANGE.md) - sub-array of an array
