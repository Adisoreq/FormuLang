# MAP

Array [**Core**](../README.md) standard function. Returns a copy of an array modified by applying a lambda function to its every element.

## Overloads

### Overload 1

Signature: `MAP(array <Array>, lambda <Delegate>)`

Collection template:

| # | Name |   | Base type | Extended type | Any type | Multiple | Optional |
| - | :--: | - | :-------: | :-----------: | :------: | :------: | :------: |
| 1 | array | | Array | - | false | false | false |
| 2 | lambda | | Delegate | - | false | false | false |

Algorithm:

- Calls `lambda` with every element of `array`, from the first to the last
- If a call returns an **Error**, stops and returns that **Error**
- Otherwise, returns a new array with the results, in the same order. `array` is not changed

Examples:

| Formula | Result |
| :--- | :--- |
| `MAP([1, 2, 3], (e) => MUL(e, 2))` | `[ 2, 4, 6 ]` |
| `MAP([1, 2, 3], (e) => ADD(e, 1))` | `[ 2, 3, 4 ]` |

## Errors

- [`ARGUMENT_ERROR`](../errors/ARGUMENT_ERROR.md) - the arguments match no overload, or `lambda` does not have exactly 1 parameter.
- An **Error** returned by `lambda` is returned unchanged.


## Reference

- [Core standard](../README.md)
