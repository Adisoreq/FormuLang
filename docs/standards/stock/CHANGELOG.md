# Stock changelog

Changes of the [**Stock**](README.md) standard.

## 1.1

Identifier: `stock-1.1`. Requires `core-1+`. Backward compatible with `1.0`: formulas valid in `1.0` give the same results. `STANDARDS` contains `stock-1.0` and `stock-1.1`.

### Added
- [`LAG(series, offset)`](functions/LAG.md): the value `offset` candles before the current candle (`1` by default), or `null` if that candle does not exist yet. A negative offset (a future value) is an `OPERATION_ERROR`.
- [`WINDOW(series, length)`](functions/WINDOW.md): the last `length` values up to the current candle, or `null` if there are fewer; with a handler, `WINDOW(series, length, handler)` returns the result of the handler for these values, e.g. `WINDOW(SOURCE, 20, AVG)`.

## 1.0

Identifier: `stock-1.0`. Requires `core-1+`. First stable release. It contains the work of version `0.1`, which was never released on its own.

### Added
- Context types derived from the Core Iteration Context: **Stock Context** (`CANDLES`, `OPEN`, `HIGH`, `LOW`, `CLOSE`, `VOLUME`, `TIME`), **Indicator Context** (`PARAMETERS`, `SOURCE`), **Pattern Context** (`PARAMETERS`) and **Strategy Context** (`BUY`, `NEUTRAL`, `SELL`).
- [Formula registry](README.md#2-formula-registry) in the environment, provided by the host application, with two parts: indicators and patterns. Every definition has an identifier, a formula and parameters with default values.
- Extended type [`Stock.Candle`](types/Candle.md).
- Functions [`CANDLE`](functions/CANDLE.md), [`IS_BULLISH`](functions/IS_BULLISH.md) and [`IS_BEARISH`](functions/IS_BEARISH.md) (a doji is neither), [`LOAD_INDICATOR`](functions/LOAD_INDICATOR.md) and [`LOAD_PATTERN`](functions/LOAD_PATTERN.md) (returns `Array<Boolean>`).
- [Indicator examples](examples/indicator_examples.md) (SMA, EMA, MACD) and [pattern and strategy examples](examples/strategy_examples.md) (engulfing pattern, moving average crossover, MACD signal strength, pattern confirmed by a trend).
- [Conformance tests](../../../tests/stock/stock.json).

### Changed
- The function `INDICATOR` of the `0.1` drafts is named `LOAD_INDICATOR`.
