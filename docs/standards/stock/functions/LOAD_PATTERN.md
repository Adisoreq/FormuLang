# LOAD_PATTERN

[**Stock**](../README.md) standard function. Checks a pattern from the [formula registry](../README.md#2-formula-registry) for every candle, and returns its whole series of results.

The function can be called only in a context derived from the [Stock Context](../README.md#stock-context) (e.g. in a strategy, an indicator or another pattern).

## Overloads

### Overload 1: Default parameters

Signature: `LOAD_PATTERN(id <Text>)`

Equivalent of `LOAD_PATTERN(id, { })`: every parameter has its default value.

### Overload 2: Parameters

Signature: `LOAD_PATTERN(id <Text>, parameters <Object>)`

Collection template:

| # | Name |   | Base type | Extended type | Any type | Multiple | Optional |
| - | :--: | - | :-------: | :-----------: | :------: | :------: | :------: |
| 1 | id | | Text | - | false | false | false |
| 2 | parameters | | Object | - | false | false | false |

Algorithm:

1. Finds the pattern definition with the identifier `id`. If there is none, returns an `INVALID_KEY_ERROR`.
2. If `parameters` has a key that is not a parameter of the definition, returns an `INVALID_KEY_ERROR`. Otherwise, completes `parameters` with the default values of the missing parameters.
3. If the same pattern with the same parameters is already being computed by one of the calling formulas (the pattern calls itself, directly or indirectly), returns an `OPERATION_ERROR`.
4. Creates a new [Pattern Context](../README.md#pattern-context), a **child context**, in the same way as [`LOAD_INDICATOR`](LOAD_INDICATOR.md) (step 5): the candle constants and `N` are the same as in the calling context, `PARAMETERS` is the completed `parameters` object, and the child context has its own iterations, context variables and environment variables.
5. Executes the formula of the pattern for every candle, from the first to the last.
   - If an iteration results in an **Error**, returns that **Error**.
   - If an iteration returns a value that is not a **Boolean**, returns an `OPERATION_ERROR`.
6. Returns an array of `N` **Boolean** values: the element at the index `I` is `true` if the pattern is found at the candle `CANDLES[I]`.

To check the current candle, index the result with `I`: `LOAD_PATTERN("ENGULFING")[I]`.

Examples (registry with `ENGULFING` from the [pattern examples](../examples/strategy_examples.md#example-1-bullish-engulfing-pattern), 4 candles, the third one is a bullish engulfing):

| Formula | Result |
| :------ | :----- |
| `LOAD_PATTERN("ENGULFING")` | `[ false, false, true, false ]` |
| `LOAD_PATTERN("ENGULFING")[I]` (with `I` = `2`) | `true` |
| `LEN(FILTER(LOAD_PATTERN("ENGULFING"), (e) => e))` | `1` |
| `LOAD_PATTERN("XYZ")` | `[INVALID_KEY_ERROR (8)] ...` |
| `LOAD_PATTERN("ENGULFING", { length: 3 })` | `[INVALID_KEY_ERROR (8)] ...` |

## Performance

Like indicators, pattern formulas are deterministic: the same pattern, parameters and candles always give the same series. An implementation **may** store the series and reuse it (see [`LOAD_INDICATOR`](LOAD_INDICATOR.md#performance)). The key of the stored series is the identifier and the completed parameters.

## Errors

- [`INVALID_KEY_ERROR`](../../core/errors/INVALID_KEY_ERROR.md) - there is no pattern with the identifier `id`, or `parameters` has a key that the pattern does not define.
- [`OPERATION_ERROR`](../../core/errors/OPERATION_ERROR.md) - the pattern calls itself, an iteration returns a value that is not a **Boolean**, or the function is called outside of a Stock Context.
- An **Error** that results from an iteration of the pattern is returned unchanged.
- [`ARGUMENT_ERROR`](../../core/errors/ARGUMENT_ERROR.md) - the arguments match no overload. If one of the arguments is an **Error**, that **Error** is returned instead (see [Evaluation](../../../semantics/evaluation.md#3-function-call)).

## Reference

- [Stock standard](../README.md)
- [Stock functions](README.md)
- [`LOAD_INDICATOR`](LOAD_INDICATOR.md)
- [Pattern and strategy examples](../examples/strategy_examples.md)
