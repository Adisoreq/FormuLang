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
- Since `core-1.3`, comparisons with `null` give `false`, arithmetic with `null` gives `null`, and a key of `null` is `null`. See [Missing values](../README.md#missing-values).

## Related functions

- [`ISNULL`](../functions/ISNULL.md), [`IFNULL`](../functions/IFNULL.md)
- [`GET`](../functions/GET.md) with a `fallback`

## Reference

- [Core types](README.md)
- [Literals](../../../syntax/literals.md#1-null)
- [Serialization](../semantics/serialization.md#null-values)
