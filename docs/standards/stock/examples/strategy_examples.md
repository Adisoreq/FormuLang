# Pattern and strategy examples

Formulas executed in a [Pattern Context](../README.md#pattern-context) or a [Strategy Context](../README.md#strategy-context), once for every candle. The indicators come from the [indicator examples](indicator_examples.md).

## Example 1: Bullish engulfing pattern

**Context**: Pattern Context

**Result**: `true` if the current candle is bullish and its body covers the body of the previous, bearish candle.

#### Formula:

```php
# In the first iteration, the previous candle is the current one
$prev = CANDLES[MAX(I - 1, @array_indexing)]
$curr = CANDLES[I]

$prev_bearish = $prev.close < $prev.open
$curr_bullish = $curr.close > $curr.open
$covers = AND($curr.open <= $prev.close, $curr.close >= $prev.open)

AND(I > @array_indexing, AND($prev_bearish, AND($curr_bullish, $covers)))
```

## Example 2: Moving average crossover

**Context**: Strategy Context

**Result**: `BUY` when the fast SMA crosses above the slow SMA, `SELL` when it crosses below, `NEUTRAL` otherwise.

#### Formula:

```php
$fast = INDICATOR("SMA", { period: 10 })
$slow = INDICATOR("SMA", { period: 40 })

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
$macd = INDICATOR("MACD")[I]

IF(ISNULL($macd),
   NEUTRAL,
   CLAMP($macd.histogram / CLOSE[I] * 100, SELL, BUY))
```

## Reference

- [Stock standard](../README.md)
- [`INDICATOR`](../functions/INDICATOR.md)
- [Indicator examples](indicator_examples.md)
