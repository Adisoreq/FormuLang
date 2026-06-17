# Primitives

Primitives are the fundamental building blocks of the **FormuLang** system, used in data initialization, evaluation, and validation.

## List of primitives
- **Type** - Attribute that determines how processed values are interpreted and computed. [Read more.](types.md)
- **Value** - Stored data with an assigned type, used as the input and output of every operation. [Read more.](values.md)
- **Value container** - stored value, accessed by it's unique name.
  - **Constant** - A constant, predefined value bound to a specific context. Cannot be modified within the process of evaluating the formula. [Read more.](containers.md)
  - **Variable** - A value declared and modified within the process of formula evaluation. [Read more.](containers.md)
- **Function** - An autonomous block that performs operations based on its input parameters and returns a computed output value. [Read more.](functions.md)
  - **Native functions** - Built-in, various type functions that perform logical and mathematical operations. Accessed via unique name.
  - **Lambda functions** - Temporary, anonymous functions, declared and terminated withing the procees of formula evaluation.
  - **Procedures** - Built-in **Void**/**Error** type functions used to manipulate the environment and the process of parsing the formula.

## Primitives classification

### Hierarchy

| Degree | Primitives | Description |
| :----: | :--------- | :---------- |
| **I** | `Type` | The basis of every other primitive, determining its functionality. |
| **II** | `Value` | Uses **types** to determine how its stored data is interpreted and processed. |
| **III** | `Constant`, `Variable`, `Function` | Use **values** to communicate with the parser and other primitives. |

### Identity

| Type | Primitives | Description |
| :--- | :--------- | :---------- |
| Named | `Constant`, `Variable`, `Native function`, `Procedure` | Long time span primitives accessed via unique [identifier](../syntax/naming.md). |
| Anonymous | `Value`, `Lambda function` | Short time span primitives accessed during initialization. |

## Reference
- [Types](types.md)
- [Values](values.md)
- [Containers](containers.md)
- [Functions](functions.md)
- [Naming](../syntax/naming.md)
