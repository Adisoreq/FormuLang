# Pre-execution

Pre-execution is the process of gathering all data required to execute a formula from the [**environment**](../core/environment.md) and assembling it into a [**context**](../core/context.md). It runs before the [execution](./execution.md) pipeline starts.


## Steps

1. The hosting application creates a new context (or reuses an existing [persistent context](../core/context.md#context-types)) and adds a reference to the environment.
2. The context loads its required parameters and constants depending on its type. The `NOW` constant of the [**Core**](../standards/core/README.md#1-environment-constants) standard is set to the current time in this step, once for the whole execution: reading it twice in one formula gives the same value. In an [Iteration Context](../core/context.md#2-iteration-context), `NOW` is set once before the first iteration and is the same in all iterations, so the results do not depend on how long the iterations take. In a [Time Context](../core/context.md#3-time-context), `NOW` is set again for every frame.
3. The environment copies its default variables into the context, so the formula may modify them within a single execution without affecting the environment. Only variables that the context does not already contain are copied, so the state accumulated in a reused [persistent context](../core/context.md#context-types) is never overwritten. Copied variables are disposed together with a [disposable context](../core/context.md#context-types).

The environment itself is never modified by the formula: it only provides the defaults that are copied into each context.


## Position in the pipeline

Pre-execution is the first part of the full pipeline and always precedes the [execution](./execution.md) steps, including [validation](./validation.md):

**Pre-execution** → **Execution** (validation → ... → finalization) → **[Post-execution](./post-execution.md)**


## Reference

- [Context](../core/context.md)
- [Environment](../core/environment.md)
- [Execution](./execution.md)
