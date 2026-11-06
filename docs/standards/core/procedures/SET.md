# SET

Context and environment [**Core**](../README.md) standard procedure. Overrides the value of a variable.

Operator form: `$variable = value` and `@variable = value`.

## Overloads

### Overload 1: Context variable

Signature: `SET(variable <$Variable>, value <Any>)`

| # | Name | Description |
| - | :--: | :---------- |
| 1 | variable | Context variable (`$` sigil). It does not have to exist. |
| 2 | value | Value to be stored. Cannot be an **Error**. |

Behavior:

- If the variable does not exist, it is created and the value is stored.
- If the variable exists, its value is replaced with the new one, provided that the types are compatible: the variable is **Undefined** (it can be overridden by any type) or the base type of the new value is the same as the base type of the stored one.

Errors:

- [`TYPE_ERROR`](../errors/TYPE_ERROR.md) - the variable holds a non-**Undefined** value of another base type.
- [`INVALID_IDENTIFIER_ERROR`](../errors/INVALID_IDENTIFIER_ERROR.md) - the variable doesn't exist and its name is already used by an environment variable or constant.

### Overload 2: Environment variable

Signature: `SET(variable <@Variable>, value <Any>)`

| # | Name | Description |
| - | :--: | :---------- |
| 1 | variable | Environment variable (`@` sigil). It must exist in the environment. |
| 2 | value | Value to be stored. Cannot be an **Error**. |

Behavior:

- The value of the environment variable is replaced with the new one for the current execution only. The environment of the host application is not modified.
- The type rule is the same as for context variables. Environment variables are never **Undefined**, so the base type of the new value must be the same as the base type of the stored one.

Errors:

- [`ENVIRONMENT_ERROR`](../errors/ENVIRONMENT_ERROR.md) - the variable is not defined in the environment. Environment constants are not variables and cannot be changed.
- [`TYPE_ERROR`](../errors/TYPE_ERROR.md) - the base type of the new value differs from the base type of the stored one.

## Result

[`SUCCESS`](../errors/SUCCESS.md) **Error**.

## Examples

| Formula | Result | State after execution |
| :------ | :----- | :-------------------- |
| `SET $x 4.25` | `SUCCESS` | `$x` is `4.25` |
| `$x = 4.25` | `SUCCESS` | `$x` is `4.25` |
| `$x` <br> `$x = 1.2` | `SUCCESS` | `$x` is `1.2` (**Undefined** can be overridden) |
| `$x = TRUE` <br> `$x = 1.2` | `[TYPE_ERROR (4)] Trying to override BOOLEAN value with NUMBER.` | `$x` is `true` |
| `$array_indexing = 1` | `[INVALID_IDENTIFIER_ERROR (9)] "array_indexing" symbol is already defined by environment.` | - |
| `@array_indexing = 1` | `SUCCESS` | `@array_indexing` is `1` until the end of the execution |
| `@x = 1` | `[ENVIRONMENT_ERROR (10)] Environment variable "x" is not defined.` | - |

## Reference

- [Core procedures](README.md)
- [Core standard](../README.md#built-in-procedures)
- [Containers](../../../core/containers.md)
- [Context examples](../examples/context_examples.md)
- [Environment examples](../examples/environment_examples.md)
