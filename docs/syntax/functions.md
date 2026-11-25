# Functions syntax

Functions are invoked using their unique identifier followed by **parentheses** (`()`) containing a **comma-separated** (`,`) list of arguments.

## Calling functions

| Arguments | Function call expression | Example |
| --------- | ------------------------ | ------- |
| No arguments | Function identifier + parentheses | `RAND()` |
| Single argument | Function identifier + parentheses + argument expression | `ABS(-10)` |
| Multiple arguments | Function identifier + parentheses + argument expressions separated by **comma (`,`)** | `LERP(1, $x, 0.5)` |

## Calling delegates

A [Delegate](../standards/core/types/Delegate.md), e.g. a lambda stored in a variable or received as a lambda parameter, is called by writing the arguments in parentheses after it. The call is equivalent to the [CALL](../standards/core/functions/CALL.md) function.

| Call | Example | Equivalent |
| :--- | :------ | :--------- |
| Delegate in a variable | `$double = (x) => x * 2` <br> `$double(4)` | `CALL($double, 4)` |
| Lambda parameter | `$apply = (f, x) => f(x)` <br> `$apply(ABS, -3)` | `CALL(f, x)` |
| Delegate in an object or array | `$ops = { inc: (x) => x + 1 }` <br> `$ops.inc(1)` | `CALL($ops.inc, 1)` |
| Lambda expression | `((x) => x * 2)(4)` | `CALL((x) => x * 2, 4)` |

A named function can be stored in a variable and called the same way: `$f = ABS` then `$f(-3)`. A value that is not a **Delegate** cannot be called (`ARGUMENT_ERROR`). Calls of lambdas nested in each other are limited to a [depth of 256](../semantics/evaluation.md#invocation-depth).

## Naming Convention

Named functions should use [screaming snake case](./naming.md#2-screaming-snake-case) identifiers.

### Example:

`ABS`, `SQRT`, `ATAN2`, `STDEV_P`

## Lambda function expression

Lambda expressions allow defining anonymous functions inline, primarily used as arguments for higher-order functions like `MAP` or `FILTER`, or stored in a variable and [called](#calling-delegates) like a function.

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