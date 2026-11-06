# Text

**Basic** type of the [**Core**](../README.md) standard.

## Description

Text is a type defining a set of characters, used to process and display text.

## Literal

Text is enclosed in **double quotation marks** (`"`), e.g. `"Hello"`. [Special characters](../../../syntax/symbols.md#symbols-classification) may require [escape sequences](../../../syntax/symbols.md#escape-sequences).

## Serialization

| Value | Serialized |
| :---: | :--------: |
| `This is text value` | `This is text value` |

## Semantics

- Follows **pass-by-value** semantics.
- Can be joined with `ADD` (the `+` operator) or [`CONCAT`](../functions/CONCAT.md).

## Related functions

- [`ISTEXT`](../functions/ISTEXT.md)
- [Text functions](../functions/README.md#4-text-functions)

## Reference

- [Core types](README.md)
- [Literals](../../../syntax/literals.md#4-text)
- [Serialization](../semantics/serialization.md#text-values)
