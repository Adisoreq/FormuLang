# MIN

Array [**Core**](../README.md) standard function. Returns the smallest value.

## Overloads

### Overload 1

Signature: `MIN(a <Number>, b <Number>)`

Description: Takes 2 numbers and returns the less one.

Collection template:

| # | Name |   | Base type | Extended type | Any type | Multiple | Optional |
| - | :--: | - | :-------: | :-----------: | :------: | :------: | :------: |
| 1 | a | | Number | - | false | false | false |
| 2 | b | | Number | - | false | false | false |

Algorithm:

- Returns `a` if `a` is less than or equal to `b`; otherwise returns `b`

Example:

- Formula: `MIN(3, 5)`
- Result: `3`

---

### Overload 2

Signature: `MIN(...numbers <Number>)`

Description: Returns the smallest number from the argument collection.

Collection template:

| # | Name |   | Base type | Extended type | Any type | Multiple | Optional |
| - | :--: | - | :-------: | :-----------: | :------: | :------: | :------: |
| 1 | numbers | | Number | - | false | true | false |

Algorithm:

- Returns the smallest of the arguments

Example:

- Formula: `MIN(5, 15, 25, 10, 20)`
- Result: `5`

---

### Overload 3

Signature: `MIN(numbers <Array<Number>>)`

Description: Returns the smallest number from an array of numbers.

Collection template:

| # | Name |   | Base type | Extended type | Any type | Multiple | Optional |
| - | :--: | - | :-------: | :-----------: | :------: | :------: | :------: |
| 1 | numbers | | Array&lt;Number&gt; | - | false | false | false |

Algorithm:

- If the array is empty, returns an `OPERATION_ERROR`
- Otherwise, returns the smallest element

Examples:

- Formula: `MIN([4, 5, 7, 9])`
  - Result: `4`
- Formula: `MIN([4, "5"])`
  - Result: `ARGUMENT_ERROR` (an element is not a **Number**, so no overload matches)

---

### Overload 4

Signature: `MIN(elements <Array>, handler <Delegate>)`

Description: Maps every element of the array with the handler function, and returns the smallest result.

Collection template:

| # | Name |   | Base type | Extended type | Any type | Multiple | Optional |
| - | :--: | - | :-------: | :-----------: | :------: | :------: | :------: |
| 1 | elements | | Array | - | false | false | false |
| 2 | handler | | Delegate | - | false | false | false |

Algorithm:

- If the array is empty, returns an `OPERATION_ERROR`
- Calls `handler` with every element, from the first to the last
- If a call returns an **Error**, stops and returns that **Error**
- If a call returns a value that is not a **Number**, returns an `OPERATION_ERROR`
- Otherwise, returns the smallest result

Examples:

- Formula: `MIN([true, 4, 5, 7, "9"], (e) => IF(ISNUM(e), e, 100))`
  - Result: `4`
- Formula: `MIN([ { name: "Anna", age: 15 }, { name: "Billy", age: 18 } ], (e) => e.age)`
  - Result: `15`

See [argument collection template](../../../implementation/argument_collection_template.md#matching-overloads) for the full overload resolution walkthrough of `MAX`.


## Errors

- [`OPERATION_ERROR`](../errors/OPERATION_ERROR.md) - the array is empty, or `handler` returns a value that is not a **Number**.
- [`ARGUMENT_ERROR`](../errors/ARGUMENT_ERROR.md) - the arguments match no overload, e.g. an element of the array is not a **Number** and no handler is given, or `handler` does not have exactly 1 parameter. If one of the arguments, or an element of an array argument, is an **Error**, that **Error** is returned instead (see [Evaluation](../../../semantics/evaluation.md#3-function-call)).
- An **Error** returned by `handler` is returned unchanged.


## Reference

- [Core standard](../README.md)
- [Argument template](../../../implementation/argument_template.md#properties)
