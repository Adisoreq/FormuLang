# FormuLang Stock

**FormuLang** **Stock** standard documentation.


## Basic information

**Name**: `Stock`

**Latest version**: `0.1`

**Identifier**: `stock-0.1`

**Requires**: `core-0.2+`

**Description**: Extension standard for market data: candles, technical indicators, candle patterns and trading strategies. Formulas are executed once for every candle of a chart, in an [Iteration Context](../../core/context.md#2-iteration-context).

Changes between versions: [Stock changelog](CHANGELOG.md).


## Context structure

### 1. Context types

Every Stock context type derives from the Core [Iteration Context](../../core/context.md#2-iteration-context): the host application executes the formula once for every candle, `I` is the index of the current candle and `N` is the number of candles.

| Context type | Base type | Additional constants | Expected result |
| :----------- | :-------- | :------------------- | :-------------- |
| [Stock Context](#stock-context) | Iteration Context | `CANDLES`, `OPEN`, `HIGH`, `LOW`, `CLOSE`, `VOLUME`, `TIME` | any value |
| [Indicator Context](#indicator-context) | Stock Context | `PARAMETERS`, `SOURCE` | `Null`, `Number` or `Object` |
| [Pattern Context](#pattern-context) | Stock Context | none | `Boolean` |
| [Strategy Context](#strategy-context) | Stock Context | `BUY`, `NEUTRAL`, `SELL` | `Number` from `-1` to `1` |

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

All the arrays have `N` elements, and the element at the index `I` belongs to the current candle: `CLOSE[I]` is `CANDLES[I].close`.

### Indicator Context

Used to define a technical indicator. The formula computes the value of the indicator for the current candle.

| Constant | Type | Description |
| :------- | :--: | :---------- |
| `PARAMETERS` | `Object` | Parameters of the indicator, e.g. `{ period: 14 }`. The host application completes missing parameters with the default values of the [indicator definition](#indicator-registry). |
| `SOURCE` | `Array` | Input series of the indicator (**Number** or `null` elements, `N` elements). It is `CLOSE`, unless another series is given to [`INDICATOR`](functions/INDICATOR.md). |

Expected result of every iteration:

- `null` - the indicator has no value for the current candle (e.g. `I` is lower than the period).
- **Number** - value of an indicator with one series (e.g. SMA).
- **Object** with **Number** values - values of an indicator with multiple series, one key for every series (e.g. MACD: `{ macd: 1.2, signal: 0.9, histogram: 0.3 }`).

Every iteration that does not return `null` returns the same kind of value, and an **Object** always has the same keys. Otherwise, the result of the indicator is an `OPERATION_ERROR`.

The previous value of the indicator is available as `PREV` (see [Iteration Context](../../core/context.md#2-iteration-context)), which allows recursive indicators such as EMA.

### Pattern Context

Used to find candle patterns. The formula returns `true` if the pattern starts at the current candle, and `false` otherwise. The host application collects the indices of the candles for which the formula returned `true`.

### Strategy Context

Used to define buy and sell strategies based on indicators and patterns.

| Constant | Type | Value | Description |
| :------- | :--: | :---: | :---------- |
| `BUY` | `Number` | `1` | Strongest buy signal. |
| `NEUTRAL` | `Number` | `0` | No signal. |
| `SELL` | `Number` | `-1` | Strongest sell signal. |

The formula returns a **Number** from `SELL` to `BUY` (`-1` to `1`). Values between express the strength of the signal, e.g. `0.5` is a weak buy signal. A value outside of that range is clamped by the host application.

### Context variables

All context variables are defined by user. As in every Iteration Context, they are not kept between candles.


## Environment structure

### 1. Environment constants

| Constant | Type | Initial value | Description |
| :------- | :--: | :------------ | :---------- |
| `STANDARDS` | `Array` | contains `"stock-0.1"` | The Core constant must contain the identifier of the Stock standard (and of the required Core standard). |

### 2. Indicator registry

The environment holds the **indicator registry**: the indicator definitions provided by the host application. The registry is not a **FormuLang** value; formulas use it only through the [`INDICATOR`](functions/INDICATOR.md) function.

Every indicator definition contains:

| Element | Description |
| :------ | :---------- |
| **Identifier** | Unique **Text** used to call the indicator, e.g. `"SMA"`. It follows the [identifier naming restrictions](../../syntax/naming.md#naming-restrictions). |
| **Formula** | Formula executed in an [Indicator Context](#indicator-context). |
| **Parameters** | Names of the parameters with their default values, e.g. `period` = `14`. |

How the host application stores the definitions is not specified.


## Extended types

| Type | Description |
| :--- | :---------- |
| [`Stock.Candle`](types/Candle.md) | One candle of a chart: `open`, `high`, `low`, `close`, `volume` and `time`. |


## Built-in Functions

| Function | Description | Return Type |
| :------- | :---------- | :---------: |
| [`CANDLE(object)`](functions/CANDLE.md) | Creates a `Stock.Candle` from an **Object**. | `Stock.Candle` |
| [`INDICATOR(id, parameters, source)`](functions/INDICATOR.md) | Computes an indicator from the registry for every candle. | `Array` |


## Examples

- [Indicator examples](examples/indicator_examples.md)
- [Pattern and strategy examples](examples/strategy_examples.md)


## Reference

- [Core standard](../core/README.md)
- [Context](../../core/context.md)
- [Environment](../../core/environment.md)
- [Types](../../core/types.md#extended-types)
