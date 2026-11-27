# LOAD_INDICATOR

[**Stock**](../README.md) standard function. Computes an indicator from the [indicator registry](../README.md#2-formula-registry) for every candle, and returns its whole series.

The function can be called only in a context derived from the [Stock Context](../README.md#stock-context) (e.g. in another indicator or in a strategy).

## Overloads

### Overload 1: Default parameters

Signature: `LOAD_INDICATOR(id <Text>)`

Equivalent of `LOAD_INDICATOR(id, { })`: every parameter has its default value.

### Overload 2: Parameters

Signature: `LOAD_INDICATOR(id <Text>, parameters <Object>)`

Equivalent of `LOAD_INDICATOR(id, parameters, CLOSE)`.

### Overload 3: Parameters and source

Signature: `LOAD_INDICATOR(id <Text>, parameters <Object>, source <Array>)`

Collection template:

| # | Name |   | Base type | Extended type | Any type | Multiple | Optional |
| - | :--: | - | :-------: | :-----------: | :------: | :------: | :------: |
| 1 | id | | Text | - | false | false | false |
| 2 | parameters | | Object | - | false | false | false |
| 3 | source | | Array | - | false | false | false |

Algorithm:

1. Finds the indicator definition with the identifier `id` in the indicators part of the registry. If there is none, returns an `INVALID_KEY_ERROR`.
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

To read the value for the current candle, index the result with `I`: `LOAD_INDICATOR("SMA", { period: 20 })[I]`.

Examples (registry with `SMA` and `MACD` from the [indicator examples](../examples/indicator_examples.md), `CLOSE` = `[1, 2, 3, 4, 5]`):

| Formula | Result |
| :------ | :----- |
| `LOAD_INDICATOR("SMA", { period: 3 })` | `[ null, null, 2, 3, 4 ]` |
| `LOAD_INDICATOR("SMA", { period: 2 }, [10, 20, 30, 40, 50])` | `[ null, 15, 25, 35, 45 ]` |
| `LOAD_INDICATOR("SMA", { period: 3 })[I]` (with `I` = `4`) | `4` |
| `LOAD_INDICATOR("XYZ")` | `[INVALID_KEY_ERROR (8)] ...` |
| `LOAD_INDICATOR("SMA", { length: 3 })` | `[INVALID_KEY_ERROR (8)] ...` |
| `LOAD_INDICATOR("SMA", { period: 3 }, [1, 2])` | `[OPERATION_ERROR (3)] ...` |

### Overload 4: Options

Signature: `LOAD_INDICATOR(id <Text>, parameters <Object>, options <Object>)`

Since `stock-1.2`. The third argument is an **Object** of options instead of the source **Array**:

| Option | Type | Default | Description |
| :----- | :--: | :-----: | :---------- |
| `source` | `Array` | the closes of the candles of the indicator | Input series of the indicator (`SOURCE`). Without `timeframe`, it must have `N` elements, as in the overload 3. With `timeframe`, it must have one element for every candle of that timeframe. |
| `timeframe` | `Text` | the main chart | Computes the indicator over the candles of another timeframe (see [Other timeframes](../README.md#other-timeframes)). |
| `output` | `Text` | - | For an indicator whose results are **Objects**: returns the series of one key (e.g. `"histogram"`), with `null` where the result is `null`. For an indicator whose results are **Numbers**, the only allowed output is `"value"`, which returns the series unchanged. |
| `align` | `Boolean` | `true` | With `timeframe`: `true` returns the aligned series (`N` elements), `false` returns the native series. Without `timeframe`, it has no effect. |

Collection template:

| # | Name |   | Base type | Extended type | Any type | Multiple | Optional |
| - | :--: | - | :-------: | :-----------: | :------: | :------: | :------: |
| 1 | id | | Text | - | false | false | false |
| 2 | parameters | | Object | - | false | false | false |
| 3 | options | | Object | - | false | false | false |

Algorithm:

1. If `options` has a key that is not an option above, or an option of a wrong type, returns an `ARGUMENT_ERROR`.
2. Without `timeframe`: computes the series like the overload 3, with `source` (`CLOSE` by default).
3. With `timeframe`:
   1. If the host application does not provide the timeframe, returns a `NOT_SUPPORTED_ERROR`.
   2. Finds the definition and completes the parameters like the steps 1 - 2 of the overload 3.
   3. If `source` is given and does not have one element for every candle of the timeframe, or one of its elements is neither a **Number** nor `null`, returns an `OPERATION_ERROR`.
   4. Creates a child [Indicator Context](../README.md#indicator-context) over the candles of the timeframe: `CANDLES`, `OPEN`, `HIGH`, `LOW`, `CLOSE`, `VOLUME`, `TIME` and `N` are those of the timeframe, `TIMEFRAME` is `timeframe`, `INSTRUMENT` is the same as in the calling context, and `SOURCE` is `source` (the closes of the timeframe by default). The other rules are the step 5 of the overload 3.
   5. Executes the formula of the indicator for every candle of the timeframe, like the step 6 of the overload 3. This gives the **native** series of the whole timeframe.
   6. If `align` is `true`, returns the aligned series: an array of `N` elements, where the element `k` is the element of the native series that belongs to the last candle of the timeframe closed at the candle `k` of the main chart, or `null` if there is none. If `align` is `false`, returns the elements of the native series that belong to the candles closed at the current candle.
4. If `output` is given, replaces every non-`null` element `e` of the result with `e[output]` (or keeps it for `"value"` and a Number result). If a non-`null` element does not have the key `output`, returns an `INVALID_KEY_ERROR`.
5. Returns the result.

Examples (registry with `SMA` and `MACD` from the [indicator examples](../examples/indicator_examples.md), main chart `15m`, `CLOSE` = `[1, 2, 3, 4, 5]`):

| Formula | Result |
| :------ | :----- |
| `LOAD_INDICATOR("SMA", { period: 3 }, { })` | `[ null, null, 2, 3, 4 ]` (the same as the overload 2) |
| `LOAD_INDICATOR("SMA", { period: 2 }, { source: [10, 20, 30, 40, 50] })` | `[ null, 15, 25, 35, 45 ]` |
| `LOAD_INDICATOR("MACD", { }, { output: "histogram" })` | the histogram of MACD: a series of **Number** and `null` values |
| `LOAD_INDICATOR("SMA", { period: 3 }, { output: "value" })` | `[ null, null, 2, 3, 4 ]` |
| `LOAD_INDICATOR("MACD", { }, { output: "x" })` | `[INVALID_KEY_ERROR (8)] ...` (once the MACD has a value) |
| `LOAD_INDICATOR("EMA", { period: 200 }, { timeframe: "1h" })[I]` | the 200-period EMA of the 1-hour candles, for the last 1-hour candle closed at the current candle |
| `LOAD_INDICATOR("EMA", { period: 200 }, { timeframe: "1w" })` | `[NOT_SUPPORTED_ERROR (11)] ...` (the host application does not provide `1w`) |
| `LOAD_INDICATOR("SMA", { period: 3 }, { period: 3 })` | `[ARGUMENT_ERROR (6)] ...` (`period` is not an option) |

## Performance

The result does not depend on the iteration of the calling formula, but the calling formula calls `LOAD_INDICATOR` in every iteration. A naive implementation computes the whole series `N` times, so it needs `N²` executions of the indicator formula.

Indicator formulas are deterministic: the same indicator, parameters, source and candles always give the same series. An implementation **may** therefore store the series and reuse it, as long as the result is the same as computing it again. The key of the stored series is the identifier, the completed parameters, the source and the timeframe. The options `output` and `align` are not a part of the key: they only take a part of the stored series, so `LOAD_INDICATOR("MACD", { }, { output: "macd" })` and `LOAD_INDICATOR("MACD", { }, { output: "signal" })` compute the indicator once.

The series of another timeframe changes only when a candle of that timeframe closes, and a series of the main chart only when a candle is added. An implementation that [resumes the iterations](../../../core/context.md#resumed-iterations) of the calling context may resume the iterations of the child context too.

An implementation may also compute a registry definition by other means than its formula (e.g. compiled code of the host application), as long as the result is the same as executing the formula.

## Errors

- [`INVALID_KEY_ERROR`](../../core/errors/INVALID_KEY_ERROR.md) - there is no indicator with the identifier `id`, `parameters` has a key that the indicator does not define, or a result does not have the key `output`.
- [`NOT_SUPPORTED_ERROR`](../../core/errors/NOT_SUPPORTED_ERROR.md) - the host application does not provide the `timeframe`.
- [`OPERATION_ERROR`](../../core/errors/OPERATION_ERROR.md) - `source` has a wrong length or a wrong element, the indicator calls itself, an iteration returns a value that is not allowed, or the function is called outside of a Stock Context.
- An **Error** that results from an iteration of the indicator is returned unchanged.
- [`ARGUMENT_ERROR`](../../core/errors/ARGUMENT_ERROR.md) - the arguments match no overload, or `options` has an unknown key or an option of a wrong type. If one of the arguments is an **Error**, that **Error** is returned instead (see [Evaluation](../../../semantics/evaluation.md#3-function-call)).

## Reference

- [Stock standard](../README.md)
- [Stock functions](README.md)
- [`LOAD_CANDLES`](LOAD_CANDLES.md)
- [Other timeframes](../README.md#other-timeframes)
- [Context](../../../core/context.md#context-types)
- [Indicator examples](../examples/indicator_examples.md)
