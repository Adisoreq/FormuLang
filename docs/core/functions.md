# Functions

Functions are logical blocks, allowing for complex data processing, conditional logic, and mathematical computations.

## Elements
- **Identifier** - Unique name identifying the function (e.g., `ADD`, `IF`).
- **Parameters** - Collection of values passed into function to achieve a desired result. Parameters can be literals, variables, or other functions.
- **Result** - The single value returned by the function after processing the input parameters. Every function must return a value. Any **[value type](types.md)** except **[Undefined](types.md#5-undefined)** is allowed as a return type.

## Function types

1. **Based on required parameters**
   - **Fixed parameters**: Function has a strictly defined number of input parameters and their types. Not meeting one of these requirements results in an error. Argument types can vary, but their order is important.
   - **Flexible parameters**: Function accepts an entire argument collection, regardless of its quantity, but all arguments must have the same type. Used when the parameters' order is not important.
2. **Based on funtionallity**:
   - **Void function** - returns a **Null** value.
   - **Logic function** - returns a **Boolean** value.
   - **Arithmetic function** - calculates **Number** values.
   - **Text function** - operates on **Text** values.
   - **Error function** - invokes an error.
   - **Complex function** - operates on **complex** objects.
3. **Based on definition source**
   - **Native function** - Pre-defined functions available globally in the environment, implemented natively by the parser.
   - **Lambda function** - Anonymous, temporary functions defined inline by the user for specific operations, usually for transforming the arguments into other form.
   - **Procedure** - Static **Void**/**Error** type function that executes a specified operation on environment and context.

## Principles
- **Autonomy**: Every operation performed by a function is based entirely on the provided arguments. Executing the function under different, unrelated conditions doesn't affect its functionality.
- **Determinism**: Function's result is unequivocally determined by it's parameters. Calling the function with the same input results in receiving equal output. 
  - The only exceptions are explicitly random-result functions, where the ambiguity is a result of code and hardware, and not **FormuLang** system itself.
- **Hermetization**: Function is only allowed to operate on it's parameters. Changing state of external values by a function is prohibited.
- **Transience**: State of the performed operation exists only for the time of it's execution, and is disposed after it finishes it's task.

## Reference
- [Primitives](primitives.md)
- [Types](types.md)
- [Variables](variables.md)