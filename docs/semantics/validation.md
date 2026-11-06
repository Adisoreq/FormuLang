# Validation

**Validation** is the first stage of the [execution](./execution.md) process, where the formula is validated basing on syntax rules and standard specification.

Validation is a fast, shallow check of the raw input. It does not build tokens or expression trees; its goal is to reject an input that is certain to fail in the later stages, and to report **all** the problems found at once, instead of stopping at the first one.


## Input and output

| | Description |
| :-- | :---------- |
| **Input** | Unprocessed formula text and the [environment](../core/environment.md). |
| **Output** | Array of [errors](../standards/core/errors/README.md), in the order of detection. The array is empty if no problem was found. |

The formula is validated **before** [clean-up](./cleanup.md), so the validator has to recognize comments and text literals on its own.


## Validation scope

| Area | Description |
| :--- | :---------- |
| **Environment integrity** | The environment provides every constant and variable required by the standard, and their types are correct. |
| **Formula text** | The formula consists only of valid symbols, its text literals are correctly closed and escaped, and its delimiters are balanced. |

Validation does not check grammar (operand and operator positions, assignments, lambda parameter lists, object keys, etc.), nor the number and types of function arguments. These rules are verified by [parsing](./parsing.md) and [evaluation](./evaluation.md).


## Result

- If the output array is empty, the execution continues with the [clean-up](./cleanup.md).
- Otherwise, the execution is **aborted** before any other stage is run. The first error of the array becomes the result of the formula, and the whole array is returned to the host application.
- Errors detected by validation always abort the execution, regardless of the `suppress_errors` environment variable.


## Standards

The exact checks are defined by the standards. Every standard in use defines the environment elements it requires, and the checks of its environment are performed in addition to the checks of the **Core** standard.

The algorithm required by the **Core** standard is defined in [Core Validation](../standards/core/semantics/validation.md).


## Reference

- [Execution](./execution.md)
- [Clean-up](./cleanup.md)
- [Environment](../core/environment.md)
- [Core Validation](../standards/core/semantics/validation.md)
- [Core errors](../standards/core/errors/README.md)