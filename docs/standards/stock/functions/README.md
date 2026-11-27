# Stock functions

Functions of the [**Stock**](../README.md) standard.

## Candle functions

| Function | Description | Return Type |
| :------- | :---------- | :---------: |
| [`CANDLE(object)`](CANDLE.md) | Creates a `Stock.Candle` from an **Object**. | `Stock.Candle` |
| [`IS_BULLISH(candle)`](IS_BULLISH.md) | Checks if the candle closed higher than it opened (`close > open`). | `Boolean` |
| [`IS_BEARISH(candle)`](IS_BEARISH.md) | Checks if the candle closed lower than it opened (`close < open`). | `Boolean` |

## Registry and timeframe functions

| Function | Description | Return Type |
| :------- | :---------- | :---------: |
| [`LOAD_INDICATOR(id, parameters, source)`](LOAD_INDICATOR.md) | Computes an indicator from the formula registry for every candle. Since `stock-1.2`, the third argument can be an **Object** of options (`source`, `timeframe`, `output`, `align`). | `Array` |
| [`LOAD_PATTERN(id, parameters, options)`](LOAD_PATTERN.md) | Checks a pattern from the formula registry for every candle. The options (`timeframe`, `align`) since `stock-1.2`. | `Array<Boolean>` |
| [`LOAD_CANDLES(timeframe, options)`](LOAD_CANDLES.md) | Returns the candles of another timeframe closed at the current candle, aligned with the main chart or native. Since `stock-1.2`. | `Array` |

## Series functions

| Function | Description | Return Type |
| :------- | :---------- | :---------: |
| [`LAG(series, offset)`](LAG.md) | Returns the value `offset` candles before the current one (`1` by default), or `null` if that candle does not exist yet. | `Any` |
| [`WINDOW(series, length, handler)`](WINDOW.md) | Returns the last `length` values up to the current candle, or the result of `handler` for them; `null` if there are not enough candles yet. | `Array` / `Any` |
| [`READY(series, n)`](READY.md) | Checks if the last `n` values up to the current candle exist and are not `null`. Since `stock-1.2`. | `Boolean` |
| [`CROSSOVER(a, b)`](CROSSOVER.md) | Checks if `a` crosses above `b` (a series or a number) at the current candle. Since `stock-1.2`. | `Boolean` |
| [`CROSSUNDER(a, b)`](CROSSUNDER.md) | Checks if `a` crosses below `b` (a series or a number) at the current candle. Since `stock-1.2`. | `Boolean` |
| [`HIGHEST(series, length, offset)`](HIGHEST.md) | Returns the highest of the last `length` values, ending `offset` candles back (`0` by default); `null` values are skipped. Since `stock-1.2`. | `Number` / `Null` |
| [`LOWEST(series, length, offset)`](LOWEST.md) | Returns the lowest of the last `length` values, ending `offset` candles back (`0` by default). Since `stock-1.2`. | `Number` / `Null` |
| [`RISING(series, length)`](RISING.md) | Checks if each of the last `length` values is greater than the one before it. Since `stock-1.2`. | `Boolean` |
| [`FALLING(series, length)`](FALLING.md) | Checks if each of the last `length` values is lower than the one before it. Since `stock-1.2`. | `Boolean` |
| [`BARS_SINCE(condition)`](BARS_SINCE.md) | Returns the number of candles since the condition was last `true`, or `null`. Since `stock-1.2`. | `Number` / `Null` |
| [`VALUE_WHEN(condition, series, occurrence)`](VALUE_WHEN.md) | Returns the value of the series at the last candle (or the `occurrence`-th earlier one) where the condition was `true`, or `null`. Since `stock-1.2`. | `Any` |

Common rules of the series functions:

1. **Context.** They can be called only in a context derived from the [Stock Context](../README.md#stock-context). Otherwise, they return an `OPERATION_ERROR`.
2. **Series.** A series is an **Array** of `N` elements, one for every candle of the main chart: `CLOSE`, the result of `LOAD_INDICATOR` or `LOAD_PATTERN`, an aligned series of [another timeframe](../README.md#aligned-and-native-series), or a series built with `MAP`. An **Array** of another length is an `OPERATION_ERROR`.
3. **Current candle.** They work at the current candle: the **position of the current candle** is the position of the element `series[I]`, and the positions of the other elements are counted from it (the previous candle, the last `length` candles). The positions do not depend on `@array_indexing`. The elements after the current candle are never read, so a series function cannot use the future.
4. **Missing data.** A `null` in a value that a function needs, or not enough candles before the current one, is not an error: the result is `false` (for a **Boolean** result) or `null`. Only wrong arguments (a wrong length, a `length` out of range, an element of a wrong type) are errors.
5. **Lengths.** A `length` or `n` is a whole number not less than `1`, an `offset` or `occurrence` is a whole number not less than `0`. Another value is an `OPERATION_ERROR`.

## Strategy functions

| Function | Description | Return Type |
| :------- | :---------- | :---------: |
| [`SCORE(conditions, weights)`](SCORE.md) | Returns the share of `true` values of an Object of Booleans (e.g. the `checks` of a strategy) or of an `Array<Boolean>`, from `0` to `1`, optionally weighted (`weights`: the weight of every condition, `1` by default). Since `stock-1.2`. | `Number` |

## Reference

- [Stock standard](../README.md)
- [Core functions](../../core/functions/README.md)
