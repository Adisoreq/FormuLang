# READY

[**Stock**](../README.md) standard [series function](README.md#series-functions). Checks if the last values of a series, up to the current candle, exist and are not `null`.

Since `stock-1.2`. It replaces the checks of `null` at the beginning of a formula, while the indicators are warming up: `READY($macd, 2)` is `true` when `$macd[I - 1]` and `$macd[I]` both have a value.

## Overloads

### Overload 1

Signature: `READY(series <Array>, n <Number>)`

Collection template:

| # | Name |   | Base type | Extended type | Any type | Multiple | Optional |
| - | :--: | - | :-------: | :-----------: | :------: | :------: | :------: |
| 1 | series | | Array | - | false | false | false |
| 2 | n | | Number | - | false | false | false |

Algorithm:

1. Checks the [common rules](README.md#series-functions): a Stock Context, and `N` elements of `series`.
2. If `n` is not a whole number or is less than `1`, returns an `OPERATION_ERROR`.
3. If there are fewer than `n` elements from the first element up to the position of the current candle, returns `false`.
4. Returns `true` if none of the `n` elements that end at the position of the current candle is `null`; otherwise returns `false`. The elements may be of any type.

Examples (`$s` = `[null, null, 3, 4, 5]`):

| Formula | Current candle | Result |
| :------ | :------------: | :----- |
| `READY($s, 1)` | the third one | `true` |
| `READY($s, 2)` | the third one | `false` |
| `READY($s, 2)` | the fourth one | `true` |
| `READY(CLOSE, 3)` | the second one | `false` (not enough candles) |
| `READY($s, 0)` | any | `[OPERATION_ERROR (3)] ...` |

## Errors

- [`OPERATION_ERROR`](../../core/errors/OPERATION_ERROR.md) - the function is called outside of a Stock Context, `series` does not have `N` elements, or `n` is not a whole number or is less than `1`.
- [`ARGUMENT_ERROR`](../../core/errors/ARGUMENT_ERROR.md) - the arguments match no overload. If one of the arguments is an **Error**, that **Error** is returned instead (see [Evaluation](../../../semantics/evaluation.md#3-function-call)).

## Reference

- [Stock functions](README.md#series-functions)
- [`WINDOW`](WINDOW.md)
