# MAX

Array [**Core**](../README.md) standard function. Returns the greatest value.

## Overloads

### Overload 1

Signature: `MAX(a <Number>, b <Number>)`

Description: Takes 2 numbers and returns the greater one.

Collection template:

| # | Name |   | Base type | Extended type | Any type | Multiple | Optional |
| - | :--: | - | :-------: | :-----------: | :------: | :------: | :------: |
| 1 | a | | Number | - | false | false | false |
| 2 | b | | Number | - | false | false | false |

Algorithm:

- Returns `a` if `a` is greater than or equal to `b`; otherwise returns `b`

Example:

- Formula: `MAX(3, 5)`
- Result: `5`

---

### Overload 2

Signature: `MAX(...numbers <Number>)`

Description: Returns the greatest number from the argument collection.

Collection template:

| # | Name |   | Base type | Extended type | Any type | Multiple | Optional |
| - | :--: | - | :-------: | :-----------: | :------: | :------: | :------: |
| 1 | numbers | | Number | - | false | true | false |

Algorithm:

- Returns the greatest of the arguments

Example:

- Formula: `MAX(5, 15, 25, 10, 20)`
- Result: `25`

---

### Overload 3

Signature: `MAX(numbers <Array<Number>>)`

Description: Returns the greatest number from an array of numbers.

Collection template:

| # | Name |   | Base type | Extended type | Any type | Multiple | Optional |
| - | :--: | - | :-------: | :-----------: | :------: | :------: | :------: |
| 1 | numbers | | Array&lt;Number&gt; | - | false | false | false |

Since `core-1.3`, the elements may also be `null` (see [Missing values](../README.md#missing-values)).

Algorithm:

- If the array is empty, returns `null` (an `OPERATION_ERROR` before `core-1.3`)
- If an element is `null`, returns `null`: one missing element makes the result unknown, so `null` is not skipped
- Otherwise, returns the greatest element

Examples:

- Formula: `MAX([4, 5, 7, 9])`
  - Result: `9`
- Formula: `MAX([4, null, 9])`
  - Result: `null`
- Formula: `MAX([])`
  - Result: `null`
- Formula: `MAX([4, "5"])`
  - Result: `ARGUMENT_ERROR` (an element is not a **Number**, so no overload matches)

---

### Overload 4

Signature: `MAX(elements <Array>, handler <Delegate>)`

Description: Maps every element of the array with the handler function, and returns the greatest result.

Collection template:

| # | Name |   | Base type | Extended type | Any type | Multiple | Optional |
| - | :--: | - | :-------: | :-----------: | :------: | :------: | :------: |
| 1 | elements | | Array | - | false | false | false |
| 2 | handler | | Delegate | - | false | false | false |

Algorithm:

- If the array is empty, returns `null` (an `OPERATION_ERROR` before `core-1.3`)
- Calls `handler` with every element, from the first to the last
- If a call returns an **Error**, stops and returns that **Error**
- If a call returns a value that is neither a **Number** nor `null`, returns an `OPERATION_ERROR`
- If a call returns `null`, the result is `null` (since `core-1.3`)
- Otherwise, returns the greatest result

Examples:

- Formula: `MAX([true, 4, 5, 7, "9"], (e) => IF(ISNUM(e), e, 0))`
  - Result: `7`
- Formula: `MAX([ { name: "Anna", age: 15 }, { name: "Billy", age: 18 } ], (e) => e.age)`
  - Result: `18`

See [argument collection template](../../../implementation/argument_collection_template.md#matching-overloads) for the full overload resolution walkthrough of `MAX`.


## Errors

- [`OPERATION_ERROR`](../errors/OPERATION_ERROR.md) - `handler` returns a value that is neither a **Number** nor `null` (before `core-1.3`, also an empty array).
- [`ARGUMENT_ERROR`](../errors/ARGUMENT_ERROR.md) - the arguments match no overload, e.g. an element of the array is neither a **Number** nor `null` and no handler is given, or `handler` does not have exactly 1 parameter. If one of the arguments, or an element of an array argument, is an **Error**, that **Error** is returned instead (see [Evaluation](../../../semantics/evaluation.md#3-function-call)).
- An **Error** returned by `handler` is returned unchanged.


## Reference

- [Core standard](../README.md)
- [Argument template](../../../implementation/argument_template.md#properties)
