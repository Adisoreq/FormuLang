# COND_SET

Context and environment [**Core**](../README.md) standard procedure. Overrides a variable only if it already exists.

Operator form: `$variable ?= value` and `@variable ?= value`.

## Overloads

### Overload 1: Context variable

Signature: `COND_SET(variable <$Variable>, value <Any>)`

| # | Name | Description |
| - | :--: | :---------- |
| 1 | variable | Context variable (`$` sigil). |
| 2 | value | Value to be stored if the variable exists. Cannot be an **Error**. |

Behavior:

- If the variable exists (it is declared, even if its value is **Undefined**), its value is replaced exactly as [`SET`](SET.md) does, including the type rule.
- If the variable does not exist, nothing is changed and the variable is **not** created.

Errors:

- [`TYPE_ERROR`](../errors/TYPE_ERROR.md) - the variable holds a non-**Undefined** value of another base type.

### Overload 2: Environment variable

Signature: `COND_SET(variable <@Variable>, value <Any>)`

| # | Name | Description |
| - | :--: | :---------- |
| 1 | variable | Environment variable (`@` sigil). |
| 2 | value | Value to be stored if the variable is defined. Cannot be an **Error**. |

Behavior:

- If the variable is defined in the environment, its value is replaced for the current execution only, exactly as [`SET`](SET.md) does, including the type rule.
- If the variable is not defined, nothing is changed. Unlike [`SET`](SET.md), this is not an error.

Errors:

- [`TYPE_ERROR`](../errors/TYPE_ERROR.md) - the base type of the new value differs from the base type of the stored one.

The value argument is evaluated in both overloads; `COND_SET` only decides whether it is stored.

## Result

[`SUCCESS`](../errors/SUCCESS.md) **Error**, also when nothing was changed.

## Examples

| Formula | Result | State after execution |
| :------ | :----- | :-------------------- |
| `$x = 1` <br> `COND_SET $x 2` | `SUCCESS` | `$x` is `2` |
| `$x = 1` <br> `$x ?= 2` | `SUCCESS` | `$x` is `2` |
| `$x ?= 2` | `SUCCESS` | `$x` does not exist |
| `$x = 1` <br> `$x ?= "text"` | `[TYPE_ERROR (4)] Trying to override NUMBER value with TEXT.` | `$x` is `1` |
| `@array_indexing ?= 1` | `SUCCESS` | `@array_indexing` is `1` until the end of the execution |
| `@x ?= 1` | `SUCCESS` | the environment is unchanged |

## Reference

- [Core procedures](README.md)
- [`SET`](SET.md)
- [`INIT`](INIT.md)
- [Context](../../../core/context.md)
