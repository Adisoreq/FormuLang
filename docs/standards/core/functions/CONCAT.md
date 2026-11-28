# CONCAT

Text and array [**Core**](../README.md) standard function. Joins two text strings, or two arrays, together.

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

---

### Overload 2: Arrays

Since `core-1.3`. Signature: `CONCAT(array1 <Array>, array2 <Array>)`

Collection template:

| # | Name |   | Base type | Extended type | Any type | Multiple | Optional |
| - | :--: | - | :-------: | :-----------: | :------: | :------: | :------: |
| 1 | array1 | | Array | - | false | false | false |
| 2 | array2 | | Array | - | false | false | false |

Algorithm:

- Returns a new **Array** with the elements of `array1` followed by the elements of `array2`; the arguments are not changed
- The elements are not copied deeply: a nested array or object is taken as a whole

Examples:

| Formula | Result |
| :------ | :----- |
| `CONCAT([1, 2], [3])` | `[1, 2, 3]` |
| `CONCAT([], [1])` | `[1]` |
| `CONCAT([[1]], [[2]])` | `[[1], [2]]` |

The operator `+` stays an [`ADD`](ADD.md) of numbers or texts; `[1] + [2]` matches no overload.

## Errors

- [`ARGUMENT_ERROR`](../errors/ARGUMENT_ERROR.md) - the arguments match no overload. If one of the arguments is an **Error**, that **Error** is returned instead (see [Evaluation](../../../semantics/evaluation.md#3-function-call)).


## Reference

- [Core standard](../README.md)
- [`APPEND`](APPEND.md)
