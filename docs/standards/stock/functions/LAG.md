# LAG

[**Stock**](../README.md) standard function. Returns the value of a series some candles before the current candle, or `null` if that candle does not exist yet.

`LAG(CLOSE)` is the previous close: the same value as `CLOSE[I - 1]`, but without an `INVALID_INDEX_ERROR` on the first candle.

## Overloads

### Overload 1

Signature: `LAG(series <Array>)`

Equivalent of `LAG(series, 1)`.

---

### Overload 2

Signature: `LAG(series <Array>, offset <Number>)`

Collection template:

| # | Name |   | Base type | Extended type | Any type | Multiple | Optional |
| - | :--: | - | :-------: | :-----------: | :------: | :------: | :------: |
| 1 | series | | Array | - | false | false | false |
| 2 | offset | | Number | - | false | false | false |

Algorithm:

1. If the function is not called in a context derived from the [Stock Context](../README.md#stock-context), returns an `OPERATION_ERROR`.
2. If `series` does not have `N` elements, returns an `OPERATION_ERROR`.
3. If `offset` is not a whole number or is negative, returns an `OPERATION_ERROR`. A future value cannot be read.
4. Let **position** be the position of the current candle (the element `series[I]`) minus `offset`. The position does not depend on `@array_indexing`.
5. If **position** is before the first element, returns `null`. Otherwise returns the element of `series` at **position**, unchanged.

Examples (`CLOSE` = `[1, 2, 3, 4, 5]`):

| Formula | Current candle | Result |
| :------ | :------------: | :----- |
| `LAG(CLOSE)` | the last one | `4` |
| `LAG(CLOSE, 2)` | the last one | `3` |
| `LAG(CLOSE, 0)` | the last one | `5` |
| `LAG(CLOSE)` | the first one | `null` |
| `CLOSE[I] - IFNULL(LAG(CLOSE), CLOSE[I])` | every candle | `0`, `1`, `1`, `1`, `1` (change from the previous close, `0` on the first candle; without `IFNULL`, `1 - null` is an `ARGUMENT_ERROR` in `core-1.2` and `null` since `core-1.3`) |
| `LAG(CLOSE, -1)` | any | `[OPERATION_ERROR (3)] ...` |

## Errors

- [`OPERATION_ERROR`](../../core/errors/OPERATION_ERROR.md) - the function is called outside of a Stock Context, `series` does not have `N` elements, or `offset` is not a whole number or is negative.
- [`ARGUMENT_ERROR`](../../core/errors/ARGUMENT_ERROR.md) - the arguments match no overload. If one of the arguments is an **Error**, that **Error** is returned instead (see [Evaluation](../../../semantics/evaluation.md#3-function-call)).

## Reference

- [Stock standard](../README.md)
- [Stock functions](README.md)
- [`WINDOW`](WINDOW.md)
