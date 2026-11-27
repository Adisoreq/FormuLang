# VALUE_WHEN

[**Stock**](../README.md) standard [series function](README.md#series-functions). Returns the value of a series at the last candle (or an earlier one) where a condition was `true`.

Since `stock-1.2`. `VALUE_WHEN($cross, CLOSE)` is the close of the candle of the last crossing.

## Overloads

### Overload 1

Signature: `VALUE_WHEN(condition <Array>, series <Array>)`

Equivalent of `VALUE_WHEN(condition, series, 0)`.

---

### Overload 2

Signature: `VALUE_WHEN(condition <Array>, series <Array>, occurrence <Number>)`

Collection template:

| # | Name |   | Base type | Extended type | Any type | Multiple | Optional |
| - | :--: | - | :-------: | :-----------: | :------: | :------: | :------: |
| 1 | condition | | Array | - | false | false | false |
| 2 | series | | Array | - | false | false | false |
| 3 | occurrence | | Number | - | false | false | false |

Algorithm:

1. Checks the [common rules](README.md#series-functions): a Stock Context, and `N` elements of `condition` and of `series`.
2. If `occurrence` is not a whole number or is negative, returns an `OPERATION_ERROR`.
3. Goes through the elements of `condition` from the position of the current candle back to the first element, like [`BARS_SINCE`](BARS_SINCE.md), and counts the `true` elements. The `true` element number `occurrence + 1` (the first one for `occurrence` = `0`) is the **found** candle. An element that is neither a **Boolean** nor `null` is an `OPERATION_ERROR`.
4. If there is no found candle, returns `null`.
5. Otherwise, returns the element of `series` at the found candle, unchanged (it may be `null` or of any type).

Examples (`$c` = `[true, false, true, false]`, `CLOSE` = `[10, 11, 12, 13]`):

| Formula | Current candle | Result |
| :------ | :------------: | :----- |
| `VALUE_WHEN($c, CLOSE)` | the last one | `12` |
| `VALUE_WHEN($c, CLOSE, 1)` | the last one | `10` |
| `VALUE_WHEN($c, CLOSE, 2)` | the last one | `null` |
| `VALUE_WHEN($c, CLOSE)` | the second one | `10` |
| `VALUE_WHEN($c, CLOSE, -1)` | any | `[OPERATION_ERROR (3)] ...` |

## Errors

- [`OPERATION_ERROR`](../../core/errors/OPERATION_ERROR.md) - the function is called outside of a Stock Context, `condition` or `series` does not have `N` elements, `occurrence` is out of range, or a needed element of `condition` is neither a **Boolean** nor `null`.
- [`ARGUMENT_ERROR`](../../core/errors/ARGUMENT_ERROR.md) - the arguments match no overload. If one of the arguments is an **Error**, that **Error** is returned instead (see [Evaluation](../../../semantics/evaluation.md#3-function-call)).

## Reference

- [Stock functions](README.md#series-functions)
- [`BARS_SINCE`](BARS_SINCE.md)
