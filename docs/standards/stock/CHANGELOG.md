# Stock changelog

Changes of the [**Stock**](README.md) standard.

## 1.0 (unreleased)

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
