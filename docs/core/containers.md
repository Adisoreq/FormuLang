# Containers

Value containers are named primitives that store and manage values during formula execution. They provide a way to reference, update, and organize data in **FormuLang** scripts.

## Variables

Variables are mutable value containers, declared and modified within the process of formula execution.

- **Declaration:** Variables are created by using the `$` sigil followed by an identifier. They can be declared implicitly by assignment.
  - Example: `$x = 10`
- **Assignment:** Values can be assigned or updated using the `=` operator.
  - Example: `$result = ADD($a, $b)`
- **Default value:** If declared without assignment, variables are [**Undefined**](../standards/core/types/Undefined.md): they have no value until the first assignment.
  - Example: the sequence `$y` declares `$y` with no value. Reading `$y` before an assignment results in `UNDEFINED_ERROR`.
- **Type:** Variables can store any value type defined in [Types](types.md).

## Constants

Constants are immutable value containers, predefined and bound to a specific context or environment.

- **Declaration:** Constants are typically defined in the environment or as part of the language specification.
  - Example: `PI`, `TRUE`, `NULL`
- **Immutability:** Their value cannot be changed during formula execution.
- **Type:** Constants can represent any value type.

## Container scopes

| Scope | Sigil | Description | Example |
| :---- | :---: | :---------- | :------ |
| Context | `$` | Accessible within the scope of a [context](./context.md). Used to define temporary variables used in formula [execution](../semantics/execution.md) process. | `$sum = 0` |
| Environment | `@` | Accessible within the scope of the [environment](./environment.md). Used to configure global parameters. | `@suppress_errors = TRUE` |

> **Note:** Context variables are local to a single formula execution, while environment variables/constants are global and persist across executions.

> **Note:** A variable is always written with its sigil (`$name`, `@name`), both when it is assigned and when its value is read. An identifier without a sigil is never a variable: it names a constant (`PI`), a function or procedure (`SUM`, `SET`), a lambda parameter (`(x) => POW(x, 2)`), or an object key (`$obj.key`, `{ key: 1 }`). See [Operator Parsing](../semantics/operator-parsing.md#parser-roles).

## Reference

- [Primitives](primitives.md)
- [Types](types.md)
- [Naming](../syntax/naming.md)
- [Context](./context.md)
- [Environment](./environment.md)
- [Execution](../semantics/execution.md)