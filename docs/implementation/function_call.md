# Function call

Function call is a helper structure used to store reference to the destined function, collections of arguments, and calculation result to execute and access in optimal time during [evaluation](../semantics/evaluation.md).

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
| Expected value | [Delegate](../standards/core/types.md#delegate) referring to named function or anonymous lambda function |
| Constraints | Must be a valid **[Delegate](../standards/core/types.md#delegate)**; cannot be **Undefined** |

Arguments

| Name | Arguments |
| ---- | --------- |
| Description | Collection of argument values passed to the function during [evaluation](../semantics/evaluation.md), matched against the function's [argument collection template](./argument_collection_template.md) |
| Expected value | Ordered list of [primitives](../core/primitives.md) |
| Constraints | Must satisfy at least one of the function's overloads |

Result

| Name | Result |
| ---- | ------ |
| Description | Cached output of the function's computation; populated during the **Computation** step and reused in subsequent references |
| Expected value | Any [primitive](../core/primitives.md) value |
| Constraints | Cannot remain of type **Undefined** after computation |
