# Indicator examples

Indicator definitions for the [indicator registry](../README.md#2-indicator-registry). Every formula is executed in an [Indicator Context](../README.md#indicator-context), once for every candle.

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

`INDICATOR("SMA", { period: 3 })` with `CLOSE` = `[1, 2, 3, 4, 5]`:

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

`INDICATOR("EMA", { period: 3 })` with `CLOSE` = `[1, 2, 3, 4, 5]` (`$alpha` = `0.5`):

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
$short = INDICATOR("EMA", { period: PARAMETERS.short_period }, SOURCE)
$long = INDICATOR("EMA", { period: PARAMETERS.long_period }, SOURCE)

# MACD line for every candle: the two series joined element by element
$line = MAP($short, (s, i) => IF(OR(ISNULL(s), ISNULL($long[i])), null, s - $long[i]))

$macd = $line[I]
$signal = INDICATOR("EMA", { period: PARAMETERS.signal_period }, $line)[I]

IF(OR(ISNULL($macd), ISNULL($signal)),
   null,
   { macd: $macd, signal: $signal, histogram: $macd - $signal })
```

#### Usage:

```php
$macd = INDICATOR("MACD")[I]   # default parameters: 12, 26, 9
IF(ISNULL($macd), null, $macd.histogram)
```

The `EMA` of `$line` skips the `null` values at the beginning of the MACD line: its window is complete only when it contains `signal_period` values that are not `null`.

## Reference

- [Stock standard](../README.md)
- [`INDICATOR`](../functions/INDICATOR.md)
- [Iteration Context](../../../core/context.md#2-iteration-context)
- [Strategy examples](strategy_examples.md)
