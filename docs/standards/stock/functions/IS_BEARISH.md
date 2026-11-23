# IS_BEARISH

[**Stock**](../README.md) standard function. Checks if a candle is bearish (falling): its `close` is lower than its `open`.

## Overloads

### Overload 1

Signature: `IS_BEARISH(candle <Stock.Candle>)`

Collection template:

| # | Name |   | Base type | Extended type | Any type | Multiple | Optional |
| - | :--: | - | :-------: | :-----------: | :------: | :------: | :------: |
| 1 | candle | | Object | Stock.Candle | false | false | false |

Algorithm:

- Returns `true` if `candle.close < candle.open`; otherwise returns `false`
- A candle with `close` equal to `open` (a doji) is neither bullish nor bearish: both `IS_BULLISH` and `IS_BEARISH` return `false`

Examples:

| Formula | Result |
| :------ | :----- |
| `IS_BEARISH(CANDLE({ open: 10, high: 12, low: 9, close: 11 }))` | `false` |
| `IS_BEARISH(CANDLE({ open: 11, high: 12, low: 9, close: 10 }))` | `true` |
| `IS_BEARISH(CANDLE({ open: 10, high: 12, low: 9, close: 10 }))` | `false` |
| `IS_BEARISH(CANDLES[I])` | `true` if the current candle is bearish |
| `IS_BEARISH({ open: 10, close: 11 })` | `[ARGUMENT_ERROR (6)] ...` |

## Errors

- [`ARGUMENT_ERROR`](../../core/errors/ARGUMENT_ERROR.md) - the argument is not a `Stock.Candle` (an **Object** that is not a candle matches no overload; use [`CANDLE`](CANDLE.md) to create one). If the argument is an **Error**, that **Error** is returned instead (see [Evaluation](../../../semantics/evaluation.md#3-function-call)).

## Reference

- [Stock standard](../README.md)
- [`Stock.Candle`](../types/Candle.md)
- [`IS_BULLISH`](IS_BULLISH.md)