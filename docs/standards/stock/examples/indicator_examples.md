# Indicator examples

Indicator definitions for the [indicator registry](../README.md#2-formula-registry). Every formula is executed in an [Indicator Context](../README.md#indicator-context), once for every candle.

The examples assume `@array_indexing` = `0` in the environment, but they work with any value, because they use `I` and `@array_indexing` instead of fixed indices.

> [!NOTE]
> [`IF`](../../core/functions/IF.md) computes both branches, but discards the branch that is not selected, even if it is an **Error**. The examples use it to skip calculations on `null` values. Expressions that may result in an **Error** are never stored in a variable, because a variable cannot hold an **Error** (see [`SET`](../../core/procedures/SET.md)).

## Example 1: Simple Moving Average (SMA)

**Identifier**: `SMA`

**Parameters**: `period` = `14`

**Result**: **Number**, or `null` until `period` values of `SOURCE` are available.

#### Formula:

```php
$period = PARAMETERS.period

# The last `period` values of the source, fewer at the beginning of the chart
$window = RANGE(SOURCE, MAX(I - $period + 1, @array_indexing), I)
$complete = AND(LEN($window) == $period, LEN(FILTER($window, (e) => ISNULL(e))) == 0)

IF($complete, AVG($window), null)
```

#### Result:

`LOAD_INDICATOR("SMA", { period: 3 })` with `CLOSE` = `[1, 2, 3, 4, 5]`:

```js
[null, null, 2, 3, 4]
```

## Example 2: Exponential Moving Average (EMA)

**Identifier**: `EMA`

**Parameters**: `period` = `14`

**Result**: **Number**, or `null` until `period` values of `SOURCE` are available.

The first value is the SMA of the first `period` values. Every next value uses the previous one, available as `PREV`.

#### Formula:

```php
$period = PARAMETERS.period
$alpha = 2 / ($period + 1)
$x = SOURCE[I]

$window = RANGE(SOURCE, MAX(I - $period + 1, @array_indexing), I)
$complete = AND(LEN($window) == $period, LEN(FILTER($window, (e) => ISNULL(e))) == 0)

IF(ISNULL($x),
   null,
   IF(NOT(ISNULL(PREV)),
      $alpha * $x + (1 - $alpha) * PREV,
      IF($complete, AVG($window), null)))
```

#### Result:

`LOAD_INDICATOR("EMA", { period: 3 })` with `CLOSE` = `[1, 2, 3, 4, 5]` (`$alpha` = `0.5`):

```js
[null, null, 2, 3, 4]
```

| `I` | `SOURCE[I]` | `PREV` | Result |
| :-: | :---------: | :----: | :----- |
| 0 | 1 | `null` | `null` (window `[1]` is not complete) |
| 1 | 2 | `null` | `null` (window `[1, 2]` is not complete) |
| 2 | 3 | `null` | `2` (SMA of `[1, 2, 3]`) |
| 3 | 4 | `2` | `0.5 * 4 + 0.5 * 2` = `3` |
| 4 | 5 | `3` | `0.5 * 5 + 0.5 * 3` = `4` |

## Example 3: MACD

MACD has three series. Its signal line is the EMA of the whole MACD line, so the formula builds the MACD line for every candle with [`MAP`](../../core/functions/MAP.md) and passes it to `EMA` as the `source`.

**Identifier**: `MACD`

**Parameters**: `short_period` = `12`, `long_period` = `26`, `signal_period` = `9`

**Result**: **Object** `{ macd, signal, histogram }`, or `null` until the signal line has a value.

#### Formula:

```php
$short = LOAD_INDICATOR("EMA", { period: PARAMETERS.short_period }, SOURCE)
$long = LOAD_INDICATOR("EMA", { period: PARAMETERS.long_period }, SOURCE)

# MACD line for every candle: the two series joined element by element
$line = MAP($short, (s, i) => IF(OR(ISNULL(s), ISNULL($long[i])), null, s - $long[i]))

$macd = $line[I]
$signal = LOAD_INDICATOR("EMA", { period: PARAMETERS.signal_period }, $line)[I]

IF(OR(ISNULL($macd), ISNULL($signal)),
   null,
   { macd: $macd, signal: $signal, histogram: $macd - $signal })
```

#### Usage:

```php
$macd = LOAD_INDICATOR("MACD")[I]   # default parameters: 12, 26, 9
IF(ISNULL($macd), null, $macd.histogram)
```

The `EMA` of `$line` skips the `null` values at the beginning of the MACD line: its window is complete only when it contains `signal_period` values that are not `null`.

## Example 4: Relative Strength Index (RSI)

Wilder's RSI keeps two averages between the candles: the average gain and the average loss. They are not outputs of the indicator, so they are kept in the [memory](../../../core/context.md#memory) of the context (since `stock-1.2`), and the result is only the value of the RSI. The formula starts with its [metadata](../../../core/metadata.md), from which the host application can read the [registry definition](../README.md#2-formula-registry).

**Identifier**: `RSI`

**Parameters**: `period` = `14`

**Result**: **Number** from `0` to `100`, or `null` until `period` changes of `SOURCE` are available.

#### Formula:

```php
<@ {
  id: "RSI",
  name: "Relative Strength Index",
  context: "Stock.Indicator",
  result: ["Number", "Null"],
  parameters: { period: { type: "Number", default: 14, min: 1, description: "Number of changes in the averages" } },
  stock: { category: "Momentum", outputs: { value: { name: "RSI" } } }
} @>
REQUIRE "stock-1.2+"

$p = PARAMETERS.period
$n = I - @array_indexing              # number of changes up to the current candle
$change = IF($n == 0, 0, SOURCE[I] - SOURCE[I - 1])
$gain = MAX($change, 0)
$loss = MAX(-$change, 0)

# Warm-up: the sums of the first `period` changes
$sumGain = RECALL("sumGain", 0) + $gain
$sumLoss = RECALL("sumLoss", 0) + $loss
STORE("sumGain", $sumGain)
STORE("sumLoss", $sumLoss)

# Wilder's averages: the mean of the first `period` changes, then a smoothing of the previous average
$avgGain = IF($n < $p, null, IF($n == $p, $sumGain / $p, (RECALL("avgGain") * ($p - 1) + $gain) / $p))
$avgLoss = IF($n < $p, null, IF($n == $p, $sumLoss / $p, (RECALL("avgLoss") * ($p - 1) + $loss) / $p))
STORE("avgGain", $avgGain)
STORE("avgLoss", $avgLoss)

IF(ISNULL($avgGain), null, IF($avgLoss == 0, 100, 100 - 100 / (1 + $avgGain / $avgLoss)))
```

`RECALL` gives the values stored in the previous iteration, so `RECALL("avgGain")` is the previous average gain. The `IF` in `$change` discards the `INVALID_INDEX_ERROR` of `SOURCE[I - 1]` in the first iteration.

#### Result:

`LOAD_INDICATOR("RSI", { period: 2 })` with `CLOSE` = `[1, 2, 1, 3]`:

```js
[null, null, 50, 83.33333333333333]
```

| `I` | change | `$avgGain` | `$avgLoss` | Result |
| :-: | :----: | :--------: | :--------: | :----- |
| 0 | - | `null` | `null` | `null` |
| 1 | `+1` | `null` | `null` | `null` |
| 2 | `-1` | `(1 + 0) / 2` = `0.5` | `(0 + 1) / 2` = `0.5` | `50` |
| 3 | `+2` | `(0.5 * 1 + 2) / 2` = `1.25` | `(0.5 * 1 + 0) / 2` = `0.25` | `100 - 100 / 6` |

#### Usage:

```php
$rsi = LOAD_INDICATOR("RSI", { period: 14 })
IF(CROSSOVER($rsi, 30), BUY, NEUTRAL)   # RSI leaves the oversold zone
```

## Reference

- [Stock standard](../README.md)
- [`LOAD_INDICATOR`](../functions/LOAD_INDICATOR.md)
- [Memory](../../../core/context.md#memory)
- [Metadata](../../../core/metadata.md)
- [Iteration Context](../../../core/context.md#2-iteration-context)
- [Strategy examples](strategy_examples.md)
