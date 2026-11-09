# SEQ

Array [**Core**](../README.md) standard function. Creates an array of `n` numbers forming a sequence.

The first argument is always the number of elements, so `LEN(SEQ(n, ...))` is always `n`. Every next overload adds one parameter at the end.

By default, the sequence starts at `@array_indexing`, so `SEQ(LEN(array))` returns the valid indices of `array`.

## Overloads

### Overload 1: Indices

Signature: `SEQ(n <Number>)`

Collection template:

| # | Name |   | Base type | Extended type | Any type | Multiple | Optional |
| - | :--: | - | :-------: | :-----------: | :------: | :------: | :------: |
| 1 | n | | Number | - | false | false | false |

Algorithm:

- Equivalent of `SEQ(n, 1, @array_indexing)`

Examples:

| Formula | Result |
| :--- | :--- |
| `SEQ(5)` | `[ 0, 1, 2, 3, 4 ]` |
| `SEQ(5)` with `@array_indexing` = `1` | `[ 1, 2, 3, 4, 5 ]` |
| `SEQ(0)` | `[ ]` |

---

### Overload 2: Step

Signature: `SEQ(n <Number>, step <Number>)`

Collection template:

| # | Name |   | Base type | Extended type | Any type | Multiple | Optional |
| - | :--: | - | :-------: | :-----------: | :------: | :------: | :------: |
| 1 | n | | Number | - | false | false | false |
| 2 | step | | Number | - | false | false | false |

Algorithm:

- Equivalent of `SEQ(n, step, @array_indexing)`

Examples:

| Formula | Result |
| :--- | :--- |
| `SEQ(5, 2)` | `[ 0, 2, 4, 6, 8 ]` |
| `SEQ(4, -1)` | `[ 0, -1, -2, -3 ]` |
| `SEQ(3, 0.5)` | `[ 0, 0.5, 1 ]` |

---

### Overload 3: Step and start

Signature: `SEQ(n <Number>, step <Number>, start <Number>)`

Collection template:

| # | Name |   | Base type | Extended type | Any type | Multiple | Optional |
| - | :--: | - | :-------: | :-----------: | :------: | :------: | :------: |
| 1 | n | | Number | - | false | false | false |
| 2 | step | | Number | - | false | false | false |
| 3 | start | | Number | - | false | false | false |

Algorithm:

- If `n` is not a whole number or is negative, returns an `OPERATION_ERROR`
- Otherwise, returns an array of `n` elements, where the k-th element (counted from 0) is `start + k * step`. `@array_indexing` does not affect the result

Examples:

| Formula | Result |
| :--- | :--- |
| `SEQ(5, 2, 1)` | `[ 1, 3, 5, 7, 9 ]` |
| `SEQ(3, 10, 100)` | `[ 100, 110, 120 ]` |
| `SEQ(4, -2, 0)` with `@array_indexing` = `1` | `[ 0, -2, -4, -6 ]` |
| `SEQ(2.5, 1, 0)` | `[OPERATION_ERROR (3)] ...` |

---

### Overload 4: Generator

Signature: `SEQ(n <Number>, generator <Delegate>)`

Collection template:

| # | Name |   | Base type | Extended type | Any type | Multiple | Optional |
| - | :--: | - | :-------: | :-----------: | :------: | :------: | :------: |
| 1 | n | | Number | - | false | false | false |
| 2 | generator | | Delegate | - | false | false | false |

Algorithm:

- Equivalent of `MAP(SEQ(n), generator)`: calls `generator` with every index from `SEQ(n)`, and returns an array with the results
- If a call returns an **Error**, stops and returns that **Error**

The result of `generator` can be of any type.

Examples:

| Formula | Result |
| :--- | :--- |
| `SEQ(4, (i) => 1 + 10 * i)` | `[ 1, 11, 21, 31 ]` |
| `SEQ(3, (i) => i * i)` | `[ 0, 1, 4 ]` |
| `SEQ(3, (i) => "item")` | `[ "item", "item", "item" ]` |

## Errors

- [`OPERATION_ERROR`](../errors/OPERATION_ERROR.md) - `n` is not a whole number or is negative.
- [`ARGUMENT_ERROR`](../errors/ARGUMENT_ERROR.md) - the arguments match no overload, or `generator` does not have exactly 1 parameter. If one of the arguments is an **Error**, that **Error** is returned instead (see [Evaluation](../../../semantics/evaluation.md#3-function-call)).
- An **Error** returned by `generator` is returned unchanged.


## Reference

- [Core standard](../README.md)
- [`MAP`](MAP.md)
- [`RANGE`](RANGE.md) - sub-array of an existing array
