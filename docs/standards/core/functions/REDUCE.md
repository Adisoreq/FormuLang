# REDUCE

Array [**Core**](../README.md) standard function. Combines all elements of an array into a single value by calling a lambda function for every element.

## Overloads

### Overload 1

Signature: `REDUCE(array <Array>, lambda <Delegate>, initial <Any>)`

Collection template:

| # | Name |   | Base type | Extended type | Any type | Multiple | Optional |
| - | :--: | - | :-------: | :-----------: | :------: | :------: | :------: |
| 1 | array | | Array | - | false | false | false |
| 2 | lambda | | Delegate | - | false | false | false |
| 3 | initial | | - | - | true | false | false |

`lambda` has 2 or 3 parameters:

| Lambda | Parameters |
| :----- | :--------- |
| `(acc, e) => ...` | `acc` - the accumulated value, `e` - the element. |
| `(acc, e, i) => ...` | `acc` - the accumulated value, `e` - the element, `i` - its index. The index follows `@array_indexing`, so `array[i]` is `e`. |

Algorithm:

- The accumulated value is `initial`
- Calls `lambda` with the accumulated value and every element of `array`, from the first to the last. If `lambda` has 3 parameters, the index of the element is passed as the third argument
- The result of every call becomes the accumulated value
- If a call returns an **Error**, stops and returns that **Error**
- Otherwise, returns the accumulated value after the last call. If `array` is empty, returns `initial`. `array` is not changed

The result can be of any type.

Examples:

| Formula | Result |
| :--- | :--- |
| `REDUCE([1, 2, 3, 4], (acc, e) => acc + e, 0)` | `10` |
| `REDUCE([3, 7, 5], (acc, e) => MAX(acc, e), 0)` | `7` |
| `REDUCE(["a", "b", "c"], (acc, e) => e + acc, "")` | `"cba"` |
| `REDUCE([10, 20], (acc, e, i) => acc + i * e, 0)` | `20` |
| `REDUCE([], (acc, e) => acc + e, 100)` | `100` |
| `REDUCE([2, 3, 4], (acc, e) => IF(e > acc.max, { max: e }, acc), { max: 0 })` | `{ max: 4 }` |

## Errors

- [`ARGUMENT_ERROR`](../errors/ARGUMENT_ERROR.md) - the arguments match no overload, or `lambda` does not have 2 or 3 parameters. If `array` or `lambda` is an **Error**, that **Error** is returned instead (see [Evaluation](../../../semantics/evaluation.md#3-function-call)). `initial` accepts **Any type**, so an **Error** `initial` is passed to `lambda` like any other value.
- An **Error** returned by `lambda` is returned unchanged.


## Reference

- [Core standard](../README.md)
- [`MAP`](MAP.md), [`FILTER`](FILTER.md)
- [`SUM`](SUM.md), [`PROD`](PROD.md)
