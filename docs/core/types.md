# Types

Type is a primitive attribute that determines how a value is interpreted and computed by the **FormuLang** parser.

Types are divided into two categories: **Base** and **Extended**.

## Base types

Base types are the built-in types available in every **FormuLang** implementation. They include basic scalar types (e.g. `Null`, `Undefined`, `Boolean`, `Number`) and complex composite types (e.g. `Array`, `Object`).

Examples: `Boolean`, `Number`, `Text`

## Extended types

Extended types are types [derived](../semantics/inheritance.md) from the **Object** type, introduced by extension standards to model domain-specific structures.

### Extended type naming

Name of the extended type consists of 2 identifiers, separated by dot (`.`):

- **Standard name** - identifier of the standard or extension implementing the type.
- **Type name** - identifier of the type itself

Examples: `Geometry.Point2D`, `Stock.Candle`

## Reference

- [Primitive](primitives.md)
- [Inheritance](../semantics/inheritance.md)
- [Object](../standards/core/types/Object.md)