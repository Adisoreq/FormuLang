# BARS_SINCE

[**Stock**](../README.md) standard [series function](README.md#series-functions). Returns the number of candles since a condition was last `true`.

Since `stock-1.2`. A condition is a series of **Boolean** values, e.g. the result of [`LOAD_PATTERN`](LOAD_PATTERN.md), or a series built with `MAP`.

## Overloads

### Overload 1

Signature: `BARS_SINCE(condition <Array>)`

Collection template:

| # | Name |   | Base type | Extended type | Any type | Multiple | Optional |
| - | :--: | - | :-------: | :-----------: | :------: | :------: | :------: |
| 1 | condition | | Array | - | false | false | false |

Algorithm:

1. Checks the [common rules](README.md#series-functions): a Stock Context, and `N` elements of `condition`.
2. Goes through the elements of `condition` from the position of the current candle back to the first element:
   - if an element is `true`, returns the number of candles between it and the current candle (`0` if it is the current candle);
   - if an element is neither a **Boolean** nor `null`, returns an `OPERATION_ERROR`;
   - `false` and `null` are skipped.
3. If no element is `true`, returns `null`.

The elements after the current candle are never read.

Examples (`$c` = `[false, true, false, false, true, false]`):

| Formula | Current candle | Result |
| :------ | :------------: | :----- |
| `BARS_SINCE($c)` | the fourth one | `2` |
| `BARS_SINCE($c)` | the fifth one | `0` |
| `BARS_SINCE($c)` | the sixth one | `1` |
| `BARS_SINCE($c)` | the first one | `null` |
| `BARS_SINCE(LOAD_PATTERN("ENGULFING")) <= 3` | any | `true` if an engulfing pattern was found in the last 4 candles |

## Errors

- [`OPERATION_ERROR`](../../core/errors/OPERATION_ERROR.md) - the function is called outside of a Stock Context, `condition` does not have `N` elements, or a needed element is neither a **Boolean** nor `null`.
- [`ARGUMENT_ERROR`](../../core/errors/ARGUMENT_ERROR.md) - the arguments match no overload. If the argument is an **Error**, that **Error** is returned instead (see [Evaluation](../../../semantics/evaluation.md#3-function-call)).

## Reference

- [Stock functions](README.md#series-functions)
- [`VALUE_WHEN`](VALUE_WHEN.md)
