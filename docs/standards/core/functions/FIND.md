# FIND

Text and array [**Core**](../README.md) standard function. Returns the position of the first occurrence of a value, or `null` if the value does not occur.

The position follows `@array_indexing`, so it can be passed to [`GET`](GET.md), [`RANGE`](RANGE.md) or [`SUBSTR`](SUBSTR.md).

## Overloads

### Overload 1: Text

Signature: `FIND(text <Text>, part <Text>)`

Collection template:

| # | Name |   | Base type | Extended type | Any type | Multiple | Optional |
| - | :--: | - | :-------: | :-----------: | :------: | :------: | :------: |
| 1 | text | | Text | - | false | false | false |
| 2 | part | | Text | - | false | false | false |

Algorithm:

- Searches `text` for `part` from left to right. The comparison is case-sensitive
- If `part` occurs in `text`, returns the position of the first character of its first occurrence, plus `@array_indexing`
- If `part` is `""`, returns `@array_indexing` (the position of the first character)
- Otherwise, returns `null`

Examples:

| Formula | Result |
| :--- | :--- |
| `FIND("FormuLang", "Lang")` | `5` |
| `FIND("FormuLang", "Lang")` with `@array_indexing` = `1` | `6` |
| `FIND("banana", "an")` | `1` |
| `FIND("banana", "x")` | `null` |

---

### Overload 2: Array

Signature: `FIND(array <Array>, value <Any>)`

Collection template:

| # | Name |   | Base type | Extended type | Any type | Multiple | Optional |
| - | :--: | - | :-------: | :-----------: | :------: | :------: | :------: |
| 1 | array | | Array | - | false | false | false |
| 2 | value | | - | - | true | false | false |

Algorithm:

- Compares every element of `array` with `value` using [`EQU`](EQU.md), from the first to the last
- Returns the index of the first element for which `EQU` returns `true`. The index follows `@array_indexing`
- If there is no such element, returns `null`

Examples:

| Formula | Result |
| :--- | :--- |
| `FIND([10, 20, 30, 20], 20)` | `1` |
| `FIND([10, 20, 30], 20)` with `@array_indexing` = `1` | `2` |
| `FIND([[1, 2], [3, 4]], [3, 4])` | `1` |
| `FIND([1, 2, 3], "2")` | `null` |

## Errors

- [`ARGUMENT_ERROR`](../errors/ARGUMENT_ERROR.md) - the arguments match no overload. If no overload matches and one of the arguments is an **Error**, that **Error** is returned instead (see [Evaluation](../../../semantics/evaluation.md#3-function-call)). The `value` of the array overload accepts **Any type**, so an **Error** `value` is compared like any other value.


## Reference

- [Core standard](../README.md)
- [`CONTAINS`](CONTAINS.md)
- [`EQU`](EQU.md)
