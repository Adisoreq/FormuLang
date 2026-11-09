# REVERSE

Array and text [**Core**](../README.md) standard function. Returns the elements of an array, or the characters of a text, in the reverse order.

## Overloads

### Overload 1: Array

Signature: `REVERSE(array <Array>)`

Collection template:

| # | Name |   | Base type | Extended type | Any type | Multiple | Optional |
| - | :--: | - | :-------: | :-----------: | :------: | :------: | :------: |
| 1 | array | | Array | - | false | false | false |

Algorithm:

- Returns a new array with the elements of `array`, from the last to the first. Nested arrays are not reversed. `array` is not changed

Examples:

| Formula | Result |
| :--- | :--- |
| `REVERSE([1, 2, 3])` | `[ 3, 2, 1 ]` |
| `REVERSE([[1, 2], [3, 4]])` | `[ [ 3, 4 ], [ 1, 2 ] ]` |
| `REVERSE([])` | `[ ]` |

---

### Overload 2: Text

Signature: `REVERSE(text <Text>)`

Collection template:

| # | Name |   | Base type | Extended type | Any type | Multiple | Optional |
| - | :--: | - | :-------: | :-----------: | :------: | :------: | :------: |
| 1 | text | | Text | - | false | false | false |

Algorithm:

- Returns a new text with the characters of `text`, from the last to the first

Examples:

| Formula | Result |
| :--- | :--- |
| `REVERSE("abc")` | `"cba"` |
| `REVERSE("")` | `""` |

## Errors

- [`ARGUMENT_ERROR`](../errors/ARGUMENT_ERROR.md) - the arguments match no overload. If one of the arguments is an **Error**, that **Error** is returned instead (see [Evaluation](../../../semantics/evaluation.md#3-function-call)).


## Reference

- [Core standard](../README.md)
- [`SORT`](SORT.md)
