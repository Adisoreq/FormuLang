# CROSSUNDER

[**Stock**](../README.md) standard [series function](README.md#series-functions). Checks if a series crosses below another series, or below a constant value, at the current candle.

Since `stock-1.2`. `CROSSUNDER($macd, $signal)` is `$macd[I - 1] >= $signal[I - 1] && $macd[I] < $signal[I]`, without an error on the first candle or while one of the values is `null`. It is the opposite of [`CROSSOVER`](CROSSOVER.md): `CROSSUNDER(a, b)` is `CROSSOVER(b, a)`.

## Overloads

### Overload 1: Two series

Signature: `CROSSUNDER(a <Array>, b <Array>)`

### Overload 2: Series and a value

Signature: `CROSSUNDER(a <Array>, b <Number>)`

### Overload 3: Value and a series

Signature: `CROSSUNDER(a <Number>, b <Array>)`

Collection template (overload 1; in the overloads 2 and 3 one of the arguments is a **Number**):

| # | Name |   | Base type | Extended type | Any type | Multiple | Optional |
| - | :--: | - | :-------: | :-----------: | :------: | :------: | :------: |
| 1 | a | | Array | - | false | false | false |
| 2 | b | | Array | - | false | false | false |

Algorithm:

1. Checks the [common rules](README.md#series-functions): a Stock Context, and `N` elements of every series argument.
2. If the current candle is the first one, returns `false`.
3. Takes the values of `a` and `b` at the previous candle (`a₀`, `b₀`) and at the current candle (`a₁`, `b₁`). If one of them is `null`, returns `false`. If one of them is neither a **Number** nor `null`, returns an `OPERATION_ERROR`.
4. Returns `true` if `a₀ >= b₀` and `a₁ < b₁`; otherwise returns `false`.

Examples (`$fast` = `[5, 4, 2, 1]`, `$slow` = `[3, 3, 3, 3]`):

| Formula | Current candle | Result |
| :------ | :------------: | :----- |
| `CROSSUNDER($fast, $slow)` | the third one | `true` (`4 >= 3`, `2 < 3`) |
| `CROSSUNDER($fast, $slow)` | the fourth one | `false` (already below) |
| `CROSSUNDER($fast, 3)` | the third one | `true` |
| `CROSSUNDER($fast, $slow)` | the first one | `false` |

## Errors

- [`OPERATION_ERROR`](../../core/errors/OPERATION_ERROR.md) - the function is called outside of a Stock Context, a series does not have `N` elements, or a needed value is neither a **Number** nor `null`.
- [`ARGUMENT_ERROR`](../../core/errors/ARGUMENT_ERROR.md) - the arguments match no overload (e.g. two numbers). If one of the arguments is an **Error**, that **Error** is returned instead (see [Evaluation](../../../semantics/evaluation.md#3-function-call)).

## Reference

- [Stock functions](README.md#series-functions)
- [`CROSSOVER`](CROSSOVER.md)
