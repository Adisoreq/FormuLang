# Error

**Complex** type of the [**Core**](../README.md) standard.

## Description

**Error** consists of a unique **Text** name, a unique **Number** code, and a **Text**-based details field. An **Error** value aborts the execution by default when it is the result of the root expression of a sequence (unless its code is `SUCCESS`). Inside an expression it is an ordinary value that is propagated by function calls or can be handled, e.g. with [`ISERR`](../functions/ISERR.md).

Errors are used to inform about incorrect syntax, execution fails, hardware limitations, and prevent parser from working until formula gets corrected.

> [!IMPORTANT]
> Invoking error isn't meant to cause throwing an error or exception by the compiler or debugger. It's supposed to return a feedback about errors, and stop the execution to let user or programmer apply changes.

## Structure

| Field | Type | Description |
| :---- | :--- | :---------- |
| Name | `Text` | Unique name of the error, e.g. `CUSTOM_ERROR`. |
| Code | `Number` | Unique code of the error, e.g. `1`. |
| Details | `Text` | Description of the particular occurrence. |

The list of errors defined by the standard: [Core errors](../errors/README.md).

## Literal

- **Manual** - created with the [`ERROR`](../functions/ERROR.md) function, e.g. `ERROR("Array is empty!")`.
- **Automatic** - created by the parser when a formula has incorrect syntax or bugged semantics.

## Serialization

Pattern: `[<ERROR_NAME> (<ERROR_CODE>)] <ERROR_DESCRIPTION>`

| Name | Code | Details | Serialized |
| :--- | :--: | :------ | :--------- |
| `CUSTOM_ERROR` | `1` | `You've reached a breakpoint.` | `[CUSTOM_ERROR (1)] You've reached a breakpoint.` |

## Semantics

- Follows **pass-by-value** semantics.
- An **Error** received as an argument by a function that has no matching overload is propagated unchanged.
- The execution is aborted only when the root of a sequence returns an **Error** with a code other than `SUCCESS`. See [Evaluation](../../../semantics/evaluation.md#5-sequence-result).

## Related functions

- [`ISERR`](../functions/ISERR.md)
- [`ERROR`](../functions/ERROR.md)

## Reference

- [Core types](README.md)
- [Core errors](../errors/README.md)
- [Literals](../../../syntax/literals.md#6-error)
- [Serialization](../semantics/serialization.md#error-values)
