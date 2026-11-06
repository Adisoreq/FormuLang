# Core/Types

[Base types](../../../core/types.md#base-types) implemented by the **Core** standard, divided into **Basic** and **Complex** categories.

**Core** standard doesn't specify any [extended types](../../../core/types.md#extended-types).


## Basic types

Basic types hold a single value that cannot be divided into parts.
They follow **pass-by-value** semantics: the data is copied on assignment and when it is passed to a function.

| Type | Description | Type function |
| :--- | :---------- | :-----------: |
| [`Null`](Null.md) | Empty, non-existing value. | [`ISNULL`](../functions/ISNULL.md) |
| [`Boolean`](Boolean.md) | Logic value: `true` or `false`. | [`ISBOOL`](../functions/ISBOOL.md) |
| [`Number`](Number.md) | Real number in decimal format. | [`ISNUM`](../functions/ISNUM.md) |
| [`Text`](Text.md) | Set of characters. | [`ISTEXT`](../functions/ISTEXT.md) |
| [`Undefined`](Undefined.md) | State of a variable declared but not yet assigned a value. Never a value of an expression. | - |


## Complex types

Complex types hold structured data or many values, which can be other complex values (nesting).
They follow **pass-by-reference** semantics, so large arrays and objects are not copied when they are passed to a function.

| Type | Description | Type function |
| :--- | :---------- | :-----------: |
| [`Error`](Error.md) | Name, code and details of a failed operation. | [`ISERR`](../functions/ISERR.md) |
| [`Array`](Array.md) | Ordered collection of values, accessed via index. | [`ISARR`](../functions/ISARR.md) |
| [`Object`](Object.md) | Structure of named values, accessed via key. | [`ISOBJ`](../functions/ISOBJ.md) |
| [`Delegate`](Delegate.md) | Reference to a named function or an anonymous lambda. | [`ISDEL`](../functions/ISDEL.md) |


## Reference

- [Core standard](../README.md)
- [Core functions](../functions/README.md)
- [Core errors](../errors/README.md)
- [Base types](/docs/core/types.md)
- [Extended types](/docs/core/types.md#extended-types)
- [Functions](/docs/core/functions.md)
- [Symbols](/docs/syntax/symbols.md)
