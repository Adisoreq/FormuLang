# Pattern and strategy examples

Formulas executed in a [Pattern Context](../README.md#pattern-context) or a [Strategy Context](../README.md#strategy-context), once for every candle. The indicators come from the [indicator examples](indicator_examples.md).

## Example 1: Bullish engulfing pattern

**Context**: Pattern Context

**Identifier** (in the [formula registry](../README.md#2-formula-registry)): `ENGULFING`

**Parameters**: none

**Result**: `true` if the current candle is bullish and its body covers the body of the previous, bearish candle.

#### Formula:

```php
# In the first iteration, the previous candle is the current one
$prev = CANDLES[MAX(I - 1, @array_indexing)]
$curr = CANDLES[I]

$covers = AND($curr.open <= $prev.close, $curr.close >= $prev.open)

AND(I > @array_indexing, AND(IS_BEARISH($prev), AND(IS_BULLISH($curr), $covers)))
```

#### Result:

With 4 candles (`open` → `close`): `10 → 12`, `12 → 11`, `10.5 → 13`, `13 → 14`:

```js
[false, false, true, false]
```

The third candle (`10.5 → 13`) is bullish and covers the bearish second candle (`12 → 11`).

## Example 2: Moving average crossover

**Context**: Strategy Context

**Result**: `BUY` when the fast SMA crosses above the slow SMA, `SELL` when it crosses below, `NEUTRAL` otherwise.

#### Formula:

```php
$fast = LOAD_INDICATOR("SMA", { period: 10 })
$slow = LOAD_INDICATOR("SMA", { period: 40 })

$p = MAX(I - 1, @array_indexing)
$fast_prev = $fast[$p]
$slow_prev = $slow[$p]
$fast_curr = $fast[I]
$slow_curr = $slow[I]

# Both SMAs need a value for the previous and the current candle
$values = [$fast_prev, $slow_prev, $fast_curr, $slow_curr]
$ready = AND(I > @array_indexing, LEN(FILTER($values, (e) => ISNULL(e))) == 0)

IF(NOT($ready),
   NEUTRAL,
   IF(AND($fast_prev <= $slow_prev, $fast_curr > $slow_curr),
      BUY,
      IF(AND($fast_prev >= $slow_prev, $fast_curr < $slow_curr), SELL, NEUTRAL)))
```

## Example 3: Signal strength from MACD

**Context**: Strategy Context

**Result**: A **Number** from `SELL` to `BUY`: the MACD histogram scaled by the closing price and clamped.

#### Formula:

```php
$macd = LOAD_INDICATOR("MACD")[I]

IF(ISNULL($macd),
   NEUTRAL,
   CLAMP($macd.histogram / CLOSE[I] * 100, SELL, BUY))
```

## Example 4: Pattern confirmed by a trend

**Context**: Strategy Context

**Result**: `BUY` when a bullish engulfing pattern appears above the 20-candle SMA, `NEUTRAL` otherwise.

#### Formula:

```php
$engulfing = LOAD_PATTERN("ENGULFING")[I]
$sma = LOAD_INDICATOR("SMA", { period: 20 })[I]

IF(ISNULL($sma),
   NEUTRAL,
   IF(AND($engulfing, CLOSE[I] > $sma), BUY, NEUTRAL))
```

## Example 5: Moving average crossover with the series functions

**Context**: Strategy Context (since `stock-1.2`)

**Result**: The same as [Example 2](#example-2-moving-average-crossover), written with [`CROSSOVER`](../functions/CROSSOVER.md) and [`CROSSUNDER`](../functions/CROSSUNDER.md), and with the periods as parameters of the strategy.

#### Formula:

```php
<@ {
  id: "sma-cross",
  context: "Stock.Strategy",
  parameters: { fast: { type: "Number", default: 10, min: 1 }, slow: { type: "Number", default: 40, min: 1 } }
} @>
REQUIRE "stock-1.2+"

$fast = LOAD_INDICATOR("SMA", { period: PARAMETERS.fast })
$slow = LOAD_INDICATOR("SMA", { period: PARAMETERS.slow })

IF(CROSSOVER($fast, $slow), BUY, IF(CROSSUNDER($fast, $slow), SELL, NEUTRAL))
```

`CROSSOVER` and `CROSSUNDER` are `false` on the first candle and while one of the values is `null`, so the formula needs no checks of the warm-up. The host application completes `PARAMETERS` with the `default` values of the metadata.

## Example 6: MACD + EMA200 with the stop loss behind the swing

**Context**: Strategy Context (since `stock-1.2`)

**Registry**: `EMA` and `MACD` from the [indicator examples](indicator_examples.md), and an `ATR` indicator with the parameter `period`.

**Result**: A [signal object](../README.md#strategy-context): `BUY` when the price is above the EMA and the MACD line crosses its signal line upwards below zero, `SELL` in the opposite case, `NEUTRAL` otherwise. Every result has the `checks`, so the host application can show why there is or is not a signal. `stop` is a key of the host application (a stop loss behind the last swing), passed unchanged.

#### Formula:

```php
<@ {
  id: "macd-ema200",
  name: "MACD + EMA200",
  description: "MACD crossing in the direction of the EMA trend, with the stop loss behind the last swing.",
  context: "Stock.Strategy",
  parameters: {
    emaPeriod: { type: "Number", default: 200, min: 1, description: "Period of the trend EMA" },
    swingBars: { type: "Number", default: 10, min: 1, description: "Stop loss behind the low / high of N candles" },
    bufferAtr: { type: "Number", default: 0.5, min: 0, description: "Stop loss buffer in ATRs" }
  },
  stock: {
    checks: {
      aboveEma: "Price above the EMA", macdCrossUp: "MACD crosses the signal upwards", macdBelowZero: "MACD below 0",
      belowEma: "Price below the EMA", macdCrossDown: "MACD crosses the signal downwards", macdAboveZero: "MACD above 0"
    }
  }
} @>
REQUIRE "stock-1.2+"

$ema = LOAD_INDICATOR("EMA", { period: PARAMETERS.emaPeriod })
$macd = LOAD_INDICATOR("MACD", { }, { output: "macd" })
$signal = LOAD_INDICATOR("MACD", { }, { output: "signal" })
$atr = LOAD_INDICATOR("ATR", { period: 14 })[I]

$ready = READY($ema, 1) && READY($macd, 2) && READY($signal, 2) && ISNUM($atr)

$buy = {
  aboveEma: $ready && CLOSE[I] > $ema[I],
  macdCrossUp: CROSSOVER($macd, $signal),
  macdBelowZero: $ready && $macd[I] < 0
}
$sell = {
  belowEma: $ready && CLOSE[I] < $ema[I],
  macdCrossDown: CROSSUNDER($macd, $signal),
  macdAboveZero: $ready && $macd[I] > 0
}

IF(SCORE($buy) == 1,
   { signal: BUY, checks: $buy, reason: "Price above the EMA, MACD up below 0.",
     stop: LOWEST(LOW, PARAMETERS.swingBars) - PARAMETERS.bufferAtr * $atr },
   IF(SCORE($sell) == 1,
      { signal: SELL, checks: $sell, reason: "Price below the EMA, MACD down above 0.",
        stop: HIGHEST(HIGH, PARAMETERS.swingBars) + PARAMETERS.bufferAtr * $atr },
      { signal: NEUTRAL, checks: MERGE($buy, $sell) }))
```

- `output` takes one series out of the MACD objects; both `LOAD_INDICATOR("MACD", ...)` calls compute the indicator once (see [Performance](../functions/LOAD_INDICATOR.md#performance)).
- [`READY`](../functions/READY.md) checks the warm-up of the indicators. Because `&&` [stops at the first `false`](../../core/functions/AND.md#short-circuit), `$ready && CLOSE[I] > $ema[I]` is `false` while `$ema[I]` is `null`, instead of an **Error**. A variable cannot hold an **Error**, so the conditions are guarded before they are stored in `$buy` and `$sell`.
- [`SCORE`](../functions/SCORE.md)` == 1` means that all the conditions are met. `SCORE($buy) - SCORE($sell)` would be a signal with a strength instead.
- [`LOWEST`](../functions/LOWEST.md) and [`HIGHEST`](../functions/HIGHEST.md) find the swing low and high of the last `swingBars` candles.

## Example 7: Trend of another timeframe

**Context**: Strategy Context (since `stock-1.2`), main chart `15m`; the host application provides the timeframe `1h`.

**Result**: `BUY` when the RSI of the 15-minute candles crosses above 30 while the close of the last closed 1-hour candle is above its 50-period EMA.

#### Formula:

```php
REQUIRE "stock-1.2+"

$trend = LOAD_INDICATOR("EMA", { period: 50 }, { timeframe: "1h" })
$hourly = LOAD_CANDLES("1h")
$rsi = LOAD_INDICATOR("RSI", { period: 14 })

$uptrend = READY($trend, 1) && $hourly[I].close > $trend[I]

IF($uptrend && CROSSOVER($rsi, 30), BUY, NEUTRAL)
```

`$trend` and `$hourly` are [aligned](../README.md#aligned-and-native-series) with the 15-minute candles: `$trend[I]` and `$hourly[I]` belong to the last 1-hour candle that is closed at the current 15-minute candle, so a backtest never sees an hour that has not ended yet. When `$trend[I]` has a value, `$hourly[I]` is not `null`.

## Example 8: MACD + EMA200 without warm-up checks

**Context**: Strategy Context (since `stock-1.3`)

**Registry**: `EMA` and `MACD` from the [indicator examples](indicator_examples.md).

**Result**: The strategy of [example 6](#example-6-macd--ema200-with-the-stop-loss-behind-the-swing) written for `stock-1.3`: a [signal object](../README.md#signal-object) with the signal [`SIGNAL_SCORE($buy, $sell)`](../functions/SIGNAL_SCORE.md), from `-1` to `1`. `1` means that all the buy conditions are met; the host application decides from which strength it trades.

#### Formula:

```php
<@ {
  id: "macd-ema200",
  name: "MACD + EMA200",
  context: "Stock.Strategy",
  parameters: {
    emaPeriod: { type: "Number", default: 200, min: 1, description: "Period of the trend EMA" }
  },
  stock: {
    checks: {
      aboveEma: "Price above the EMA", macdCrossUp: "MACD crosses the signal upwards", macdBelowZero: "MACD below 0",
      belowEma: "Price below the EMA", macdCrossDown: "MACD crosses the signal downwards", macdAboveZero: "MACD above 0"
    }
  }
} @>
REQUIRE "stock-1.3+"

$ema = LOAD_INDICATOR("EMA", { period: PARAMETERS.emaPeriod })
$macd = LOAD_INDICATOR("MACD", { }, { output: "macd" })
$signal = LOAD_INDICATOR("MACD", { }, { output: "signal" })

$buy = {
  aboveEma: CLOSE[I] > $ema[I],
  macdCrossUp: CROSSOVER($macd, $signal),
  macdBelowZero: $macd[I] < 0
}
$sell = {
  belowEma: CLOSE[I] < $ema[I],
  macdCrossDown: CROSSUNDER($macd, $signal),
  macdAboveZero: $macd[I] > 0
}

{ signal: SIGNAL_SCORE($buy, $sell), checks: MERGE($buy, $sell) }
```

- No `READY`: while `$ema[I]` or `$macd[I]` is `null`, the comparisons are `false` (see [Missing values](../../core/README.md#missing-values)), so no condition is met and the signal is `0`.
- The sell conditions are written directly (`<`, `CROSSUNDER`), not as `!` of the buy conditions: `!(CLOSE[I] > $ema[I])` would be `true` while `$ema[I]` is `null`.
- With 2 of 3 buy conditions and no sell condition, the signal is `0.67`. A host application that trades only on all the conditions uses the threshold `1`.

## Example 9: Buy and sell conditions on other timeframes

**Context**: Strategy Context (since `stock-1.3`), main chart `15m`; the host application provides the timeframes `1h` and `4h`.

**Registry**: `EMA`, `MACD` and `RSI` from the [indicator examples](indicator_examples.md).

**Result**: A **Number** from `-1` to `1`: [`SIGNAL_SCORE`](../functions/SIGNAL_SCORE.md) of four buy and four sell conditions.

#### Formula:

```php
REQUIRE "stock-1.3+"

$ema4h = LOAD_INDICATOR("EMA", { period: 50 }, { timeframe: "4h" })
$fastEma1h = LOAD_INDICATOR("EMA", { period: 20 }, { timeframe: "1h" })
$slowEma1h = LOAD_INDICATOR("EMA", { period: 50 }, { timeframe: "1h" })
$macd = LOAD_INDICATOR("MACD", { }, { output: "macd" })
$macdSignal = LOAD_INDICATOR("MACD", { }, { output: "signal" })
$rsi = LOAD_INDICATOR("RSI", { period: 14 })

$buy = {
  aboveEma4h: CLOSE[I] > $ema4h[I],
  uptrend1h: $fastEma1h[I] > $slowEma1h[I],
  macdAboveSignal: $macd[I] > $macdSignal[I],
  rsiAbove50: $rsi[I] > 50
}

$sell = {
  belowEma4h: CLOSE[I] < $ema4h[I],
  downtrend1h: $fastEma1h[I] < $slowEma1h[I],
  macdBelowSignal: $macd[I] < $macdSignal[I],
  rsiBelow50: $rsi[I] < 50
}

SIGNAL_SCORE($buy, $sell)
```

Every pair of conditions describes one indicator, so every indicator moves the signal by `0.25`:

| Buy conditions met | Sell conditions met | Signal |
| :----------------: | :-----------------: | :----: |
| 4 | 0 | `1` |
| 3 | 1 | `0.5` |
| 1 | 3 | `-0.5` |
| 0 (warm-up) | 0 (warm-up) | `0` |

`$ema4h[I]` belongs to the last 4-hour candle that is closed at the current 15-minute candle (see [aligned series](../README.md#aligned-and-native-series)), and the timeframe of `LOAD_INDICATOR` without `timeframe` is the main chart.

To make the higher timeframes count more, `SIGNAL_SCORE` takes one Object of weights for both sides:

```php
SIGNAL_SCORE($buy, $sell, { aboveEma4h: 2, belowEma4h: 2 })
```

To show the conditions to the user, the formula returns a [signal object](../README.md#signal-object) instead: `{ signal: SIGNAL_SCORE($buy, $sell), checks: MERGE($buy, $sell) }`.

A filter that applies to both sides (e.g. "the volatility is high enough") is not a condition of `$buy` or `$sell`: it would count for both. It is applied to the result:

```php
$atr = LOAD_INDICATOR("ATR", { period: 14 })
$isVolatile = $atr[I] > WINDOW($atr, 50, AVG)

IF($isVolatile, SIGNAL_SCORE($buy, $sell), NEUTRAL)
```

`WINDOW($atr, 50, AVG)` is `null` while the window has a `null` element (see [`AVG`](../../core/functions/AVG.md)), so `$isVolatile` is `false` during the warm-up.

## Reference

- [`LOAD_PATTERN`](../functions/LOAD_PATTERN.md)
- [`IS_BULLISH`](../functions/IS_BULLISH.md), [`IS_BEARISH`](../functions/IS_BEARISH.md)
- [Stock standard](../README.md)
- [`LOAD_INDICATOR`](../functions/LOAD_INDICATOR.md)
- [Indicator examples](indicator_examples.md)
- [Series functions](../functions/README.md#series-functions)
- [Other timeframes](../README.md#other-timeframes)
- [`SIGNAL_SCORE`](../functions/SIGNAL_SCORE.md)
- [Missing values](../../core/README.md#missing-values)
