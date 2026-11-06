# JOIN

Text [**Core**](../README.md) standard function. Joins array elements into a single text string using the specified separator.

## Overloads

### Overload 1

Signature: `JOIN(array <Array>, separator? <Text>)`

Collection template:

| # | Name |   | Base type | Extended type | Any type | Multiple | Optional |
| - | :--: | - | :-------: | :-----------: | :------: | :------: | :------: |
| 1 | array | | Array | - | false | false | false |
| 2 | separator | | Text | - | false | false | true |

Algorithm:

- Converts every element of `array` to **Text** with [TEXT](TEXT.md)
- If an element is an **Error**, returns that **Error**
- Returns the converted elements in their order, with `separator` between each two neighbouring elements. If `separator` is omitted, `""` is used
- An empty array returns `""`

Examples:

| array | separator | JOIN(array, separator) |
| :-: | :-: | :-------: |
| [ 1, 2, 3 ] | | "123" |
| [ 1, 2, 3 ] | "-" | "1-2-3" |
| [ "a", "b" ] | ", " | "a, b" |

> **Note:** When `separator` is omitted, elements are joined with no delimiter between them. See [argument collection template](../../../implementation/argument_collection_template.md#optional-argument) for the optional-argument matching rules.

## Errors

- [`ARGUMENT_ERROR`](../errors/ARGUMENT_ERROR.md) - the arguments match no overload.
- An **Error** element of `array` is returned unchanged.


## Reference

- [Core standard](../README.md)
