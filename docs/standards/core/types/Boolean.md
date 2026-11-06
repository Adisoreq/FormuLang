# Boolean

**Basic** type of the [**Core**](../README.md) standard.

## Description

Boolean is a type of a logic value which oscillates between two states: **positive** (`true`) and **negative** (`false`).

## Literal

| Form | Meaning |
| :--- | :------ |
| `true` / `false` | Compile-time literal expressions |
| `TRUE` / `FALSE` | Pre-initialized environment constants |

## Serialization

| Value | Serialized |
| :---: | :--------: |
| true | `true` |
| false | `false` |

## Semantics

- Follows **pass-by-value** semantics.
- Produced by logic and comparison functions (`AND`, `EQU`, `GRE`, ...) and by the `IS...` type functions.

## Related functions

- [`ISBOOL`](../functions/ISBOOL.md)
- [`BOOL`](../functions/BOOL.md)
- [Logic & comparison functions](../functions/README.md#2-logic--comparison-functions)

## Reference

- [Core types](README.md)
- [Literals](../../../syntax/literals.md#2-boolean)
- [Serialization](../semantics/serialization.md#boolean-values)
