# TRIM

Text [**Core**](../README.md) standard function. Removes white spaces at the beginning and end of the text.

## Overloads

### Overload 1

Signature: `TRIM(text <Text>)`

Collection template:

| # | Name |   | Base type | Extended type | Any type | Multiple | Optional |
| - | :--: | - | :-------: | :-----------: | :------: | :------: | :------: |
| 1 | text | | Text | - | false | false | false |

Algorithm:

- Removes all white space characters (space, tab, new line, carriage return) from the beginning and the end of `text`
- White space between other characters is kept

Examples:

| text | TRIM(text) |
| :-: | :-------: |
| "  hello  " | "hello" |
| "test" | "test" |
| " a b " | "a b" |

## Errors

- [`ARGUMENT_ERROR`](../errors/ARGUMENT_ERROR.md) - the arguments match no overload. If one of the arguments is an **Error**, that **Error** is returned instead (see [Evaluation](../../../semantics/evaluation.md#3-function-call)).


## Reference

- [Core standard](../README.md)
