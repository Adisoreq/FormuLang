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

`lambda` has 1 or 2 parameters:

| Lambda | Parameters |
| :----- | :--------- |
| `(e) => ...` | `e` - the element. |
| `(e, i) => ...` | `e` - the element, `i` - its index. The index follows `@array_indexing`, so `array[i]` is `e`. |

Algorithm:

- Calls `lambda` with every element of `array`, from the first to the last. If `lambda` has 2 parameters, the index of the element is passed as the second argument
- If a call returns an **Error**, stops and returns that **Error**
- Otherwise, returns a new array with the results, in the same order. `array` is not changed

Examples:

| Formula | Result |
| :--- | :--- |
| `MAP([1, 2, 3], (e) => MUL(e, 2))` | `[ 2, 4, 6 ]` |
| `MAP([1, 2, 3], (e) => ADD(e, 1))` | `[ 2, 3, 4 ]` |
| `MAP([10, 20, 30], (e, i) => i)` | `[ 0, 1, 2 ]` |
| `MAP([10, 20, 30], (e, i) => i)` with `@array_indexing` = `1` | `[ 1, 2, 3 ]` |
| `$b = [1, 2, 3]` <br> `MAP([10, 20, 30], (e, i) => e + $b[i])` | `[ 11, 22, 33 ]` |

The last example joins two arrays element by element: the index `i` points to the matching element of the other array.

## Errors

- [`ARGUMENT_ERROR`](../errors/ARGUMENT_ERROR.md) - the arguments match no overload, or `lambda` does not have 1 or 2 parameters.
- An **Error** returned by `lambda` is returned unchanged.


## Reference

- [Core standard](../README.md)
- [`SEQ`](SEQ.md)
