# Environment

The **environment** is an abstraction layer between **FormuLang** and the parsing program, providing all necessary data, constants, and parameters required for formula evaluation.

## Description

- The environment stores **global constants**, **configuration parameters**, and **environment variables**.
- Environment variables and constants are accessible to all formula evaluations and persist between them.
- The environment is initialized by the host application and can be used to inject external data or settings.
- Environment constants and variables that affect the process of formula evaluation must be specified in the standard documentation.
- Environment values are read-only during formula evaluation unless explicitly overridden.

## Usage

### Declaring environment variables

Environment variables are declared using the `@` sigil followed by an identifier. They are typically set by the host application or configuration files.

```
@suppress_errors = TRUE
@array_indexing = 0
```

### Accessing environment constants

Environment constants (such as `PI`, `TRUE`, `NULL`) are available globally and cannot be modified within formulas.

```
PI
TRUE
NULL
```

### Overriding environment parameters

You can temporarily override environment parameters inside a formula to change evaluation behavior for a single execution.

```
@array_indexing = 1
```

> **Note:** Overriding environment variables inside a formula only affects the current evaluation context and does not persist globally.

## Example

```
$ standards = ARRTOSTR(SUPPORTED_STANDARDS)
CONCAT("Supported standards: ", standards)
```
Result:
```
Supported standards: ["core-1.1.3"]
```

## Reference

- [Containers](containers.md)
- [Context](context.md)
- [Evaluation](../semantics/evaluation.md)
- [Environment examples](../standards/core/examples/environment_examples.md)