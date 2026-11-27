# LOAD_CANDLES

[**Stock**](../README.md) standard function. Returns the candles of another timeframe, closed at the current candle (see [Other timeframes](../README.md#other-timeframes)).

Since `stock-1.2`. The function can be called only in a context derived from the [Stock Context](../README.md#stock-context).

## Overloads

### Overload 1: Aligned

Signature: `LOAD_CANDLES(timeframe <Text>)`

Equivalent of `LOAD_CANDLES(timeframe, { align: true })`.

---

### Overload 2: Options

Signature: `LOAD_CANDLES(timeframe <Text>, options <Object>)`

Options:

| Option | Type | Default | Description |
| :----- | :--: | :-----: | :---------- |
| `align` | `Boolean` | `true` | `true` returns the aligned series, `false` the native series. |

Collection template:

| # | Name |   | Base type | Extended type | Any type | Multiple | Optional |
| - | :--: | - | :-------: | :-----------: | :------: | :------: | :------: |
| 1 | timeframe | | Text | - | false | false | false |
| 2 | options | | Object | - | false | false | false |

Algorithm:

1. If the function is not called in a context derived from the Stock Context, returns an `OPERATION_ERROR`.
2. If `options` has a key other than `align`, or `align` is not a **Boolean**, returns an `ARGUMENT_ERROR`.
3. If the host application does not provide `timeframe`, returns a `NOT_SUPPORTED_ERROR`.
4. If `align` is `true`, returns an array of `N` elements: the element `k` is the last `Stock.Candle` of the timeframe [closed at the candle `k`](../README.md#closed-candles) of the main chart, or `null` if there is none (also when `TIME[k]` is `null`).
5. If `align` is `false`, returns an array of the `Stock.Candle` values of the timeframe closed at the current candle, from the oldest. It is empty if none is closed yet.

The timeframe of the main chart is allowed: `LOAD_CANDLES(TIMEFRAME)` is `CANDLES`, and `LOAD_CANDLES(TIMEFRAME, { align: false })` is the candles up to the current one.

Examples (main chart `15m` from 10:00, 8 candles; timeframe `1h`):

| Formula | Current candle | Result |
| :------ | :------------: | :----- |
| `LOAD_CANDLES("1h")[I]` | `I` = `2` (ends at 10:45) | `null` |
| `LOAD_CANDLES("1h")[I]` | `I` = `3` (ends at 11:00) | the candle 10:00 - 11:00 |
| `LOAD_CANDLES("1h")[I].close` | `I` = `5` | the close of the candle 10:00 - 11:00 |
| `LEN(LOAD_CANDLES("1h", { align: false }))` | `I` = `7` (ends at 12:00) | `2` |
| `LAST(LOAD_CANDLES("1h", { align: false }))` | `I` = `7` | the candle 11:00 - 12:00 |
| `MAP(LOAD_CANDLES("1h"), (c) => IF(ISNULL(c), null, c.high))` | every candle | the aligned series of the 1-hour highs |
| `LOAD_CANDLES("1w")` | any | `[NOT_SUPPORTED_ERROR (11)] ...` |

## Performance

The candles of a timeframe do not depend on the iteration, only the part that is closed does. An implementation **may** compute the aligned series once for all the iterations, as for the [stored series of `LOAD_INDICATOR`](LOAD_INDICATOR.md#performance).

## Errors

- [`NOT_SUPPORTED_ERROR`](../../core/errors/NOT_SUPPORTED_ERROR.md) - the host application does not provide the `timeframe`.
- [`OPERATION_ERROR`](../../core/errors/OPERATION_ERROR.md) - the function is called outside of a Stock Context.
- [`ARGUMENT_ERROR`](../../core/errors/ARGUMENT_ERROR.md) - the arguments match no overload, or `options` has an unknown key or an option of a wrong type. If one of the arguments is an **Error**, that **Error** is returned instead (see [Evaluation](../../../semantics/evaluation.md#3-function-call)).

## Reference

- [Stock standard](../README.md#other-timeframes)
- [Stock functions](README.md)
- [`LOAD_INDICATOR`](LOAD_INDICATOR.md#overload-4-options)
- [`Stock.Candle`](../types/Candle.md)
