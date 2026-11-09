# ANY

Array [**Core**](../README.md) standard function. Checks if at least one element of an array satisfies the lambda function condition.

## Overloads

### Overload 1

Signature: `ANY(array <Array>, lambda <Delegate>)`

Collection template:

| # | Name |   | Base type | Extended type | Any type | Multiple | Optional |
| - | :--: | - | :-------: | :-----------: | :------: | :------: | :------: |
| 1 | array | | Array | - | false | false | false |
| 2 | lambda | | Delegate | - | false | false | false |

Algorithm:

- Calls `lambda` with every element of `array`, from the first to the last
- If a call returns an **Error**, stops and returns that **Error**
- If a call returns a value that is not a **Boolean**, returns an `OPERATION_ERROR`
- If a call returns `true`, stops and returns `true`. The remaining elements are not checked
- Otherwise, returns `false`. For an empty `array`, returns `false`

Examples:

| Formula | Result |
| :--- | :--- |
| `ANY([1, 5, 12], (e) => e > 10)` | `true` |
| `ANY([1, 5, 8], (e) => e > 10)` | `false` |
| `ANY([], (e) => e > 10)` | `false` |

## Errors

- [`OPERATION_ERROR`](../errors/OPERATION_ERROR.md) - `lambda` returns a value that is not a **Boolean**.
- [`ARGUMENT_ERROR`](../errors/ARGUMENT_ERROR.md) - the arguments match no overload, or `lambda` does not have exactly 1 parameter. If one of the arguments is an **Error**, that **Error** is returned instead (see [Evaluation](../../../semantics/evaluation.md#3-function-call)).
- An **Error** returned by `lambda` is returned unchanged.


## Reference

- [Core standard](../README.md)
- [`ALL`](ALL.md), [`FILTER`](FILTER.md), [`CONTAINS`](CONTAINS.md)
