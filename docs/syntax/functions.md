# Functions syntax

Functions are invoked using their unique identifier followed by **parentheses** (`()`) containing a **comma-separated** (`,`) list of arguments.

## Calling functions

| Arguments | Function call expression | Example |
| --------- | ------------------------ | ------- |
| No arguments | Function identifier + parentheses | `RAND()` |
| Single argument | Function identifier + parentheses + argument expression | `ABS(-10)` |
| Multiple arguments | Function identifier + parentheses + argument expressions separated by **comma (`,`)** | `LERP(1, $x, 0.5)` |

## Naming Convention

Named functions should use [screaming snake case](./naming.md#2-screaming-snake-case) identifiers.

### Example:

`ABS`, `SQRT`, `ATAN2`, `STDEV_P`

## Lambda function expression

Lambda expressions allow defining anonymous functions inline, primarily used as arguments for higher-order functions like `MAP` or `FILTER`.

Unlike [named functions](../core/functions.md#named-and-anonymous-functions), a lambda function has no identifier and no overloads. Its body is parsed once, and each invocation only evaluates the stored tree: the arguments are bound to the parameters (their number must match, otherwise the call resolves to `ARGUMENT_ERROR`) and the value of the body is returned as the result.

### Syntax
- **Parameters**: A comma-separated list of identifiers in parentheses. Parameters have no types and are visible only inside the body.
- **Operator**: `=>` symbol separating parameters from the body.
- **Body**: An expression that determines the return value.

### Example

Single parameter:
```
(x) => POW(x, 2)
```

Multiple parameters:
```
(param1, param2) => DIV(ADD(param1, param2), 2)
```

## Reference
- [Symbols](symbols.md)
- [Functions](../core/functions.md)
- [Naming](./naming.md)