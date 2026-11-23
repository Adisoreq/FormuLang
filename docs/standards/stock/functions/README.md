# Stock functions

Functions of the [**Stock**](../README.md) standard.

| Function | Description | Return Type |
| :------- | :---------- | :---------: |
| [`CANDLE(object)`](CANDLE.md) | Creates a `Stock.Candle` from an **Object**. | `Stock.Candle` |
| [`IS_BULLISH(candle)`](IS_BULLISH.md) | Checks if the candle closed higher than it opened (`close > open`). | `Boolean` |
| [`IS_BEARISH(candle)`](IS_BEARISH.md) | Checks if the candle closed lower than it opened (`close < open`). | `Boolean` |
| [`LOAD_INDICATOR(id, parameters, source)`](LOAD_INDICATOR.md) | Computes an indicator from the formula registry for every candle. | `Array` |
| [`LOAD_PATTERN(id, parameters)`](LOAD_PATTERN.md) | Checks a pattern from the formula registry for every candle. | `Array<Boolean>` |

## Reference

- [Stock standard](../README.md)
- [Core functions](../../core/functions/README.md)
