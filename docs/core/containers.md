# Containers

Value containers are named primitives that store and manage values during formula evaluation. They provide a way to reference, update, and organize data in **FormuLang** scripts.

## Variables

Variables are mutable value containers, declared and modified within the process of formula evaluation.

- **Declaration:** Variables are created by using the `$` sigil followed by an identifier. They can be declared implicitly by assignment.
  - Example: `$x = 10`
- **Assignment:** Values can be assigned or updated using the `=` operator.
  - Example: `$result = ADD(a, b)`
- **Default value:** If declared without assignment, variables are initialized as `undefined`.
  - Example: `$y` is equivalent to `$y = undefined`
- **Type:** Variables can store any value type defined in [Types](types.md).

## Constants

Constants are immutable value containers, predefined and bound to a specific context or environment.

- **Declaration:** Constants are typically defined in the environment or as part of the language specification.
  - Example: `PI`, `TRUE`, `NULL`
- **Immutability:** Their value cannot be changed during formula evaluation.
- **Type:** Constants can represent any value type.

## Container scopes

| Scope | Sigil | Description | Example |
| :---- | :---: | :---------- | :------ |
| Context | `$` | Accessible within the scope of a [context](./context.md). Used to define temporary variables used in formula [evaluation](../semantics/evaluation.md) process. | `$sum = 0` |
| Environment | `@` | Accessible within the scope of the [environment](./environment.md). Used to configure global parameters. | `@suppress_errors = TRUE` |

> **Note:** Context variables are local to a single formula evaluation, while environment variables/constants are global and persist across evaluations.

## Reference

- [Primitives](primitives.md)
- [Types](types.md)
- [Naming](../syntax/naming.md)
- [Context](./context.md)
- [Environment](./environment.md)
- [Evaluation](../semantics/evaluation.md)