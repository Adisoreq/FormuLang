# Environment

The **environment** is an abstraction layer between **FormuLang** and the parsing program, providing all necessary data, constants, and parameters required for formula execution.


## Description

- The environment stores **global constants**, **configuration parameters**, and **environment variables**.
- Environment variables and constants are accessible to all formula executions. Their default values persist between executions, because every execution works on a copy of them stored in its [context](context.md) (see [pre-execution](../semantics/pre-execution.md)).
- The environment is initialized by the host application and can be used to inject external data or settings.
- Environment constants and variables that affect the process of formula execution must be specified in the standard documentation.
- The environment is read-only during formula execution. Overriding a variable inside a formula changes only its copy in the context.


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

You can temporarily override environment parameters inside a formula to change execution behavior for a single execution.

```
@array_indexing = 1
```

> [!NOTE] 
> Overriding environment variables inside a formula only affects the current execution context and does not persist globally.


## Example

```
$standards = JOIN(STANDARDS, ", ")
CONCAT("Supported standards: ", $standards)
```
Result:
```
Supported standards: core-0.3
```


## Reference

- [Containers](containers.md)
- [Context](context.md)
- [Execution](../semantics/execution.md)
- [Environment examples](../standards/core/examples/environment_examples.md)