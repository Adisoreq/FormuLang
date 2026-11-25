# Stock functions

Functions of the [**Stock**](../README.md) standard.

| Function | Description | Return Type |
| :------- | :---------- | :---------: |
| [`CANDLE(object)`](CANDLE.md) | Creates a `Stock.Candle` from an **Object**. | `Stock.Candle` |
| [`IS_BULLISH(candle)`](IS_BULLISH.md) | Checks if the candle closed higher than it opened (`close > open`). | `Boolean` |
| [`IS_BEARISH(candle)`](IS_BEARISH.md) | Checks if the candle closed lower than it opened (`close < open`). | `Boolean` |
| [`LOAD_INDICATOR(id, parameters, source)`](LOAD_INDICATOR.md) | Computes an indicator from the formula registry for every candle. | `Array` |
| [`LOAD_PATTERN(id, parameters)`](LOAD_PATTERN.md) | Checks a pattern from the formula registry for every candle. | `Array<Boolean>` |
| [`LAG(series, offset)`](LAG.md) | Returns the value `offset` candles before the current one (`1` by default), or `null` if that candle does not exist yet. | `Any` |
| [`WINDOW(series, length, handler)`](WINDOW.md) | Returns the last `length` values up to the current candle, or the result of `handler` for them; `null` if there are not enough candles yet. | `Array` / `Any` |

## Reference

- [Stock standard](../README.md)
- [Core functions](../../core/functions/README.md)
