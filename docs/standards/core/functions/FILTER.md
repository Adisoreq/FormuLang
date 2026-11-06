# FILTER

Array [**Core**](../README.md) standard function. Returns a new array with elements that satisfy the lambda function condition.

## Overloads

### Overload 1

Signature: `FILTER(array <Array>, lambda <Delegate>)`

Collection template:

| # | Name |   | Base type | Extended type | Any type | Multiple | Optional |
| - | :--: | - | :-------: | :-----------: | :------: | :------: | :------: |
| 1 | array | | Array | - | false | false | false |
| 2 | lambda | | Delegate | - | false | false | false |

Algorithm:

- Calls `lambda` with every element of `array`, from the first to the last
- If a call returns an **Error**, stops and returns that **Error**
- If a call returns a value that is not a **Boolean**, returns an `OPERATION_ERROR`
- Returns a new array with the elements for which `lambda` returned `true`, in the same order. `array` is not changed

Examples:

| Formula | Result |
| :--- | :--- |
| `FILTER([1, 2, 3, 4], (e) => GRE(e, 2))` | `[ 3, 4 ]` |
| `FILTER([1, 2, 3, 4], (e) => EQU(MOD(e, 2), 0))` | `[ 2, 4 ]` |

## Errors

- [`OPERATION_ERROR`](../errors/OPERATION_ERROR.md) - `lambda` returns a value that is not a **Boolean**.
- [`ARGUMENT_ERROR`](../errors/ARGUMENT_ERROR.md) - the arguments match no overload, or `lambda` does not have exactly 1 parameter.
- An **Error** returned by `lambda` is returned unchanged.


## Reference

- [Core standard](../README.md)
