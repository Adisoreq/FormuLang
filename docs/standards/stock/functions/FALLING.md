# FALLING

[**Stock**](../README.md) standard [series function](README.md#series-functions). Checks if a series has fallen at each of the last candles.

Since `stock-1.2`. `FALLING(CLOSE, 3)` is `true` if each of the last 3 closes is lower than the close before it. It works like [`RISING`](RISING.md), in the other direction.

## Overloads

### Overload 1

Signature: `FALLING(series <Array>, length <Number>)`

Collection template:

| # | Name |   | Base type | Extended type | Any type | Multiple | Optional |
| - | :--: | - | :-------: | :-----------: | :------: | :------: | :------: |
| 1 | series | | Array | - | false | false | false |
| 2 | length | | Number | - | false | false | false |

Algorithm:

1. Checks the [common rules](README.md#series-functions): a Stock Context, and `N` elements of `series`.
2. If `length` is not a whole number or is less than `1`, returns an `OPERATION_ERROR`.
3. Takes the `length + 1` elements of `series` that end at the position of the current candle. If there are fewer, returns `false`.
4. If one of them is `null`, returns `false`. If one of them is neither a **Number** nor `null`, returns an `OPERATION_ERROR`.
5. Returns `true` if every element is lower than the element before it; otherwise returns `false`. Equal values are not a fall.

Examples (`CLOSE` = `[5, 4, 3, 3, 2]`):

| Formula | Current candle | Result |
| :------ | :------------: | :----- |
| `FALLING(CLOSE, 2)` | the third one | `true` (`5 > 4 > 3`) |
| `FALLING(CLOSE, 2)` | the fifth one | `false` |
| `FALLING(CLOSE, 1)` | the fifth one | `true` |

## Errors

- [`OPERATION_ERROR`](../../core/errors/OPERATION_ERROR.md) - the function is called outside of a Stock Context, `series` does not have `N` elements, `length` is not a whole number or is less than `1`, or a needed element is neither a **Number** nor `null`.
- [`ARGUMENT_ERROR`](../../core/errors/ARGUMENT_ERROR.md) - the arguments match no overload. If one of the arguments is an **Error**, that **Error** is returned instead (see [Evaluation](../../../semantics/evaluation.md#3-function-call)).

## Reference

- [Stock functions](README.md#series-functions)
- [`RISING`](RISING.md)
