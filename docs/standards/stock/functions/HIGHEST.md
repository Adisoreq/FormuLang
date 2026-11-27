# HIGHEST

[**Stock**](../README.md) standard [series function](README.md#series-functions). Returns the highest of the last values of a series, up to the current candle or up to some candles back.

Since `stock-1.2`. `HIGHEST(HIGH, 10)` is the highest high of the last 10 candles, including the current one. Unlike `WINDOW(HIGH, 10, MAX)`, it skips `null` values.

## Overloads

### Overload 1

Signature: `HIGHEST(series <Array>, length <Number>)`

Equivalent of `HIGHEST(series, length, 0)`.

---

### Overload 2

Signature: `HIGHEST(series <Array>, length <Number>, offset <Number>)`

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
5. If all of them are `null`, returns `null`. Otherwise, returns the greatest of the **Number** elements.

Examples (`HIGH` = `[5, 7, 6, 9, 8]`):

| Formula | Current candle | Result |
| :------ | :------------: | :----- |
| `HIGHEST(HIGH, 3)` | the last one | `9` |
| `HIGHEST(HIGH, 3, 2)` | the last one | `7` (the candles 1 - 3) |
| `HIGHEST(HIGH, 3)` | the second one | `null` (not enough candles) |
| `HIGHEST([null, 2, null, 1, null], 3)` | the last one | `1` |
| `HIGHEST(HIGH, 0)` | any | `[OPERATION_ERROR (3)] ...` |

A stop loss above the highest high of the last 10 candles, with a buffer of half an ATR:

```php
HIGHEST(HIGH, 10) + 0.5 * $atr
```

## Errors

- [`OPERATION_ERROR`](../../core/errors/OPERATION_ERROR.md) - the function is called outside of a Stock Context, `series` does not have `N` elements, `length` or `offset` is out of range, or a needed element is neither a **Number** nor `null`.
- [`ARGUMENT_ERROR`](../../core/errors/ARGUMENT_ERROR.md) - the arguments match no overload. If one of the arguments is an **Error**, that **Error** is returned instead (see [Evaluation](../../../semantics/evaluation.md#3-function-call)).

## Reference

- [Stock functions](README.md#series-functions)
- [`LOWEST`](LOWEST.md)
- [`WINDOW`](WINDOW.md)
