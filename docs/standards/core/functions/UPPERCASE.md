# UPPERCASE

Text [**Core**](../README.md) standard function. Transforms text into uppercase.

## Overloads

### Overload 1

Signature: `UPPERCASE(text <Text>)`

Collection template:

| # | Name |   | Base type | Extended type | Any type | Multiple | Optional |
| - | :--: | - | :-------: | :-----------: | :------: | :------: | :------: |
| 1 | text | | Text | - | false | false | false |

Algorithm:

- Returns `text` with every lowercase letter replaced by its uppercase form, following the Unicode default case mapping
- Characters that are not letters are not changed

Examples:

| text | UPPERCASE(text) |
| :-: | :-------: |
| "hello" | "HELLO" |
| "World" | "WORLD" |

## Errors

- [`ARGUMENT_ERROR`](../errors/ARGUMENT_ERROR.md) - the arguments match no overload. If one of the arguments is an **Error**, that **Error** is returned instead (see [Evaluation](../../../semantics/evaluation.md#3-function-call)).


## Reference

- [Core standard](../README.md)
