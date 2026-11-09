# Stock changelog

Changes of the [**Stock**](README.md) standard.

## 0.1 (2026-11-09, in progress)

Identifier: `stock-0.1`. Requires `core-0.2+`.

### Added
- Context types derived from the Core Iteration Context: **Stock Context** (`CANDLES`, `OPEN`, `HIGH`, `LOW`, `CLOSE`, `VOLUME`, `TIME`), **Indicator Context** (`PARAMETERS`, `SOURCE`), **Pattern Context** and **Strategy Context** (`BUY`, `NEUTRAL`, `SELL`).
- Indicator registry in the environment, provided by the host application.
- Extended type [`Stock.Candle`](types/Candle.md).
- Functions [`CANDLE`](functions/CANDLE.md) and [`INDICATOR`](functions/INDICATOR.md).
- [Indicator examples](examples/indicator_examples.md) (SMA, EMA, MACD) and [pattern and strategy examples](examples/strategy_examples.md).
