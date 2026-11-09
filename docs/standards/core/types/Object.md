# Object

**Complex** type of the [**Core**](../README.md) standard.

## Description

Object is a complex type defining a structure consisting of multiple variables with arbitrary types, accessed via unique name.

[Extended types](../../../core/types.md#extended-types) are derived from **Object**, which is the root of the type hierarchy.

## Literal

| Form | Example |
| :--- | :------ |
| Operator expression | `{ Param1: 11, Param2: 22 }` |
| Operator expression, quoted keys | `{ "Param1": 11, "Param2": 22 }` |

Both notations are equivalent. Every key must match the [identifier pattern](../../../syntax/naming.md#naming-restrictions) (`^[a-zA-Z_]\w*$`) and be unique within the object (`{ x: 1, "x": 2 }` repeats the key `x`); otherwise creating the object results in a [`SYNTAX_ERROR`](../errors/SYNTAX_ERROR.md).

## Access

Values are accessed with [`GET`](../functions/GET.md) using the `object.key` or `object["key"]` operator. A non-existent key results in [`INVALID_KEY_ERROR`](../errors/INVALID_KEY_ERROR.md).

## Serialization

Controlled by the `split_object` and `include_object_class` serialization parameters. Key-value pairs are separated with `:` and enclosed in curly brackets (`{}`). Keys are always serialized without quotation marks.

## Semantics

- Follows **pass-by-reference** semantics.

## Related functions

- [`ISOBJ`](../functions/ISOBJ.md)
- [`GET`](../functions/GET.md)
- [`KEYS`](../functions/KEYS.md)
- [`HAS`](../functions/HAS.md)

## Reference

- [Core types](README.md)
- [Inheritance](../../../semantics/inheritance.md)
- [Literals](../../../syntax/literals.md#8-object)
- [Serialization](../semantics/serialization.md#object-values)
