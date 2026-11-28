# SIGNAL_SCORE

[**Stock**](../README.md) standard function. Since `stock-1.3`. Returns the strength of a signal from the buy and the sell conditions: `SCORE(buy) - SCORE(sell)`, from `-1` to `1`.

`1` means that all the buy conditions are met and no sell condition is, `-1` the opposite, `0` no signal or as many reasons to buy as to sell. The host application decides from which strength it trades. Like [`SCORE`](SCORE.md), the function does not need a Stock Context.

```php
$buy = { aboveEma: CLOSE[I] > $ema[I], rsiUp: $rsi[I] > 50 }
$sell = { belowEma: CLOSE[I] < $ema[I], rsiDown: $rsi[I] < 50 }

SIGNAL_SCORE($buy, $sell)
```

## Overloads

### Overload 1

Signature: `SIGNAL_SCORE(buy <Object | Array>, sell <Object | Array>)`

Collection template:

| # | Name |   | Base type | Extended type | Any type | Multiple | Optional |
| - | :--: | - | :-------: | :-----------: | :------: | :------: | :------: |
| 1 | buy | | Object, Array | - | false | false | false |
| 2 | sell | | Object, Array | - | false | false | false |

Algorithm:

1. Returns `SCORE(buy) - SCORE(sell)` (see [`SCORE`](SCORE.md#overload-1-object)): a value of `buy` or `sell` is a **Boolean** or `null`, and `null` is a condition that is not met.
2. An empty `buy` or `sell` (`{ }` or `[ ]`) has the score `0`, so `SIGNAL_SCORE($buy, { })` is a strategy that only buys.

`buy` and `sell` may be of different kinds (an Object and an Array): the function returns only a **Number**.

Examples:

| Formula | Result |
| :------ | :----- |
| `SIGNAL_SCORE({ a: true, b: true }, { c: false, d: false })` | `1` |
| `SIGNAL_SCORE({ a: true, b: false }, { c: true, d: true })` | `-0.5` (`0.5 - 1`) |
| `SIGNAL_SCORE([true, true, true, false], [false, false, true, false])` | `0.5` (`0.75 - 0.25`) |
| `SIGNAL_SCORE({ a: true, b: null }, { })` | `0.5` |
| `SIGNAL_SCORE({ }, { })` | `0` |
| `SIGNAL_SCORE({ a: 1 }, { })` | `[ARGUMENT_ERROR (6)] ...` |

---

### Overload 2: Weights

Signature: `SIGNAL_SCORE(buy <Object>, sell <Object>, weights <Object>)`

One **Object** gives the weights of the conditions of both sides, by their keys. The keys of the buy and the sell conditions are usually different (`aboveEma`, `belowEma`); a key that both sides have gets the same weight on both sides.

Collection template:

| # | Name |   | Base type | Extended type | Any type | Multiple | Optional |
| - | :--: | - | :-------: | :-----------: | :------: | :------: | :------: |
| 1 | buy | | Object | - | false | false | false |
| 2 | sell | | Object | - | false | false | false |
| 3 | weights | | Object | - | false | false | false |

Algorithm:

1. If `weights` has a key that is a key of neither `buy` nor `sell`, returns an `INVALID_KEY_ERROR` (a misspelt condition is not ignored).
2. Lets `buyWeights` be the keys of `weights` that are keys of `buy`, with their values, and `sellWeights` the keys that are keys of `sell`.
3. Returns `SCORE(buy, buyWeights) - SCORE(sell, sellWeights)` (see [`SCORE`](SCORE.md#overload-3-object-with-weights)): a condition without a weight has the weight `1`, a negative weight is an `OPERATION_ERROR`, and a side whose weights sum to `0` has the score `0`.

Examples:

| Formula | Result |
| :------ | :----- |
| `SIGNAL_SCORE({ a: true, b: false }, { c: false }, { a: 3 })` | `0.75` (`3 / 4 - 0`) |
| `SIGNAL_SCORE({ a: true, b: false }, { c: true, d: false }, { a: 3, d: 3 })` | `0.5` (`3 / 4 - 1 / 4`) |
| `SIGNAL_SCORE({ trend: true }, { trend: false, rsi: true }, { trend: 2 })` | `0.6666666666666667` (`1 - 1 / 3`) |
| `SIGNAL_SCORE({ a: true }, { b: false }, { c: 2 })` | `[INVALID_KEY_ERROR (8)] ...` |
| `SIGNAL_SCORE({ a: true }, { b: false }, { a: -1 })` | `[OPERATION_ERROR (3)] ...` |

Weights of Arrays are not a part of this function: `SCORE(buy, buyWeights) - SCORE(sell, sellWeights)` with two Arrays of weights gives the same.

## How to write the conditions

Every condition moves the signal by `1 / LEN(buy)` or `1 / LEN(sell)` (without weights). The signal reaches `1` and `-1` and moves in equal steps when:

- both sides have the same number of conditions, and every pair describes one thing, e.g. `aboveEma` and `belowEma`;
- the sell conditions are written directly (`CLOSE[I] < $ema[I]`), not as a negation of the buy conditions: with a `null` value (see [Missing values](../../core/README.md#missing-values)), `!(CLOSE[I] > $ema[I])` is `true`.

A condition that only one side has (e.g. a bullish pattern) can be given a weight, or left out. A filter that applies to both sides (e.g. "the volatility is high enough") is not a condition: it would count for both. Apply it to the result instead: `IF($isVolatile, SIGNAL_SCORE($buy, $sell), NEUTRAL)`.

## Errors

- [`ARGUMENT_ERROR`](../../core/errors/ARGUMENT_ERROR.md) - the arguments match no overload, e.g. a value of `buy` or `sell` is neither a **Boolean** nor `null`, or a weight is not a **Number**. If an argument, or one of its elements or values, is an **Error**, that **Error** is returned instead (see [Evaluation](../../../semantics/evaluation.md#3-function-call)).
- [`INVALID_KEY_ERROR`](../../core/errors/INVALID_KEY_ERROR.md) - `weights` has a key that is a key of neither `buy` nor `sell`.
- [`OPERATION_ERROR`](../../core/errors/OPERATION_ERROR.md) - a weight is negative.

## Reference

- [`SCORE`](SCORE.md)
- [Stock standard](../README.md#strategy-context)
- [Stock functions](README.md)
- [Pattern and strategy examples](../examples/strategy_examples.md#example-9-buy-and-sell-conditions-on-other-timeframes)
