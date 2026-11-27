# FormuLang Stock

**FormuLang** **Stock** standard documentation.


## Basic information

**Name**: `Stock`

**Latest version**: `1.2`

**Identifier**: `stock-1.2`

**Requires**: `core-1.2+`

**Description**: Extension standard for market data: candles, technical indicators, candle patterns and trading strategies. Formulas are executed once for every candle of a chart, in an [Iteration Context](../../core/context.md#2-iteration-context).

Changes between versions: [Stock changelog](CHANGELOG.md).


## Context structure

### 1. Context types

Every Stock context type derives from the Core [Iteration Context](../../core/context.md#2-iteration-context): the host application executes the formula once for every candle, `I` is the index of the current candle and `N` is the number of candles.

| Context type | Base type | Additional constants | Expected result |
| :----------- | :-------- | :------------------- | :-------------- |
| [Stock Context](#stock-context) | Iteration Context | `CANDLES`, `OPEN`, `HIGH`, `LOW`, `CLOSE`, `VOLUME`, `TIME`, `TIMEFRAME`, `INSTRUMENT` | any value |
| [Indicator Context](#indicator-context) | Stock Context | `PARAMETERS`, `SOURCE` | `Null`, `Number` or `Object` |
| [Pattern Context](#pattern-context) | Stock Context | `PARAMETERS` | `Boolean` |
| [Strategy Context](#strategy-context) | Stock Context | `BUY`, `NEUTRAL`, `SELL`, `PARAMETERS` | `Number` from `-1` to `1`, or an `Object` with a `signal` |

The names of the context types in the `context` key of the [metadata](#metadata) are `"Stock"`, `"Stock.Indicator"`, `"Stock.Pattern"` and `"Stock.Strategy"`.

### Stock Context

General context for market data formulas.

| Constant | Type | Description |
| :------- | :--: | :---------- |
| `CANDLES` | `Array<Stock.Candle>` | Candles provided by the host application, from the oldest to the newest. `N` is its length. |
| `OPEN` | `Array<Number>` | `open` values of `CANDLES`. |
| `HIGH` | `Array<Number>` | `high` values of `CANDLES`. |
| `LOW` | `Array<Number>` | `low` values of `CANDLES`. |
| `CLOSE` | `Array<Number>` | `close` values of `CANDLES`. |
| `VOLUME` | `Array` | `volume` values of `CANDLES` (**Number** or `null`). |
| `TIME` | `Array` | `time` values of `CANDLES` (**Number** or `null`): Unix time in milliseconds, UTC. |
| `TIMEFRAME` | `Text` or `Null` | Timeframe of `CANDLES`, named by the host application (e.g. `"15m"`, `"1h"`), or `null` if the host application does not give it. The names are the same as in [other timeframes](#other-timeframes). Since `stock-1.2`. |
| `INSTRUMENT` | `Text` or `Null` | Instrument of `CANDLES`, named by the host application (e.g. `"EURUSD"`, or an epic of a broker), or `null` if the host application does not give it. Since `stock-1.2`. |

All the arrays have `N` elements, and the element at the index `I` belongs to the current candle: `CLOSE[I]` is `CANDLES[I].close`.

The candles of the context are the **main chart**: the formula is executed once for every one of them. Candles of [other timeframes](#other-timeframes) are additional data, loaded with [`LOAD_CANDLES`](functions/LOAD_CANDLES.md) and the `timeframe` option of [`LOAD_INDICATOR`](functions/LOAD_INDICATOR.md).

### Indicator Context

Used to define a technical indicator. The formula computes the value of the indicator for the current candle.

| Constant | Type | Description |
| :------- | :--: | :---------- |
| `PARAMETERS` | `Object` | Parameters of the indicator, e.g. `{ period: 14 }`. Missing parameters are completed with the default values of the [indicator definition](#2-formula-registry). |
| `SOURCE` | `Array` | Input series of the indicator (**Number** or `null` elements, `N` elements). It is `CLOSE`, unless another series is given to [`LOAD_INDICATOR`](functions/LOAD_INDICATOR.md). |

Expected result of every iteration:

- `null` - the indicator has no value for the current candle (e.g. `I` is lower than the period).
- **Number** - value of an indicator with one series (e.g. SMA).
- **Object** with **Number** values - values of an indicator with multiple series, one key for every series (e.g. MACD: `{ macd: 1.2, signal: 0.9, histogram: 0.3 }`).

Every iteration that does not return `null` returns the same kind of value, and an **Object** always has the same keys. Otherwise, the result of the indicator is an `OPERATION_ERROR`.

The previous value of the indicator is available as `PREV` (see [Iteration Context](../../core/context.md#2-iteration-context)), which allows recursive indicators such as EMA. A state that is not a part of the result (e.g. the average gain and loss of Wilder's RSI) is kept in the [memory](../../core/context.md#memory) of the context, with `STORE` and `RECALL`, so the result contains only the outputs of the indicator.

### Pattern Context

Used to find candle patterns. The formula returns `true` if the pattern is found at the current candle, and `false` otherwise. The host application collects the indices of the candles for which the formula returned `true`.

| Constant | Type | Description |
| :------- | :--: | :---------- |
| `PARAMETERS` | `Object` | Parameters of the pattern, e.g. `{ min_body: 0.5 }`. Missing parameters are completed with the default values of the [pattern definition](#2-formula-registry). A pattern without parameters receives `{ }`. |

Every iteration returns a **Boolean**. Otherwise, the result of the pattern is an `OPERATION_ERROR`. Patterns can be used in other formulas with [`LOAD_PATTERN`](functions/LOAD_PATTERN.md).

### Strategy Context

Used to define buy and sell strategies based on indicators and patterns.

| Constant | Type | Value | Description |
| :------- | :--: | :---: | :---------- |
| `BUY` | `Number` | `1` | Strongest buy signal. |
| `NEUTRAL` | `Number` | `0` | No signal. |
| `SELL` | `Number` | `-1` | Strongest sell signal. |
| `PARAMETERS` | `Object` | `{ }` by default | Parameters of the strategy, provided by the host application. Since `stock-1.2`. |

A strategy is not loaded from the formula registry, so the host application provides the whole `PARAMETERS` object. If the formula has [metadata](#metadata) with `parameters`, the host application completes the object with their `default` values.

The result of every iteration is:

- a **Number** from `SELL` to `BUY` (`-1` to `1`). Values between express the strength of the signal, e.g. `0.5` is a weak buy signal. A value outside of that range is clamped by the host application.
- or, since `stock-1.2`, an **Object** (the **signal object**) with these keys:

| Key | Type | Required | Description |
| :-- | :--: | :------: | :---------- |
| `signal` | `Number` | yes | The signal, like the Number result: from `SELL` to `BUY`, clamped by the host application. |
| `reason` | `Text` | no | An explanation of the signal for the user. |
| `checks` | `Object` | no | Named conditions that led to the signal. Every value is a **Boolean**, e.g. `{ aboveEma: CLOSE[I] > $ema[I], rsiLow: $rsi < 30 }`. The host application can show them, e.g. to explain why there is or is not a signal. Their labels for the user can be given in the [metadata](#metadata). |
| any other | any | no | Passed to the host application unchanged, e.g. `stop` or `target`. The standard does not define them. |

The signal object is a plain **Object**, not an extended type. An Object without `signal`, with a `signal` that is not a **Number**, with a `reason` that is not a **Text**, or with `checks` that is not an Object of **Boolean** values, is an `OPERATION_ERROR` of the iteration.

`checks` replaces functions with side effects that record the conditions of a strategy: the conditions are a part of the result, so the formula stays pure and keeps the [optimization of `IF`](../core/functions/IF.md#performance). [`SCORE`](functions/SCORE.md) computes the share of the met conditions, which can be the strength of the signal:

```php
$buy = { aboveEma: CLOSE[I] > $ema[I], macdUp: CROSSOVER($macd, $signal) }
{ signal: SCORE($buy), checks: $buy }
```

### Context variables

All context variables are defined by user. As in every Iteration Context, they are not kept between candles.


## Other timeframes

Since `stock-1.2`, a formula can use the candles of other timeframes than the main chart, e.g. a 15-minute strategy filtered by the trend of 1-hour candles.

### Data

- The host application may provide the candles of other timeframes to a Stock Context. A timeframe is identified by a **Text** chosen by the host application, like `TIMEFRAME`.
- The host application gives the **length** of the main timeframe and of every other timeframe (in milliseconds). Libraries ask the host application for the candles of a timeframe the first time a formula uses it, so the host application does not have to load every timeframe in advance.
- The candles of another timeframe are ordered from the oldest, and contain only candles that are closed at the end of the last candle of the main chart: the host application does not provide a candle that is still open.
- A timeframe that the host application does not provide is a `NOT_SUPPORTED_ERROR`.

### Closed candles

A candle of another timeframe with the time `t` (its opening time) and the length `L` is **closed at the candle `k`** of the main chart if `t + L` is not later than `TIME[k] + L₀`, where `L₀` is the length of the main timeframe: the candle of the other timeframe ended before, or together with, the candle `k`.

A formula never sees a candle that is not closed at the current candle, so a backtest cannot use the future.

### Aligned and native series

The functions of other timeframes return one of two kinds of series:

- An **aligned** series (the default) has `N` elements, like a series of the main chart. Its element `k` belongs to the **last candle of the other timeframe that is closed at the candle `k`**, or is `null` if there is none yet. Many elements of the main chart have the same candle of the other timeframe. An aligned series can be indexed with `I`, used with the [series functions](#3-series-functions), and given as the `source` of `LOAD_INDICATOR`.
- A **native** series (option `align: false`) has one element for every candle of the other timeframe that is closed at the current candle, from the oldest. Its length grows from one iteration to the next, and its indices are its own: the last element is the last closed candle. It is used for the candles of the other timeframe themselves, e.g. the previous 1-hour candle, or a pattern on 1-hour candles.

Main chart `15m`, other timeframe `1h`:

| `I` | `CANDLES[I]` (15m) ends at | `LOAD_CANDLES("1h")[I]` (aligned) | `LOAD_CANDLES("1h", { align: false })` (native) |
| :-: | :------------------------: | :-------------------------------- | :---------------------------------------------- |
| 0 | 10:15 | `null` | `[ ]` |
| 1 | 10:30 | `null` | `[ ]` |
| 2 | 10:45 | `null` | `[ ]` |
| 3 | 11:00 | the candle 10:00 - 11:00 | `[` 10:00 - 11:00 `]` |
| 4 | 11:15 | the candle 10:00 - 11:00 | `[` 10:00 - 11:00 `]` |
| 7 | 12:00 | the candle 11:00 - 12:00 | `[` 10:00 - 11:00, 11:00 - 12:00 `]` |

A timeframe shorter than the main one is allowed: the aligned element is the last shorter candle closed at the candle `k`.


## Environment structure

### 1. Environment constants

| Constant | Type | Initial value | Description |
| :------- | :--: | :------------ | :---------- |
| `STANDARDS` | `Array` | contains `"stock-1.0"`, `"stock-1.1"` and `"stock-1.2"` | The Core constant must contain the identifiers of the supported Stock standard versions (and of the required Core standard). |

### 2. Formula registry

The environment holds the **formula registry**: the definitions of indicators and patterns provided by the host application. The registry is not a **FormuLang** value; formulas use it only through the [`LOAD_INDICATOR`](functions/LOAD_INDICATOR.md) and [`LOAD_PATTERN`](functions/LOAD_PATTERN.md) functions.

The registry has two parts:

| Part | Formula executed in | Loaded with |
| :--- | :------------------ | :---------- |
| **Indicators** | [Indicator Context](#indicator-context) | [`LOAD_INDICATOR`](functions/LOAD_INDICATOR.md) |
| **Patterns** | [Pattern Context](#pattern-context) | [`LOAD_PATTERN`](functions/LOAD_PATTERN.md) |

Every definition contains:

| Element | Description |
| :------ | :---------- |
| **Identifier** | **Text** used to load the definition, e.g. `"SMA"`, `"ENGULFING"` or `"macd-ema200"`: letters, digits, `_` and `-`, starting with a letter or `_`, like the `id` of the [metadata](../core/README.md#metadata). It is always written as a **Text** literal (`LOAD_INDICATOR("macd-ema200")`), never as an identifier token, so it may contain `-`. It is unique within its part of the registry (an indicator and a pattern may have the same identifier). |
| **Formula** | Formula executed in the context of its part. |
| **Parameters** | Names of the parameters with their default values, e.g. `period` = `14`. May be empty. |

How the host application stores the definitions is not specified. Since `stock-1.2`, a definition **may** be read from the [metadata](#metadata) of its formula:

| Element | Metadata |
| :------ | :------- |
| Identifier | `id` |
| Part of the registry | `context`: `"Stock.Indicator"` or `"Stock.Pattern"` |
| Parameters | the keys of `parameters`, with their `default` values (`null` if there is no `default`) |

A host application that reads definitions from the metadata uses the same identifier and parameters for `LOAD_INDICATOR` and `LOAD_PATTERN` as if they were given separately.


## Metadata

Since `stock-1.2`, the **Stock** standard owns the `stock` key of the [metadata](../../core/metadata.md) (an **Object**). All its keys are optional.

| Key | Type | Description |
| :-- | :--: | :---------- |
| `category` | `Text` | A free group for the user, e.g. `"Trend"`, `"Momentum"`, `"Volatility"`. The part of the registry follows from `context`, not from the category. |
| `outputs` | `Object` | For an indicator: a key for every output (a key of the result Object, or `value` for a Number result), with an **Object** `{ name, description }` (both **Text**, optional). The outputs are the series that a chart shows. |
| `checks` | `Object` | For a strategy: a key for every key of `checks`, with its label for the user (**Text**). |

```php
<@ {
  id: "MACD",
  context: "Stock.Indicator",
  parameters: { fast: { type: "Number", default: 12 }, slow: { type: "Number", default: 26 }, signal: { type: "Number", default: 9 } },
  stock: {
    category: "Momentum",
    outputs: { macd: { name: "MACD" }, signal: { name: "Signal" }, histogram: { name: "Histogram" } }
  }
} @>
```


## Extended types

| Type | Description |
| :--- | :---------- |
| [`Stock.Candle`](types/Candle.md) | One candle of a chart: `open`, `high`, `low`, `close`, `volume` and `time`. |


## Built-in Functions

### 1. Candle functions

| Function | Description | Return Type |
| :------- | :---------- | :---------: |
| [`CANDLE(object)`](functions/CANDLE.md) | Creates a `Stock.Candle` from an **Object**. | `Stock.Candle` |
| [`IS_BULLISH(candle)`](functions/IS_BULLISH.md) | Checks if the candle closed higher than it opened (`close > open`). | `Boolean` |
| [`IS_BEARISH(candle)`](functions/IS_BEARISH.md) | Checks if the candle closed lower than it opened (`close < open`). | `Boolean` |

### 2. Registry and timeframe functions

| Function | Description | Return Type |
| :------- | :---------- | :---------: |
| [`LOAD_INDICATOR(id, parameters, source)`](functions/LOAD_INDICATOR.md) | Computes an indicator from the registry for every candle. Since `stock-1.2`, the third argument can be an **Object** of options: `source`, `timeframe`, `output`, `align`. | `Array` |
| [`LOAD_PATTERN(id, parameters, options)`](functions/LOAD_PATTERN.md) | Checks a pattern from the registry for every candle. The options (`timeframe`, `align`) since `stock-1.2`. | `Array<Boolean>` |
| [`LOAD_CANDLES(timeframe, options)`](functions/LOAD_CANDLES.md) | Returns the candles of another timeframe, aligned with the main chart or native. Since `stock-1.2`. | `Array` |

### 3. Series functions

| Function | Description | Return Type |
| :------- | :---------- | :---------: |
| [`LAG(series, offset)`](functions/LAG.md) | Returns the value `offset` candles before the current one (`1` by default), or `null` if that candle does not exist yet. | `Any` |
| [`WINDOW(series, length, handler)`](functions/WINDOW.md) | Returns the last `length` values up to the current candle, or the result of `handler` for them; `null` if there are not enough candles yet. | `Array` / `Any` |
| [`READY(series, n)`](functions/READY.md) | Checks if the last `n` values up to the current candle exist and are not `null`. Since `stock-1.2`. | `Boolean` |
| [`CROSSOVER(a, b)`](functions/CROSSOVER.md) | Checks if `a` crosses above `b` at the current candle. Since `stock-1.2`. | `Boolean` |
| [`CROSSUNDER(a, b)`](functions/CROSSUNDER.md) | Checks if `a` crosses below `b` at the current candle. Since `stock-1.2`. | `Boolean` |
| [`HIGHEST(series, length, offset)`](functions/HIGHEST.md) | Returns the highest of the last `length` values. Since `stock-1.2`. | `Number` / `Null` |
| [`LOWEST(series, length, offset)`](functions/LOWEST.md) | Returns the lowest of the last `length` values. Since `stock-1.2`. | `Number` / `Null` |
| [`RISING(series, length)`](functions/RISING.md) | Checks if each of the last `length` values is greater than the one before it. Since `stock-1.2`. | `Boolean` |
| [`FALLING(series, length)`](functions/FALLING.md) | Checks if each of the last `length` values is lower than the one before it. Since `stock-1.2`. | `Boolean` |
| [`BARS_SINCE(condition)`](functions/BARS_SINCE.md) | Returns the number of candles since the condition was last `true`. Since `stock-1.2`. | `Number` / `Null` |
| [`VALUE_WHEN(condition, series, occurrence)`](functions/VALUE_WHEN.md) | Returns the value of the series at the last (or an earlier) candle where the condition was `true`. Since `stock-1.2`. | `Any` |

Common rules of the series functions (see [Stock functions](functions/README.md#series-functions)):

- They can be called only in a context derived from the Stock Context; otherwise they return an `OPERATION_ERROR`.
- A series is an **Array** of `N` elements, like `CLOSE` or the result of `LOAD_INDICATOR`; another length is an `OPERATION_ERROR`.
- They work at the current candle: the positions are counted from the element `series[I]`, and do not depend on `@array_indexing`.
- Missing data (a `null` in a value they need, or not enough candles yet) is not an error: the result is `false` or `null`.

### 4. Strategy functions

| Function | Description | Return Type |
| :------- | :---------- | :---------: |
| [`SCORE(conditions, weights)`](functions/SCORE.md) | Returns the share of `true` values of an Object of Booleans (e.g. `checks`) or of an `Array<Boolean>`, from `0` to `1`, optionally weighted (`weights`: the weight of every condition, `1` by default). Since `stock-1.2`. | `Number` |


## Examples

- [Indicator examples](examples/indicator_examples.md)
- [Pattern and strategy examples](examples/strategy_examples.md)


## Reference

- [Core standard](../core/README.md)
- [Context](../../core/context.md)
- [Environment](../../core/environment.md)
- [Metadata](../../core/metadata.md)
- [Types](../../core/types.md#extended-types)
