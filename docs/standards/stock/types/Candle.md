# Stock.Candle

[Extended type](../../../core/types.md#extended-types) of the [**Stock**](../README.md) standard, derived from [**Object**](../../core/types/Object.md).

## Description

One candle of a chart: prices of a market instrument within one period of time.

## Attributes

| Key | Type | Required | Description |
| :-- | :--: | :------: | :---------- |
| `open` | `Number` | yes | First price of the period. |
| `high` | `Number` | yes | Highest price of the period. |
| `low` | `Number` | yes | Lowest price of the period. |
| `close` | `Number` | yes | Last price of the period. |
| `volume` | `Number` / `Null` | no | Traded volume of the period. `null` if unknown. |
| `time` | `Number` / `Null` | no | Start of the period: Unix time in milliseconds, UTC. `null` if unknown. |

A candle always has all six keys: an attribute that is not required is `null` when it is not given.

Rules:

- `high` is greater than or equal to `open`, `close` and `low`.
- `low` is lower than or equal to `open`, `close` and `high`.
- `volume`, if it is not `null`, is not negative.

## Creation

Candles are created with [`CANDLE`](../functions/CANDLE.md) or provided by the host application in the `CANDLES` constant of the [Stock Context](../README.md#stock-context).

## Access

Attributes are accessed like the values of any **Object**, with [`GET`](../../core/functions/GET.md): `$candle.close`, `CANDLES[I].high`.

## Serialization

Serialized like an **Object**. With `include_object_class` set to `true`, the class notation is `[Stock.Candle]`:

```js
[Stock.Candle] { open: 1000, high: 1200, low: 800, close: 1000, volume: null, time: null }
```

## Related functions

- [`CANDLE`](../functions/CANDLE.md)

## Reference

- [Stock types](README.md)
- [Inheritance](../../../semantics/inheritance.md)
- [Serialization](../../core/semantics/serialization.md#object-values)
