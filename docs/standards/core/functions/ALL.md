# ALL

Array [**Core**](../README.md) standard function. Checks if every element of an array satisfies the lambda function condition.

## Overloads

### Overload 1

Signature: `ALL(array <Array>, lambda <Delegate>)`

Collection template:

| # | Name |   | Base type | Extended type | Any type | Multiple | Optional |
| - | :--: | - | :-------: | :-----------: | :------: | :------: | :------: |
| 1 | array | | Array | - | false | false | false |
| 2 | lambda | | Delegate | - | false | false | false |

Algorithm:

- Calls `lambda` with every element of `array`, from the first to the last
- If a call returns an **Error**, stops and returns that **Error**
- If a call returns a value that is not a **Boolean**, returns an `OPERATION_ERROR`
- If a call returns `false`, stops and returns `false`. The remaining elements are not checked
- Otherwise, returns `true`. For an empty `array`, returns `true`

Examples:

| Formula | Result |
| :--- | :--- |
| `ALL([2, 4, 6], (e) => e % 2 == 0)` | `true` |
| `ALL([2, 3, 6], (e) => e % 2 == 0)` | `false` |
| `ALL([], (e) => e % 2 == 0)` | `true` |

## Errors

- [`OPERATION_ERROR`](../errors/OPERATION_ERROR.md) - `lambda` returns a value that is not a **Boolean**.
- [`ARGUMENT_ERROR`](../errors/ARGUMENT_ERROR.md) - the arguments match no overload, or `lambda` does not have exactly 1 parameter. If one of the arguments is an **Error**, that **Error** is returned instead (see [Evaluation](../../../semantics/evaluation.md#3-function-call)).
- An **Error** returned by `lambda` is returned unchanged.


## Reference

- [Core standard](../README.md)
- [`ANY`](ANY.md), [`FILTER`](FILTER.md)
