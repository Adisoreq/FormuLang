# INIT

Context and environment [**Core**](../README.md) standard procedure. Initializes a variable only if it does not exist yet or has no value.

Operator form: `$variable := value` and `@variable := value`.

## Overloads

### Overload 1: Context variable

Signature: `INIT(variable <$Variable>, value <Any>)`

| # | Name | Description |
| - | :--: | :---------- |
| 1 | variable | Context variable (`$` sigil). |
| 2 | value | Value to be stored if the variable does not exist or has no value. Cannot be an **Error**. |

Behavior:

- If the variable does not exist, it is created and the value is stored, exactly as [`SET`](SET.md) does.
- If the variable is declared but has no value (**Undefined**), the value is stored, exactly as [`SET`](SET.md) does.
- If the variable already has a value, nothing is changed.

Errors:

- [`INVALID_IDENTIFIER_ERROR`](../errors/INVALID_IDENTIFIER_ERROR.md) - the variable doesn't exist and its name is already used by an environment variable or constant.

### Overload 2: Environment variable

Signature: `INIT(variable <@Variable>, value <Any>)`

| # | Name | Description |
| - | :--: | :---------- |
| 1 | variable | Environment variable (`@` sigil). |
| 2 | value | Value to be stored if the variable does not exist. Cannot be an **Error**. |

Behavior:

- If the variable is defined in the environment, nothing is changed.
- Environment variables cannot be created by a formula, so if the variable is not defined, the procedure behaves like [`SET`](SET.md) and fails.

Errors:

- [`ENVIRONMENT_ERROR`](../errors/ENVIRONMENT_ERROR.md) - the variable is not defined in the environment.

The value argument is evaluated in both overloads; `INIT` only decides whether it is stored.

## Result

[`SUCCESS`](../errors/SUCCESS.md) **Error**, also when nothing was changed.

## Examples

| Formula | Result | State after execution |
| :------ | :----- | :-------------------- |
| `INIT $count 0` | `SUCCESS` | `$count` is `0` |
| `$count := 0` | `SUCCESS` | `$count` is `0` |
| `$count = 5` <br> `$count := 0` | `SUCCESS` | `$count` is still `5` |
| `$count` <br> `$count := 0` | `SUCCESS` | `$count` is `0` (it had no value) |
| `@array_indexing := 1` | `SUCCESS` | `@array_indexing` is unchanged |
| `@x := 1` | `[ENVIRONMENT_ERROR (10)] Environment variable "x" is not defined.` | - |

Typical use: a persistent context can be executed many times, and the counter has to be created only in the first execution.

## Reference

- [Core procedures](README.md)
- [`SET`](SET.md)
- [`COND_SET`](COND_SET.md)
- [Context](../../../core/context.md)
