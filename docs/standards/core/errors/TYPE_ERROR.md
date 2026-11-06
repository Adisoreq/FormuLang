# TYPE_ERROR

[**Core**](../README.md) standard error. Code: `4`.

Non-[**Undefined**](../types/Undefined.md) value is being overridden with other type.

## Cause

Assigning a value of a different type to a container that already holds a defined (non-**Undefined**) value.

## Example

| Formula | Result |
| :------ | :----- |
| `$x = 1` <br> `$x = "text"` | `[TYPE_ERROR (4)] Trying to override NUMBER with TEXT.` |
| `$y` <br> `$y = "text"` | `SUCCESS` - **Undefined** may be overridden by any type |

## Reference

- [Core errors](README.md)
- [Undefined type](../types/Undefined.md)
- [Values](../../../core/values.md#states)
