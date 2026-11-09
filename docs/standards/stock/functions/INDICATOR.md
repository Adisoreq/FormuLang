# INDICATOR

[**Stock**](../README.md) standard function. Computes an indicator from the [indicator registry](../README.md#2-indicator-registry) for every candle, and returns its whole series.

The function can be called only in a context derived from the [Stock Context](../README.md#stock-context) (e.g. in another indicator or in a strategy).

## Overloads

### Overload 1: Default parameters

Signature: `INDICATOR(id <Text>)`

Equivalent of `INDICATOR(id, { })`: every parameter has its default value.

### Overload 2: Parameters

Signature: `INDICATOR(id <Text>, parameters <Object>)`

Equivalent of `INDICATOR(id, parameters, CLOSE)`.

### Overload 3: Parameters and source

Signature: `INDICATOR(id <Text>, parameters <Object>, source <Array>)`

Collection template:

| # | Name |   | Base type | Extended type | Any type | Multiple | Optional |
| - | :--: | - | :-------: | :-----------: | :------: | :------: | :------: |
| 1 | id | | Text | - | false | false | false |
| 2 | parameters | | Object | - | false | false | false |
| 3 | source | | Array | - | false | false | false |

Algorithm:

1. Finds the indicator definition with the identifier `id`. If there is none, returns an `INVALID_KEY_ERROR`.
2. If `parameters` has a key that is not a parameter of the definition, returns an `INVALID_KEY_ERROR`. Otherwise, completes `parameters` with the default values of the missing parameters.
3. If `source` does not have `N` elements, or one of its elements is neither a **Number** nor `null`, returns an `OPERATION_ERROR`.
4. If the same indicator with the same parameters and source is already being computed by one of the calling formulas (the indicator calls itself, directly or indirectly), returns an `OPERATION_ERROR`.
5. Creates a new [Indicator Context](../README.md#indicator-context), a **child context**:
   - `CANDLES`, `OPEN`, `HIGH`, `LOW`, `CLOSE`, `VOLUME`, `TIME` and `N` are the same as in the calling context (read-only);
   - `PARAMETERS` is the completed `parameters` object, `SOURCE` is `source`;
   - the child context has its own iterations (`I`, `PREV`) and its own context variables;
   - environment variables are taken from the environment: values overridden by the calling formula (e.g. `@array_indexing = 1`) are **not** passed to the child context.
6. Executes the formula of the indicator for every candle, from the first to the last.
   - If an iteration results in an **Error**, returns that **Error**.
   - If an iteration returns a value that is not allowed in the Indicator Context, or its kind differs from the previous non-`null` results, returns an `OPERATION_ERROR`.
7. Returns an array of `N` results: the element at the index `I` is the value of the indicator for the candle `CANDLES[I]`.

To read the value for the current candle, index the result with `I`: `INDICATOR("SMA", { period: 20 })[I]`.

Examples (registry with `SMA` and `MACD` from the [indicator examples](../examples/indicator_examples.md), `CLOSE` = `[1, 2, 3, 4, 5]`):

| Formula | Result |
| :------ | :----- |
| `INDICATOR("SMA", { period: 3 })` | `[ null, null, 2, 3, 4 ]` |
| `INDICATOR("SMA", { period: 2 }, [10, 20, 30, 40, 50])` | `[ null, 15, 25, 35, 45 ]` |
| `INDICATOR("SMA", { period: 3 })[I]` (with `I` = `4`) | `4` |
| `INDICATOR("XYZ")` | `[INVALID_KEY_ERROR (8)] ...` |
| `INDICATOR("SMA", { length: 3 })` | `[INVALID_KEY_ERROR (8)] ...` |
| `INDICATOR("SMA", { period: 3 }, [1, 2])` | `[OPERATION_ERROR (3)] ...` |

## Performance

The result does not depend on the iteration of the calling formula, but the calling formula calls `INDICATOR` in every iteration. A naive implementation computes the whole series `N` times, so it needs `N²` executions of the indicator formula.

Indicator formulas are deterministic: the same indicator, parameters, source and candles always give the same series. An implementation **may** therefore store the series and reuse it, as long as the result is the same as computing it again. The key of the stored series is the identifier, the completed parameters and the source.

## Errors

- [`INVALID_KEY_ERROR`](../../core/errors/INVALID_KEY_ERROR.md) - there is no indicator with the identifier `id`, or `parameters` has a key that the indicator does not define.
- [`OPERATION_ERROR`](../../core/errors/OPERATION_ERROR.md) - `source` has a wrong length or a wrong element, the indicator calls itself, an iteration returns a value that is not allowed, or the function is called outside of a Stock Context.
- An **Error** that results from an iteration of the indicator is returned unchanged.
- [`ARGUMENT_ERROR`](../../core/errors/ARGUMENT_ERROR.md) - the arguments match no overload. If one of the arguments is an **Error**, that **Error** is returned instead (see [Evaluation](../../../semantics/evaluation.md#3-function-call)).

## Reference

- [Stock standard](../README.md)
- [Stock functions](README.md)
- [Context](../../../core/context.md#context-types)
- [Indicator examples](../examples/indicator_examples.md)
