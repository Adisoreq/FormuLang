# Post-execution

Post-execution is the process that follows the [execution](./execution.md) steps. The hosting application extracts the result and the [context](../core/context.md) is either released or kept for the next execution.


## Steps

1. The hosting application receives the result returned by [finalization](./finalization.md) (or the array of errors if the execution was aborted by [validation](./validation.md)) and uses it.
2. The context is handled depending on its [type](../core/context.md#context-types):
   - **Disposable** - the context is disposed together with all variables copied from the [environment](../core/environment.md) during [pre-execution](./pre-execution.md).
   - **Persistent** - the context is returned to the host application, which may store it and pass it to the next execution.

The environment is not changed by post-execution.


## Reference

- [Context](../core/context.md)
- [Environment](../core/environment.md)
- [Execution](./execution.md)
- [Pre-execution](./pre-execution.md)
- [Finalization](./finalization.md)
