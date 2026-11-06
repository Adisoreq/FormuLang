# NOT_SUPPORTED_ERROR

[**Core**](../README.md) standard error. Code: `11`.

The environment doesn't meet the requirements of a standard requested by the formula.

## Cause

Returned by the [`REQUIRE`](../procedures/REQUIRE.md) procedure when none of the standards listed in the environment constant `STANDARDS` satisfies the requested standard and version.

## Behavior

Like any other **Error**, it aborts the execution when it reaches the root of a sequence (unless `suppress_errors` is enabled). Because `REQUIRE` is usually the first sequence of a formula, no further sequence is evaluated.

## Example

| Formula | Result |
| :------ | :----- |
| `REQUIRE "stock-5.2+"` | `[NOT_SUPPORTED_ERROR (11)] Standard "stock-5.2+" is not supported.` |

## Reference

- [Core errors](README.md)
- [`REQUIRE`](../procedures/REQUIRE.md)
- [Environment examples](../examples/environment_examples.md)
