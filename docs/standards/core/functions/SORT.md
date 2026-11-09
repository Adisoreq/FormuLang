# SORT

Array [**Core**](../README.md) standard function. Returns the elements of an array in ascending order.

The sort is **stable**: elements that are equal (or have equal keys) keep their order from the original array. To sort in descending order, use [`REVERSE`](REVERSE.md) on the result, or a handler that returns a negated key.

Numbers are compared by value. Texts are compared character by character by their Unicode code points (case-sensitive, e.g. `"B"` comes before `"a"`); a text that is the beginning of another text comes first.

## Overloads

### Overload 1: Numbers

Signature: `SORT(numbers <Array<Number>>)`

Collection template:

| # | Name |   | Base type | Extended type | Any type | Multiple | Optional |
| - | :--: | - | :-------: | :-----------: | :------: | :------: | :------: |
| 1 | numbers | | Array&lt;Number&gt; | - | false | false | false |

Algorithm:

- Returns a new array with the elements of `numbers`, from the smallest to the greatest. `numbers` is not changed

Examples:

| Formula | Result |
| :--- | :--- |
| `SORT([3, 1, 2])` | `[ 1, 2, 3 ]` |
| `SORT([-1.5, 10, 0])` | `[ -1.5, 0, 10 ]` |
| `SORT([])` | `[ ]` |

---

### Overload 2: Texts

Signature: `SORT(texts <Array<Text>>)`

Collection template:

| # | Name |   | Base type | Extended type | Any type | Multiple | Optional |
| - | :--: | - | :-------: | :-----------: | :------: | :------: | :------: |
| 1 | texts | | Array&lt;Text&gt; | - | false | false | false |

Algorithm:

- Returns a new array with the elements of `texts` in ascending order. `texts` is not changed

Examples:

| Formula | Result |
| :--- | :--- |
| `SORT(["pear", "apple", "fig"])` | `[ "apple", "fig", "pear" ]` |
| `SORT(["b", "B", "a", "ab"])` | `[ "B", "a", "ab", "b" ]` |

---

### Overload 3: Handler

Signature: `SORT(elements <Array>, handler <Delegate>)`

Description: Sorts the elements by the keys returned by the handler.

Collection template:

| # | Name |   | Base type | Extended type | Any type | Multiple | Optional |
| - | :--: | - | :-------: | :-----------: | :------: | :------: | :------: |
| 1 | elements | | Array | - | false | false | false |
| 2 | handler | | Delegate | - | false | false | false |

Algorithm:

- Calls `handler` with every element, from the first to the last
- If a call returns an **Error**, stops and returns that **Error**
- If a call returns a value that is neither a **Number** nor a **Text**, or the results are not all of the same base type, returns an `OPERATION_ERROR`
- Otherwise, returns a new array with the elements of `elements`, ordered by their results in ascending order. `elements` is not changed

Examples:

| Formula | Result |
| :--- | :--- |
| `SORT([ { name: "Billy", age: 18 }, { name: "Anna", age: 15 } ], (e) => e.age)` | `[ { name: "Anna", age: 15 }, { name: "Billy", age: 18 } ]` |
| `SORT([1, 3, 2], (e) => -e)` | `[ 3, 2, 1 ]` |
| `SORT(["bb", "a", "ccc"], (e) => LEN(e))` | `[ "a", "bb", "ccc" ]` |
| `SORT([1, "a"])` | `[ARGUMENT_ERROR (6)] ...` |

## Errors

- [`OPERATION_ERROR`](../errors/OPERATION_ERROR.md) - `handler` returns a value that is neither a **Number** nor a **Text**, or returns values of different base types.
- [`ARGUMENT_ERROR`](../errors/ARGUMENT_ERROR.md) - the arguments match no overload, e.g. the elements are not all **Numbers** or all **Texts** and no handler is given, or `handler` does not have exactly 1 parameter. If one of the arguments, or an element of an array argument, is an **Error**, that **Error** is returned instead (see [Evaluation](../../../semantics/evaluation.md#3-function-call)).
- An **Error** returned by `handler` is returned unchanged.


## Reference

- [Core standard](../README.md)
- [`REVERSE`](REVERSE.md)
- [`MAX`](MAX.md), [`MIN`](MIN.md)
