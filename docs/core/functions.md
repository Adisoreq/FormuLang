# Functions

Functions are logical blocks, allowing for complex data processing, conditional logic, and mathematical computations.


## Elements

- **Identifier** - Unique name identifying the function (e.g., `ADD`, `IF`).
- **Parameters** - Collection of values passed into function to achieve a desired result. Parameters can be literals, variables, or other functions.
- **Result** - The single value returned by the function after processing the input parameters. Every function must return a value. Any **[value type](types.md)** except **[Undefined](../standards/core/types/Undefined.md)** is allowed as a return type.

## Function types

1. **Based on required parameters**
   - **Fixed parameters**: Function has a strictly defined number of input parameters and their types. Not meeting one of these requirements results in an error. Argument types can vary, but their order is important.
   - **Flexible parameters**: Function accepts an entire argument collection, regardless of its quantity, but all arguments must have the same type. Used when the parameters' order is not important.

2. **Based on definition source**
   - **Native function** - Pre-defined functions available globally in the environment, implemented natively by the parser.
   - **Lambda function** - Anonymous, temporary functions defined inline by the user for specific operations, usually for transforming the arguments into other form.
   - **Procedure** - Static **Void**/**Error** type function that executes a specified operation on environment and context.

## Named and anonymous functions

Native functions and procedures are **named** functions; lambda functions are **anonymous**. They differ in how a call is resolved and in how the result is produced.

| | Named function (native function, procedure) | Anonymous function (lambda) |
| :-- | :------------------------------------------ | :-------------------------- |
| Identifier | Unique [identifier](../syntax/naming.md), used to call the function | None; created inline by a [lambda expression](../syntax/functions.md#lambda-function-expression) and usually passed as a [Delegate](../standards/core/types/Delegate.md) argument |
| Parameters | Described by [argument collection templates](../implementation/argument_collection_template.md): count, base and extended types, optional and multiple arguments | A plain list of parameter names without types; the function is indirectly typed |
| Overloads | One or more. Arguments are matched against the overloads in order, and the first matching overload is executed | None; there is nothing to match |
| Call resolution | If no overload matches, the function is not executed and the call resolves to the leftmost **Error** argument or to `ARGUMENT_ERROR` (see [Evaluation](../semantics/evaluation.md#3-function-call)) | No overloads. The number of arguments must equal the number of parameters, otherwise the call resolves to `ARGUMENT_ERROR`; argument types are not validated (see [lambda invocation](../semantics/evaluation.md#lambda-invocation)) |
| Parsing | The call expression is parsed together with the sequence it belongs to | The body is parsed once, autonomously, into a stored [lambda tree](../semantics/parsing.md#lambda-trees); parameters are unresolved leaves |
| Result | The value computed by the matched overload | The value of the lambda body, returned directly. Invocation only evaluates the stored tree with the arguments bound to the parameter leaves; its type is the type of the resulting value |
| Scope | Available globally in the environment | Parameters exist only inside the lambda body and only for the duration of the call |

Both kinds are invoked through a [function call](../implementation/function_call.md) structure.

## Principles

- **Autonomy**: Every operation performed by a function is based entirely on the provided arguments. Executing the function under different, unrelated conditions doesn't affect its functionality.
- **Determinism**: Function's result is unequivocally determined by it's parameters. Calling the function with the same input results in receiving equal output. 
  - The only exceptions are explicitly random-result functions, where the ambiguity is a result of code and hardware, and not **FormuLang** system itself.
- **Hermetization**: Function is only allowed to operate on it's parameters. Changing state of external values by a function is prohibited.
  - The only exceptions are **procedures** (e.g. `SET`), whose purpose is to modify the environment or the context.
- **Transience**: State of the performed operation exists only for the time of it's execution, and is disposed after it finishes it's task.

## Reference
- [Primitives](primitives.md)
- [Types](types.md)
- [Variables](containers.md)
- [Function call](../implementation/function_call.md)
- [Argument collection template](../implementation/argument_collection_template.md)
- [Functions syntax](../syntax/functions.md)