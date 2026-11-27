# CROSSOVER

[**Stock**](../README.md) standard [series function](README.md#series-functions). Checks if a series crosses above another series, or above a constant value, at the current candle.

Since `stock-1.2`. `CROSSOVER($macd, $signal)` is `$macd[I - 1] <= $signal[I - 1] && $macd[I] > $signal[I]`, without an error on the first candle or while one of the values is `null`.

## Overloads

### Overload 1: Two series

Signature: `CROSSOVER(a <Array>, b <Array>)`

### Overload 2: Series and a value

Signature: `CROSSOVER(a <Array>, b <Number>)`

`b` is the same value at every candle, e.g. `CROSSOVER($histogram, 0)`.

### Overload 3: Value and a series

Signature: `CROSSOVER(a <Number>, b <Array>)`

Collection template (overload 1; in the overloads 2 and 3 one of the arguments is a **Number**):

| # | Name |   | Base type | Extended type | Any type | Multiple | Optional |
| - | :--: | - | :-------: | :-----------: | :------: | :------: | :------: |
| 1 | a | | Array | - | false | false | false |
| 2 | b | | Array | - | false | false | false |

Algorithm:

1. Checks the [common rules](README.md#series-functions): a Stock Context, and `N` elements of every series argument.
2. If the current candle is the first one, returns `false`.
3. Takes the values of `a` and `b` at the previous candle (`a₀`, `b₀`) and at the current candle (`a₁`, `b₁`). If one of them is `null`, returns `false`. If one of them is neither a **Number** nor `null`, returns an `OPERATION_ERROR`.
4. Returns `true` if `a₀ <= b₀` and `a₁ > b₁`; otherwise returns `false`.

Examples (`$fast` = `[1, 2, 4, 5]`, `$slow` = `[3, 3, 3, 3]`):

| Formula | Current candle | Result |
| :------ | :------------: | :----- |
| `CROSSOVER($fast, $slow)` | the third one | `true` (`2 <= 3`, `4 > 3`) |
| `CROSSOVER($fast, $slow)` | the fourth one | `false` (already above) |
| `CROSSOVER($fast, 3)` | the third one | `true` |
| `CROSSOVER($fast, $slow)` | the first one | `false` |
| `CROSSOVER([null, 2, 4, 5], $slow)` | the second one | `false` (a `null` value) |
| `CROSSOVER($fast, [3, 2, 3, 3])` | the second one | `false` (`1 <= 3`, but `2 > 2` is `false`: touching is not crossing) |
| `CROSSOVER($fast, [3, 2, 3, 3])` | the third one | `true` (`2 <= 2`, `4 > 3`: a value equal at the previous candle counts as below) |

## Errors

- [`OPERATION_ERROR`](../../core/errors/OPERATION_ERROR.md) - the function is called outside of a Stock Context, a series does not have `N` elements, or a needed value is neither a **Number** nor `null`.
- [`ARGUMENT_ERROR`](../../core/errors/ARGUMENT_ERROR.md) - the arguments match no overload (e.g. two numbers). If one of the arguments is an **Error**, that **Error** is returned instead (see [Evaluation](../../../semantics/evaluation.md#3-function-call)).

## Reference

- [Stock functions](README.md#series-functions)
- [`CROSSUNDER`](CROSSUNDER.md)
