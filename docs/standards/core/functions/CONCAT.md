# CONCAT

Text [**Core**](../README.md) standard function. Joins two text strings together.

## Overloads

### Overload 1

Signature: `CONCAT(text1 <Text>, text2 <Text>)`

Collection template:

| # | Name |   | Base type | Extended type | Any type | Multiple | Optional |
| - | :--: | - | :-------: | :-----------: | :------: | :------: | :------: |
| 1 | text1 | | Text | - | false | false | false |
| 2 | text2 | | Text | - | false | false | false |

Algorithm:

- Returns a new **Text** that contains the characters of `text1` followed by the characters of `text2`

Examples:

| text1 | text2 | CONCAT(text1, text2) |
| :-: | :-: | :-------: |
| "Hello, " | "world!" | "Hello, world!" |
| "foo" | "bar" | "foobar" |
| "" | "test" | "test" |

## Errors

- [`ARGUMENT_ERROR`](../errors/ARGUMENT_ERROR.md) - the arguments match no overload. If one of the arguments is an **Error**, that **Error** is returned instead (see [Evaluation](../../../semantics/evaluation.md#3-function-call)).


## Reference

- [Core standard](../README.md)
