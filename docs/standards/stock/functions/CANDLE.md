# CANDLE

[**Stock**](../README.md) standard function. Creates a [`Stock.Candle`](../types/Candle.md) from an **Object**.

## Overloads

### Overload 1

Signature: `CANDLE(object <Object>)`

Collection template:

| # | Name |   | Base type | Extended type | Any type | Multiple | Optional |
| - | :--: | - | :-------: | :-----------: | :------: | :------: | :------: |
| 1 | object | | Object | - | false | false | false |

Algorithm:

- If `object` has a key that is not an [attribute](../types/Candle.md#attributes) of `Stock.Candle`, returns an `OPERATION_ERROR`
- If a required attribute (`open`, `high`, `low`, `close`) is missing or is not a **Number**, returns an `OPERATION_ERROR`
- If `volume` or `time` is given and is neither a **Number** nor `null`, returns an `OPERATION_ERROR`
- If the values break the [rules](../types/Candle.md#attributes) of `Stock.Candle` (e.g. `high` lower than `close`), returns an `OPERATION_ERROR`
- Otherwise, returns a new `Stock.Candle` with the values of `object`; `volume` and `time` are `null` if they are not given. `object` is not changed

Examples:

| Formula | Result |
| :------ | :----- |
| `CANDLE({ open: 1_000, high: 1_200, low: 800, close: 1_000 })` | `[Stock.Candle] { open: 1000, high: 1200, low: 800, close: 1000, volume: null, time: null }` |
| `CANDLE({ open: 10, high: 12, low: 9, close: 11, volume: 5_000 })` | `[Stock.Candle] { open: 10, high: 12, low: 9, close: 11, volume: 5000, time: null }` |
| `CANDLE({ open: 1_000, low: 300 })` | `[OPERATION_ERROR (3)] Object does not meet the requirements to be <Stock.Candle>.` |
| `CANDLE({ open: 10, high: 9, low: 8, close: 11 })` | `[OPERATION_ERROR (3)] Object does not meet the requirements to be <Stock.Candle>.` |

Results are shown with `include_object_class` set to `true`.

## Errors

- [`OPERATION_ERROR`](../../core/errors/OPERATION_ERROR.md) - `object` does not meet the requirements of `Stock.Candle`. Detail text: `Object does not meet the requirements to be <Stock.Candle>.`
- [`ARGUMENT_ERROR`](../../core/errors/ARGUMENT_ERROR.md) - the arguments match no overload. If the argument is an **Error**, that **Error** is returned instead (see [Evaluation](../../../semantics/evaluation.md#3-function-call)).

## Reference

- [Stock standard](../README.md)
- [Stock functions](README.md)
- [`Stock.Candle`](../types/Candle.md)
