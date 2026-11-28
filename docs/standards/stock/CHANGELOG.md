# Stock changelog

Changes of the [**Stock**](README.md) standard.

## 1.3

Identifier: `stock-1.3`. Requires `core-1.3+`. Backward compatible with `1.2`: formulas whose result is a value in `1.2` give the same results; only formulas whose result was an **Error** in `1.2` can give a value now. `STANDARDS` contains `stock-1.0`, `stock-1.1`, `stock-1.2` and `stock-1.3`. The design is in [Proposals for the 1.3 standards](../../misc/proposals_1.3.md).

### Added
- The strategy function [`SIGNAL_SCORE(buy, sell, weights)`](functions/SIGNAL_SCORE.md): `SCORE(buy) - SCORE(sell)`, the strength of a signal from `-1` to `1`, from the buy and the sell conditions (Objects or Arrays of **Boolean** or `null`). The optional `weights` is one Object for the keys of both sides, only with Objects; a key of neither side is an `INVALID_KEY_ERROR`.
- [Formula results](README.md#formula-results): the results of indicators, patterns and strategies in one table. They are plain values, not extended types; the results of a strategy do not change.
- Examples: [a strategy without warm-up checks](examples/strategy_examples.md#example-8-macd--ema200-without-warm-up-checks) and [buy and sell conditions on other timeframes](examples/strategy_examples.md#example-9-buy-and-sell-conditions-on-other-timeframes), both with `SIGNAL_SCORE`.

### Changed
- [`SCORE`](functions/SCORE.md) accepts `null` conditions: a `null` is a condition that is not met, and it stays in the denominator (`SCORE([true, null])` is `0.5`).
- With the [missing values](../core/README.md#missing-values) of `core-1.3`, a condition such as `CLOSE[I] > $ema[I]` is `false` while `$ema[I]` is `null`: a strategy does not need `READY` to avoid an **Error** during the warm-up. `READY` does not change.
- The version is `1.3` (identifier `stock-1.3`), and it requires `core-1.3+`.

## 1.2

Identifier: `stock-1.2`. Requires `core-1.2+`. Backward compatible with `1.1`: formulas valid in `1.1` give the same results; only formulas whose result was an **Error** in `1.1` can give a value now. `STANDARDS` contains `stock-1.0`, `stock-1.1` and `stock-1.2`. The design and the motivation are in [Proposals for the 1.2 standards](../../misc/proposals.md).

### Added
- `PARAMETERS` in the [Strategy Context](README.md#strategy-context), provided by the host application and completed with the `default` values of the metadata.
- The constants `TIMEFRAME` and `INSTRUMENT` of the [Stock Context](README.md#stock-context) (**Text** or `null`, named by the host application).
- The [signal object](README.md#strategy-context): a strategy may return an **Object** `{ signal, reason?, checks?, ... }` instead of a **Number**. `checks` holds named **Boolean** conditions; other keys are passed to the host application unchanged.
- [Other timeframes](README.md#other-timeframes): the host application may provide the candles of other timeframes. Series of another timeframe are **aligned** with the main chart (`N` elements, the last candle closed at every candle) or **native** (`align: false`). A candle that is not closed at the current candle is never visible.
- [`LOAD_CANDLES(timeframe, options)`](functions/LOAD_CANDLES.md).
- The [options overload of `LOAD_INDICATOR`](functions/LOAD_INDICATOR.md#overload-4-options) (`source`, `timeframe`, `output`, `align`) and of [`LOAD_PATTERN`](functions/LOAD_PATTERN.md#overload-3-options) (`timeframe`, `align`). `output` takes the series of one key of an indicator with Object results.
- [Series functions](functions/README.md#series-functions) with common rules (a `null` or not enough candles give `false` or `null`, never an **Error**): [`READY`](functions/READY.md), [`CROSSOVER`](functions/CROSSOVER.md), [`CROSSUNDER`](functions/CROSSUNDER.md), [`HIGHEST`](functions/HIGHEST.md), [`LOWEST`](functions/LOWEST.md), [`RISING`](functions/RISING.md), [`FALLING`](functions/FALLING.md), [`BARS_SINCE`](functions/BARS_SINCE.md) and [`VALUE_WHEN`](functions/VALUE_WHEN.md).
- The strategy function [`SCORE(conditions, weights)`](functions/SCORE.md): the share of `true` values of an Object or an Array of Booleans, optionally weighted (a condition without a weight has the weight `1`; a weight of a key that is not a condition is an `INVALID_KEY_ERROR`).
- The `stock` key of the [metadata](README.md#metadata) (`category`, `outputs`, `checks`), and [registry definitions](README.md#2-formula-registry) read from the metadata of their formulas (`id`, `context`, `parameters`).
- Examples: [RSI](examples/indicator_examples.md#example-4-relative-strength-index-rsi) with the memory instead of internal keys of the result, and strategies with the [series functions](examples/strategy_examples.md#example-5-moving-average-crossover-with-the-series-functions), the [signal object](examples/strategy_examples.md#example-6-macd--ema200-with-the-stop-loss-behind-the-swing) and [another timeframe](examples/strategy_examples.md#example-7-trend-of-another-timeframe).

### Changed
- The key of the [stored series of `LOAD_INDICATOR`](functions/LOAD_INDICATOR.md#performance) includes the timeframe; `output` and `align` are not a part of it. An implementation may compute a registry definition by other means than its formula when the result is the same.
- The identifier of a [registry definition](README.md#2-formula-registry) follows the rule of the `id` of the metadata: it may contain `-` (e.g. `"macd-ema200"`), because it is always a **Text**, never an identifier token.
- The version is `1.2` (identifier `stock-1.2`), and it requires `core-1.2+` (metadata, memory, short circuit of `&&` and `||`).

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
