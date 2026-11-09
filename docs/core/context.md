# Context

Context is the object containing all data required for the process of executing a single formula.


## Description

The context holds **local variables**, temporary values, and any data specific to the current formula execution and provides isolation between separate formula executions, while allowing optional persistence when required.


## Context kinds

### 1. Disposable context

   - Created during pre-execution and disposed after execution finishes.
   - Use: single formula execution with no retained state.

### 2. Persistent context

   - Copied or passed by reference across multiple executions (e.g., rolling-window calculations, backtesting).
   - Use: accumulate state (counters, caches) between successive executions.


## Context types

A **context type** describes what the host application provides to a formula and what it expects back. Standards define context types, and the host application chooses the context type of every execution.

Every context type specifies:

| Property | Description |
| :------- | :---------- |
| **Name** | Name of the context type, e.g. `Iteration Context`. |
| **Base type** | Context type it derives from. The derived type has every constant of its base type and follows its rules, unless it states otherwise. |
| **Context constants** | Constants that the host application provides, with their types. |
| **Expected result** | Type (or types) of the value the formula should return. A result of another type is handled by the host application, for example by reporting an error. |

A context type cannot remove or change the type of a constant of its base type. Context constants follow the same rules as [environment](environment.md) constants: they are read-only, and a context variable cannot use their name.

### 1. Default Context

Defined by the [**Core**](../standards/core/README.md) standard. Base of every other context type.

| Property | Value |
| :------- | :---- |
| Base type | - |
| Context constants | none |
| Expected result | any value |
| Kind | Disposable |

### 2. Iteration Context

Defined by the [**Core**](../standards/core/README.md) standard. The host application executes the same formula once for every element of a collection (e.g. every candle of a chart). Each run is an **iteration**.

| Property | Value |
| :------- | :---- |
| Base type | Default Context |
| Context constants | `I`, `N`, `PREV` |
| Expected result | any value |
| Kind | Persistent (only through `PREV`) |

| Constant | Type | Description |
| :------- | :--: | :---------- |
| `I` | `Number` | Index of the current iteration. |
| `N` | `Number` | Number of iterations (number of elements of the collection). |
| `PREV` | `Any` | Result of the previous iteration. `null` in the first iteration. |

Rules:

- The iterations are executed in order. The first iteration has the index `@array_indexing`, the last one `@array_indexing + N - 1`. `I` is computed at the moment it is read from the current value of `@array_indexing`, so `array[I]` always points to the element of the current iteration, even if the formula overrides `@array_indexing`.
- `N` does not depend on `@array_indexing`.
- Every iteration starts with no context variables and with the environment variables of the environment. Context variables and overridden environment variables are not kept between iterations. The only state passed from one iteration to the next is `PREV`.
- If an iteration results in an **Error**, the host application decides whether the remaining iterations are executed.


## Lifecycle

1. Pre-execution
   - Initializing the context with environment-supplied data.
2. Execution
   - Reading/modifying context **variables** and **constants**.
   - Applying temporary **environment** parameters.
3. Post-execution
   - **Disposable**: freeing resources.
   - **Persistent**: returning or storing context for next execution.


## Reference

- [Containers](containers.md)
- [Environment](environment.md)
- [Execution](../semantics/execution.md)
- [Core standard](../standards/core/README.md#context-structure)
