# LOWERCASE

Text [**Core**](../README.md) standard function. Transforms text into lowercase.

## Overloads

### Overload 1

Signature: `LOWERCASE(text <Text>)`

Collection template:

| # | Name |   | Base type | Extended type | Any type | Multiple | Optional |
| - | :--: | - | :-------: | :-----------: | :------: | :------: | :------: |
| 1 | text | | Text | - | false | false | false |

Algorithm:

- Returns `text` with every uppercase letter replaced by its lowercase form, following the Unicode default case mapping
- Characters that are not letters are not changed

Examples:

| text | LOWERCASE(text) |
| :-: | :-------: |
| "HELLO" | "hello" |
| "World" | "world" |

## Errors

- [`ARGUMENT_ERROR`](../errors/ARGUMENT_ERROR.md) - the arguments match no overload. If one of the arguments is an **Error**, that **Error** is returned instead (see [Evaluation](../../../semantics/evaluation.md#3-function-call)).


## Reference

- [Core standard](../README.md)
