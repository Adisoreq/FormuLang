# Array

**Complex** type of the [**Core**](../README.md) standard.

## Description

Array is a type defining an ordered collection of values, accessed via unique index.

## Literal

| Form | Example |
| :--- | :------ |
| Function call | `ARRAY(1, 2, 3, 4, 5)` |
| Operator expression | `[1, 2, 3, 4, 5]` |

## Access

Elements are accessed with [`GET`](../functions/GET.md) or the `array[index]` operator. The first index depends on the `array_indexing` environment variable. An invalid index results in [`INVALID_INDEX_ERROR`](../errors/INVALID_INDEX_ERROR.md).

## Serialization

Controlled by the `split_array` serialization parameter.

| Value | split_array | Serialized |
| :---: | :---------: | :--------- |
| 1, 2 .. 10 | false | `[1, 2, 3, 4, 5, 6, 7, 8, 9, 10]` |

## Semantics

- Follows **pass-by-reference** semantics.

## Related functions

- [`ISARR`](../functions/ISARR.md)
- [Array & collection functions](../functions/README.md#5-array--collection-functions)

## Reference

- [Core types](README.md)
- [Literals](../../../syntax/literals.md#7-array)
- [Serialization](../semantics/serialization.md#array-values)
