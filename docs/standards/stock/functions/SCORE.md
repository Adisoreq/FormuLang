# SCORE

[**Stock**](../README.md) standard function. Returns the share of the conditions that are met, from `0` to `1`.

Since `stock-1.2`. Optional **weights** make some conditions count more than others. It is used with the `checks` of the [signal object](../README.md#strategy-context) of a strategy: `SCORE($buy) == 1` means "all the conditions are met", and `SCORE($buy)` can be the strength of the signal. The function does not need a Stock Context.

Since `stock-1.3`, a condition may be `null` (e.g. a pattern of another timeframe before its first candle): it counts as a condition that is not met, and it stays in the denominator. [`SIGNAL_SCORE(buy, sell)`](SIGNAL_SCORE.md) computes `SCORE(buy) - SCORE(sell)`, a signal from `-1` to `1`, with one Object of weights for both sides.

## Overloads

### Overload 1: Object

Signature: `SCORE(conditions <Object>)`

Collection template:

| # | Name |   | Base type | Extended type | Any type | Multiple | Optional |
| - | :--: | - | :-------: | :-----------: | :------: | :------: | :------: |
| 1 | conditions | | Object | - | false | false | false |

Algorithm:

1. If a value of `conditions` is neither a **Boolean** nor `null` (`null` since `stock-1.3`), returns an `ARGUMENT_ERROR`.
2. If `conditions` has no keys, returns `0`.
3. Otherwise, returns the number of `true` values divided by the number of keys.

---

### Overload 2: Array

Signature: `SCORE(conditions <Array<Boolean>>)`

Collection template:

| # | Name |   | Base type | Extended type | Any type | Multiple | Optional |
| - | :--: | - | :-------: | :-----------: | :------: | :------: | :------: |
| 1 | conditions | | Array&lt;Boolean&gt; | - | false | false | false |

Since `stock-1.3`, the elements may also be `null`; a `null` element is not a `true` element.

Algorithm:

1. If the array is empty, returns `0`.
2. Otherwise, returns the number of `true` elements divided by the number of elements.

Examples:

| Formula | Result |
| :------ | :----- |
| `SCORE({ a: true, b: false, c: true, d: true })` | `0.75` |
| `SCORE([true, true, true, true, true, false, false])` | `0.7142857142857143` |
| `SCORE({ })` | `0` |
| `SCORE([ ])` | `0` |
| `SCORE({ a: true, b: 1 })` | `[ARGUMENT_ERROR (6)] ...` |
| `SCORE([true, null])` | `0.5` (since `stock-1.3`) |
| `SCORE({ a: true, b: null })` | `0.5` (since `stock-1.3`) |
| `SCORE($buy) - SCORE($sell)` | a signal from `-1` to `1`, the same as [`SIGNAL_SCORE($buy, $sell)`](SIGNAL_SCORE.md) |

A strategy that buys when at least 5 of 7 conditions are met, with the strength of the signal (the threshold of the strength is a setting of the host application):

```php
$buy = { trend: CLOSE[I] > $ema[I], momentum: $rsi[I] > 50, cross: CROSSOVER($macd, $signal), ... }
{ signal: IF(SCORE($buy) >= 5 / 7, SCORE($buy), NEUTRAL), checks: $buy }
```

---

### Overload 3: Object with weights

Signature: `SCORE(conditions <Object>, weights <Object>)`

Some conditions can count more than others, e.g. the trend twice as much as the momentum.

Collection template:

| # | Name |   | Base type | Extended type | Any type | Multiple | Optional |
| - | :--: | - | :-------: | :-----------: | :------: | :------: | :------: |
| 1 | conditions | | Object | - | false | false | false |
| 2 | weights | | Object | - | false | false | false |

Algorithm:

1. If a value of `conditions` is neither a **Boolean** nor `null`, or a value of `weights` is not a **Number**, returns an `ARGUMENT_ERROR`.
2. If `weights` has a key that is not a key of `conditions`, returns an `INVALID_KEY_ERROR` (a misspelt condition is not ignored).
3. If a weight is negative, returns an `OPERATION_ERROR`.
4. Every key of `conditions` has the weight from `weights`, or `1` if `weights` does not have it.
5. If the sum of the weights is `0` (also for an empty `conditions`), returns `0`.
6. Otherwise, returns the sum of the weights of the `true` values divided by the sum of all the weights.

---

### Overload 4: Array with weights

Signature: `SCORE(conditions <Array<Boolean>>, weights <Array<Number>>)`

Collection template:

| # | Name |   | Base type | Extended type | Any type | Multiple | Optional |
| - | :--: | - | :-------: | :-----------: | :------: | :------: | :------: |
| 1 | conditions | | Array&lt;Boolean&gt; | - | false | false | false |
| 2 | weights | | Array&lt;Number&gt; | - | false | false | false |

Algorithm:

1. If `weights` does not have as many elements as `conditions`, or a weight is negative, returns an `OPERATION_ERROR`.
2. If the sum of the weights is `0` (also for empty arrays), returns `0`.
3. Otherwise, returns the sum of the weights of the `true` elements divided by the sum of all the weights.

Examples:

| Formula | Result |
| :------ | :----- |
| `SCORE({ trend: true, momentum: false, cross: true }, { trend: 2 })` | `0.75` (`(2 + 1) / (2 + 1 + 1)`) |
| `SCORE({ trend: false, momentum: true, cross: true }, { trend: 2 })` | `0.5` |
| `SCORE({ a: true, b: false }, { a: 0 })` | `0` (`a` does not count) |
| `SCORE({ a: true, b: false }, { a: 0, b: 0 })` | `0` (the sum of the weights is `0`) |
| `SCORE({ a: true }, { b: 2 })` | `[INVALID_KEY_ERROR (8)] ...` |
| `SCORE({ a: true }, { a: -1 })` | `[OPERATION_ERROR (3)] ...` |
| `SCORE([true, false, true], [3, 1, 1])` | `0.8` |
| `SCORE([true, false], [1])` | `[OPERATION_ERROR (3)] ...` |

The weights are a part of the strategy, so they can come from its parameters, and the host application can change them for every instance:

```php
$buy = { trend: CLOSE[I] > $ema[I], momentum: $rsi[I] > 50, cross: CROSSOVER($macd, $signal) }
{ signal: SCORE($buy, { trend: PARAMETERS.trendWeight }), checks: $buy }
```

## Errors

- [`ARGUMENT_ERROR`](../../core/errors/ARGUMENT_ERROR.md) - the arguments match no overload, e.g. an element or a value of `conditions` is neither a **Boolean** nor `null`, or a weight is not a **Number**. If an argument, or one of its elements or values, is an **Error**, that **Error** is returned instead (see [Evaluation](../../../semantics/evaluation.md#3-function-call)).
- [`INVALID_KEY_ERROR`](../../core/errors/INVALID_KEY_ERROR.md) - `weights` has a key that is not a key of `conditions`.
- [`OPERATION_ERROR`](../../core/errors/OPERATION_ERROR.md) - a weight is negative, or the arrays of `conditions` and `weights` have different lengths.

## Reference

- [Stock standard](../README.md#strategy-context)
- [Stock functions](README.md)
- [`SIGNAL_SCORE`](SIGNAL_SCORE.md)
- [Pattern and strategy examples](../examples/strategy_examples.md)
