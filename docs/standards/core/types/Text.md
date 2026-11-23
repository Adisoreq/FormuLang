# Text

**Basic** type of the [**Core**](../README.md) standard.

## Description

Text is a type defining a set of characters, used to process and display text.

## Literal

Text is enclosed in **double quotation marks** (`"`), e.g. `"Hello"`. [Special characters](../../../syntax/symbols.md#symbols-classification) may require [escape sequences](../../../syntax/symbols.md#escape-sequences). A text literal may contain Unicode [text characters](../../../syntax/symbols.md#text-characters), e.g. `"Zażółć gęślą jaźń"`.

## Characters

- A **character** of a text is one Unicode code point. Every text function that counts, finds or reverses characters (`LEN`, `SUBSTR`, `FIND`, `REVERSE`, `SPLIT` with `""`) works on code points: `LEN("żółw")` is `4`.
- Texts are not normalized. Two texts are equal (`EQU`) only if they have the same code points in the same order.
- `UPPERCASE` and `LOWERCASE` follow the Unicode default case mapping, independent of any locale.
- `SORT` compares texts by their code points.

## Serialization

| Value | Serialized |
| :---: | :--------: |
| `This is text value` | `This is text value` |

## Semantics

- Follows **pass-by-value** semantics.
- Can be joined with `ADD` (the `+` operator) or [`CONCAT`](../functions/CONCAT.md).
- Positions of characters (used by [`SUBSTR`](../functions/SUBSTR.md) and [`FIND`](../functions/FIND.md)) follow `@array_indexing`, like array indices.

## Related functions

- [`ISTEXT`](../functions/ISTEXT.md)
- [Text functions](../functions/README.md#4-text-functions)

## Reference

- [Core types](README.md)
- [Literals](../../../syntax/literals.md#4-text)
- [Serialization](../semantics/serialization.md#text-values)
