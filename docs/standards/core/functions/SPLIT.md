# SPLIT

Text [**Core**](../README.md) standard function. Splits a text string into an array by the specified separator.

## Overloads

### Overload 1

Signature: `SPLIT(text <Text>, separator <Text>)`

Collection template:

| # | Name |   | Base type | Extended type | Any type | Multiple | Optional |
| - | :--: | - | :-------: | :-----------: | :------: | :------: | :------: |
| 1 | text | | Text | - | false | false | false |
| 2 | separator | | Text | - | false | false | false |

Algorithm:

- If `separator` is `""`, returns an array with every character of `text` as a separate element
- Otherwise, finds every occurrence of `separator` in `text`, from left to right, without overlaps
- Returns the parts of `text` between the occurrences, in order. Empty parts are kept, e.g. `SPLIT("a,,b", ",")` is `[ "a", "", "b" ]`
- If `separator` does not occur in `text`, returns `[ text ]`

Examples:

| text | separator | SPLIT(text, separator) |
| :-: | :-: | :-------: |
| "a,b,c" | "," | [ "a", "b", "c" ] |
| "apples \| bananas \| lemons" | " \| " | [ "apples", "bananas", "lemons" ] |

## Errors

- [`ARGUMENT_ERROR`](../errors/ARGUMENT_ERROR.md) - the arguments match no overload. If one of the arguments is an **Error**, that **Error** is returned instead (see [Evaluation](../../../semantics/evaluation.md#3-function-call)).


## Reference

- [Core standard](../README.md)
