# Standards

**FormuLang** standards make sure that different applications execute the same formula in the same way.
Every standard defines the structure of the **environment** and the **context**, its built-in functions, procedures, types and errors.

## Standard list

Core standard

| Name | Latest version | Description |
| :--- | :------------: | :---------- |
| `core` | `1.0` | Basic mathematical, logical, text and array operations. Basis of every other extension. [[Read more]](./core/README.md) |

Extension standards

| Name | Latest version | Requires | Description |
| :--- | :------------: | :------: | :---------- |
| `stock` | `1.0` | `core-1+` | Market data: candles, technical indicators, candle patterns and trading strategies. [[Read more]](./stock/README.md) |

## Dependency tree

An arrow points from a standard to the standard it requires, with the required versions ([`REQUIRE`](core/procedures/REQUIRE.md) format). A standard has every element of the standards it requires: e.g. the Stock context types derive from the Core Iteration Context.

```mermaid
graph BT
    core["core-1.0"]
    stock["stock-1.0"]

    stock -- "core-1+" --> core
```

```
core-1.0
└── stock-1.0      (requires core-1+)
```

## Reference
- [Context](../core/context.md)
- [Environment](../core/environment.md)
