# WINDOW

[**Stock**](../README.md) standard function. Returns the last values of a series up to the current candle, or `null` if there are not enough candles yet. With a handler, returns the result of the handler for these values.

`WINDOW(SOURCE, 20, AVG)` is a 20-candle simple moving average: `null` for the first 19 candles, then the mean of the last 20 values. It replaces `IF(I < 19, null, AVG(RANGE(SOURCE, I - 19, I)))`.

## Overloads

### Overload 1

Signature: `WINDOW(series <Array>, length <Number>)`

Collection template:

| # | Name |   | Base type | Extended type | Any type | Multiple | Optional |
| - | :--: | - | :-------: | :-----------: | :------: | :------: | :------: |
| 1 | series | | Array | - | false | false | false |
| 2 | length | | Number | - | false | false | false |

Algorithm:

1. If the function is not called in a context derived from the [Stock Context](../README.md#stock-context), returns an `OPERATION_ERROR`.
2. If `series` does not have `N` elements, returns an `OPERATION_ERROR`.
3. If `length` is not a whole number or is less than `1`, returns an `OPERATION_ERROR`.
4. Let **position** be the position of the current candle (the element `series[I]`). The position does not depend on `@array_indexing`.
5. If there are fewer than `length` elements from the first element up to **position**, returns `null`.
6. Otherwise returns a new array with the `length` elements of `series` that end at **position**, in their order. The elements are not checked: they may be `null`.

Examples (`CLOSE` = `[1, 2, 3, 4, 5]`):

| Formula | Current candle | Result |
| :------ | :------------: | :----- |
| `WINDOW(CLOSE, 3)` | the last one | `[3, 4, 5]` |
| `WINDOW(CLOSE, 3)` | the second one | `null` |
| `WINDOW(CLOSE, 1)` | the first one | `[1]` |
| `WINDOW(CLOSE, 0)` | any | `[OPERATION_ERROR (3)] ...` |

---

### Overload 2

Signature: `WINDOW(series <Array>, length <Number>, handler <Delegate>)`

Collection template:

| # | Name |   | Base type | Extended type | Any type | Multiple | Optional |
| - | :--: | - | :-------: | :-----------: | :------: | :------: | :------: |
| 1 | series | | Array | - | false | false | false |
| 2 | length | | Number | - | false | false | false |
| 3 | handler | | Delegate | - | false | false | false |

Algorithm:

1. Computes the window like `WINDOW(series, length)`. If it is an **Error**, returns it.
2. If the window is `null`, returns `null` without calling `handler`.
3. Otherwise calls `handler` with the window as its only argument and returns the result unchanged, including an **Error**.

Examples (`CLOSE` = `[1, 2, 3, 4, 5]`):

| Formula | Current candle | Result |
| :------ | :------------: | :----- |
| `WINDOW(CLOSE, 3, AVG)` | the last one | `4` |
| `WINDOW(CLOSE, 3, AVG)` | the second one | `null` |
| `WINDOW(CLOSE, 3, (w) => MAX(w) - MIN(w))` | the last one | `2` |
| `WINDOW(HIGH, 20, MAX)` | every candle | the highest high of the last 20 candles, `null` for the first 19 |

## Errors

- [`OPERATION_ERROR`](../../core/errors/OPERATION_ERROR.md) - the function is called outside of a Stock Context, `series` does not have `N` elements, or `length` is not a whole number or is less than `1`.
- [`ARGUMENT_ERROR`](../../core/errors/ARGUMENT_ERROR.md) - the arguments match no overload, or `handler` is a lambda that does not have exactly 1 parameter. If one of the arguments is an **Error**, that **Error** is returned instead (see [Evaluation](../../../semantics/evaluation.md#3-function-call)).
- An **Error** returned by `handler` is returned unchanged.

## Reference

- [Stock standard](../README.md)
- [Stock functions](README.md)
- [`LAG`](LAG.md)
- [`AVG`](../../core/functions/AVG.md)
