# Null

**Basic** type of the [**Core**](../README.md) standard.

## Description

Null is a type defining empty, non-existing value.

## Literal

| Form | Meaning |
| :--- | :------ |
| `null` | Compile-time literal expression |
| `NULL` | Pre-initialized environment constant |

## Serialization

| Value | Serialized |
| :---: | :--------: |
| null | `null` |

## Semantics

- Follows **pass-by-value** semantics.
- Not to be mistaken with [**Undefined**](Undefined.md), which represents a declared variable without an assigned value.
- When `suppress_errors` is enabled, an **Error** returned by the root of a sequence is replaced with `null`.

## Related functions

- [`ISNULL`](../functions/ISNULL.md)

## Reference

- [Core types](README.md)
- [Literals](../../../syntax/literals.md#1-null)
- [Serialization](../semantics/serialization.md#null-values)
