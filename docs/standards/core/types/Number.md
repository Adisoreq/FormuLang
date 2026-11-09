# Number

**Basic** type of the [**Core**](../README.md) standard.

## Description

Number is a type defining a real number in decimal format.

## Literal

Supported notations: integer (`42`), separated integer (`1_000_000`), fraction (`12.5`), abbreviated fraction (`.45`, `1.`), scientific notation (`1.2E+3`) and hexadecimal integer (`0xFF`).

Number literals do not include a sign; negation is resolved by the parser (see [`NEG`](../functions/NEG.md)).

## Serialization

Controlled by the `decimal_place` serialization parameter.

| Value | decimal_place | Serialized |
| :---: | :-----------: | :--------: |
| 64 | -1 | `64` |
| -12.0 | -1 | `-12` |
| 1.451 | 2 | `1.45` |
| 1.451 | 4 | `1.4510` |

## Semantics

- Follows **pass-by-value** semantics.
- Arithmetic is performed by the [arithmetic functions](../functions/README.md#1-arithmetic-functions).

## Related functions

- [`ISNUM`](../functions/ISNUM.md)
- [`NUMBER`](../functions/NUMBER.md)
- [Arithmetic functions](../functions/README.md#1-arithmetic-functions)
- [Trigonometric functions](../functions/README.md#8-trigonometric-functions)

## Reference

- [Core types](README.md)
- [Literals](../../../syntax/literals.md#3-number)
- [Serialization](../semantics/serialization.md#number-values)
