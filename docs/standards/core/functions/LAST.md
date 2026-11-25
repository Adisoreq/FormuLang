# LAST

Array [**Core**](../README.md) standard function. Returns the last element of an array, or the last element that satisfies the handler; `null` if there is none.

## Overloads

### Overload 1

Signature: `LAST(array <Array>)`

Collection template:

| # | Name |   | Base type | Extended type | Any type | Multiple | Optional |
| - | :--: | - | :-------: | :-----------: | :------: | :------: | :------: |
| 1 | array | | Array | - | false | false | false |

Algorithm:

- Returns the last element of `array`, or `null` if the array is empty

Examples:

| Formula | Result |
| :------ | :----- |
| `LAST([3, 5, 8])` | `8` |
| `LAST([])` | `null` |

---

### Overload 2

Signature: `LAST(array <Array>, handler <Delegate>)`

Collection template:

| # | Name |   | Base type | Extended type | Any type | Multiple | Optional |
| - | :--: | - | :-------: | :-----------: | :------: | :------: | :------: |
| 1 | array | | Array | - | false | false | false |
| 2 | handler | | Delegate | - | false | false | false |

Algorithm:

- Calls `handler` with the elements of `array`, from the last to the first, until it returns `true`
- If a call returns an **Error**, stops and returns that **Error**
- If a call returns a value that is not a **Boolean**, returns an `OPERATION_ERROR`
- Returns the last element for which `handler` returned `true`, or `null` if there is none (also for an empty array)

Examples:

| Formula | Result |
| :------ | :----- |
| `LAST([1, 4, 6, 7], (e) => MOD(e, 2) == 0)` | `6` |
| `LAST([1, "a", null], ISNUM)` | `1` |
| `LAST([1, 3], (e) => e > 5)` | `null` |

## Errors

- [`OPERATION_ERROR`](../errors/OPERATION_ERROR.md) - `handler` returns a value that is not a **Boolean**.
- [`ARGUMENT_ERROR`](../errors/ARGUMENT_ERROR.md) - the arguments match no overload, or `handler` does not accept exactly 1 argument. If one of the arguments is an **Error**, that **Error** is returned instead (see [Evaluation](../../../semantics/evaluation.md#3-function-call)).
- An **Error** returned by `handler` is returned unchanged.

> **Note:** `null` means that no element was found, but also that the found element is `null` (e.g. `FIRST([null, 1])`). Use `ANY(array, handler)` to tell these cases apart.


## Reference

- [Core standard](../README.md)
- [`FILTER`](FILTER.md)
- [`ANY`](ANY.md)
