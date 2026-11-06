# Core/Errors

Errors implemented by [**Core**](../README.md) standard.


## Error list

| Code | Name | Description |
| :--: | :--- | :---------- |
| 0 | [`SUCCESS`](SUCCESS.md) | Operation executed successfully. An **Error** with this code, returned by the root of a sequence, never aborts the execution. |
| 1 | [`CUSTOM_ERROR`](CUSTOM_ERROR.md) | User's custom error invoked by [`ERROR`](../functions/ERROR.md) function. |
| 2 | [`SYNTAX_ERROR`](SYNTAX_ERROR.md) | Evaluated formula breaks the syntax rules. |
| 3 | [`OPERATION_ERROR`](OPERATION_ERROR.md) | Invoked operation or function has failed while executing. An **Error** received as an argument is propagated unchanged instead of being wrapped in this error. |
| 4 | [`TYPE_ERROR`](TYPE_ERROR.md) | Non-**Undefined** value is being overridden with other type. |
| 5 | [`UNKNOWN_SYMBOL_ERROR`](UNKNOWN_SYMBOL_ERROR.md) | A function, a constant or a context variable with non-existent identifier is being used. |
| 6 | [`ARGUMENT_ERROR`](ARGUMENT_ERROR.md) | Function is being invoked with arguments that don't match any of its overloads, or a lambda function is invoked with a number of arguments different from the number of its parameters. |
| 7 | [`INVALID_INDEX_ERROR`](INVALID_INDEX_ERROR.md) | Trying to access an array element with non-existent index. |
| 8 | [`INVALID_KEY_ERROR`](INVALID_KEY_ERROR.md) | Trying to access an object variable with non-existent key. |
| 9 | [`INVALID_IDENTIFIER_ERROR`](INVALID_IDENTIFIER_ERROR.md) | Trying to redefine existing primitive. |
| 10 | [`ENVIRONMENT_ERROR`](ENVIRONMENT_ERROR.md) | Environment doesn't meet the requirements of the standard, or a formula refers to an environment element that doesn't exist. |
| 11 | [`NOT_SUPPORTED_ERROR`](NOT_SUPPORTED_ERROR.md) | The environment doesn't meet the requirements of a standard returned by the [`REQUIRE`](../procedures/REQUIRE.md) procedure. |
| 12 | [`UNDEFINED_ERROR`](UNDEFINED_ERROR.md) | A context variable that is declared but has no value ([**Undefined**](../types/Undefined.md)) is being read. |


## Handling

An **Error** is a regular value that can be passed to functions. The execution is aborted only when the root of a sequence returns an **Error** with a code other than `SUCCESS`; the **Error** becomes the result of the formula. If `suppress_errors` is **true**, it is replaced with `null` and the execution continues. Syntax errors always abort the execution. Errors detected by [validation](../semantics/validation.md) always abort it too. Details: [Evaluation](../../../semantics/evaluation.md#5-sequence-result).


## Reference

- [Core standard](../README.md)
- [Core functions](../functions/README.md)
- [Core types](../types/README.md)
- [Error type](../types/Error.md)