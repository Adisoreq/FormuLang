# Function call

Function call is a helper structure used to store reference to the destined function, collections of arguments, and calculation result to execute and access in optimal time during [execution](../semantics/execution.md).

## Structure

### Overview

| Property | Description |
| :------- | :---------- |
| Function | Reference to the called function |
| Arguments | Collection of argument values |
| Result | Result of the function's computation |

### Properties

Function

| Name | Function |
| ---- | -------- |
| Description | Reference to the function to be executed |
| Expected value | [Delegate](../standards/core/types/Delegate.md) referring to named function or anonymous lambda function |
| Constraints | Must be a valid **[Delegate](../standards/core/types/Delegate.md)**; cannot be **Undefined** |

Arguments

| Name | Arguments |
| ---- | --------- |
| Description | Collection of argument values passed to the function during [execution](../semantics/execution.md); for a named function matched against its [argument collection template](./argument_collection_template.md), for a lambda function bound directly to its parameters (the number of arguments must equal the number of parameters) |
| Expected value | Ordered list of [primitives](../core/primitives.md) |
| Constraints | Named function: must satisfy at least one of the function's overloads. Lambda function: no overloads; argument types are not validated, only the argument count is checked |

Result

| Name | Result |
| ---- | ------ |
| Description | Cached output of the function's computation (the matched overload's result for a named function, the value of the body for a lambda function); populated during the **Evaluation** step and reused in subsequent references |
| Expected value | Any [primitive](../core/primitives.md) value |
| Constraints | Cannot remain of type **Undefined** after evaluation |
