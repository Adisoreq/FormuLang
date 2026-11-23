# IS_BULLISH

[**Stock**](../README.md) standard function. Checks if a candle is bullish (rising): its `close` is greater than its `open`.

## Overloads

### Overload 1

Signature: `IS_BULLISH(candle <Stock.Candle>)`

Collection template:

| # | Name |   | Base type | Extended type | Any type | Multiple | Optional |
| - | :--: | - | :-------: | :-----------: | :------: | :------: | :------: |
| 1 | candle | | Object | Stock.Candle | false | false | false |

Algorithm:

- Returns `true` if `candle.close > candle.open`; otherwise returns `false`
- A candle with `close` equal to `open` (a doji) is neither bullish nor bearish: both `IS_BULLISH` and `IS_BEARISH` return `false`

Examples:

| Formula | Result |
| :------ | :----- |
| `IS_BULLISH(CANDLE({ open: 10, high: 12, low: 9, close: 11 }))` | `true` |
| `IS_BULLISH(CANDLE({ open: 11, high: 12, low: 9, close: 10 }))` | `false` |
| `IS_BULLISH(CANDLE({ open: 10, high: 12, low: 9, close: 10 }))` | `false` |
| `IS_BULLISH(CANDLES[I])` | `true` if the current candle is bullish |
| `IS_BULLISH({ open: 10, close: 11 })` | `[ARGUMENT_ERROR (6)] ...` |

## Errors

- [`ARGUMENT_ERROR`](../../core/errors/ARGUMENT_ERROR.md) - the argument is not a `Stock.Candle` (an **Object** that is not a candle matches no overload; use [`CANDLE`](CANDLE.md) to create one). If the argument is an **Error**, that **Error** is returned instead (see [Evaluation](../../../semantics/evaluation.md#3-function-call)).

## Reference

- [Stock standard](../README.md)
- [`Stock.Candle`](../types/Candle.md)
- [`IS_BEARISH`](IS_BEARISH.md)