# LOWEST

[**Stock**](../README.md) standard [series function](README.md#series-functions). Returns the lowest of the last values of a series, up to the current candle or up to some candles back.

Since `stock-1.2`. `LOWEST(LOW, 10)` is the lowest low of the last 10 candles, including the current one. It works like [`HIGHEST`](HIGHEST.md), with the smallest value instead of the greatest one.

## Overloads

### Overload 1

Signature: `LOWEST(series <Array>, length <Number>)`

Equivalent of `LOWEST(series, length, 0)`.

---

### Overload 2

Signature: `LOWEST(series <Array>, length <Number>, offset <Number>)`

Collection template:

| # | Name |   | Base type | Extended type | Any type | Multiple | Optional |
| - | :--: | - | :-------: | :-----------: | :------: | :------: | :------: |
| 1 | series | | Array | - | false | false | false |
| 2 | length | | Number | - | false | false | false |
| 3 | offset | | Number | - | false | false | false |

Algorithm:

1. Checks the [common rules](README.md#series-functions): a Stock Context, and `N` elements of `series`.
2. If `length` is not a whole number or is less than `1`, or `offset` is not a whole number or is negative, returns an `OPERATION_ERROR`.
3. Let **end** be the position of the current candle minus `offset`. If there are fewer than `length` elements from the first element up to **end**, returns `null`.
4. Takes the `length` elements of `series` that end at **end**. If one of them is neither a **Number** nor `null`, returns an `OPERATION_ERROR`.
5. If all of them are `null`, returns `null`. Otherwise, returns the smallest of the **Number** elements.

Examples (`LOW` = `[5, 3, 6, 4, 8]`):

| Formula | Current candle | Result |
| :------ | :------------: | :----- |
| `LOWEST(LOW, 3)` | the last one | `4` |
| `LOWEST(LOW, 3, 1)` | the last one | `3` (the candles 2 - 4) |
| `LOWEST(LOW, 3)` | the second one | `null` (not enough candles) |
| `LOWEST(LOW, 5)` | the last one | `3` |

## Errors

- [`OPERATION_ERROR`](../../core/errors/OPERATION_ERROR.md) - the function is called outside of a Stock Context, `series` does not have `N` elements, `length` or `offset` is out of range, or a needed element is neither a **Number** nor `null`.
- [`ARGUMENT_ERROR`](../../core/errors/ARGUMENT_ERROR.md) - the arguments match no overload. If one of the arguments is an **Error**, that **Error** is returned instead (see [Evaluation](../../../semantics/evaluation.md#3-function-call)).

## Reference

- [Stock functions](README.md#series-functions)
- [`HIGHEST`](HIGHEST.md)
