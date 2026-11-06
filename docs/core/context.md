# Context

Context is the object containing all data required for the process of executing a single formula.


## Description

The context holds **local variables**, temporary values, and any data specific to the current formula execution and provides isolation between separate formula executions, while allowing optional persistence when required.


## Context types

### 1. Disposable context

   - Created during pre-execution and disposed after execution finishes.
   - Use: single formula execution with no retained state.

### 2. Persistent context

   - Copied or passed by reference across multiple executions (e.g., rolling-window calculations, backtesting).
   - Use: accumulate state (counters, caches) between successive executions.

### 2.1. Loop context

   - Special type of **persistent content** that is iterated through elements of the specified array.
   - Stores information about current loop and it's iteration.


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