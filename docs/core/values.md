# Values

A value is a [primitive](primitives.md) consisting of a **[type](types.md)** and **data**. It is a single unit of information. Every operation in **FormuLang** receives values and returns a value.

## Structure

Each value is composed of two components:

| Component | Description |
| :-------- | :---------- |
| **Type** | Governs how the data is interpreted and validated. |
| **Data** | The actual stored information. |

## Semantics

How a value behaves during assignment and when passed between operations is determined by its type category.

### Pass-by-value

Applies to **basic types**: `Null`, `Boolean`, `Number`, `Text`, `Undefined`.

The data is **copied** on assignment or when passed to a function. Changes to the copy have no effect on the original.

### Pass-by-reference

Applies to **complex types**: `Error`, `Array`, `Object`, `Delegate`.

A **reference** to the underlying data is passed rather than a copy, avoiding the overhead of duplicating large structures.

## States

| State | Type | Description |
| :---- | :--- | :---------- |
| **Defined** | Any type except `Undefined` | The value has been assigned and is ready for use. |
| **Undefined** | `Undefined` | The variable has been declared but not yet assigned. It can be assigned a value of any type without error. Reading it results in [`UNDEFINED_ERROR`](../standards/core/errors/UNDEFINED_ERROR.md). This state belongs to variables only; it is never a value of an expression. |
| **Empty** | `Null` | The value has been explicitly set to a non-existing state. |

## Lifetime

Values are **anonymous** primitives: they exist only during the operation that creates or uses them. To retain a value beyond a single operation, it must be stored in a [container](containers.md) (a variable or constant).

## Reference

- [Primitives](primitives.md)
- [Types](types.md)
- [Containers](containers.md)
- [Functions](functions.md)
- [Literals](../syntax/literals.md)
