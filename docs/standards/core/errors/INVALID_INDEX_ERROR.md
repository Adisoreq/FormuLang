# INVALID_INDEX_ERROR

[**Core**](../README.md) standard error. Code: `7`.

Trying to access an array element with non-existent index.

## Cause

[`GET`](../functions/GET.md) (or the `array[index]` operator) receives an index that is out of the array's range or is not a whole number.

## Example

| Formula | Result |
| :------ | :----- |
| `[10, 20, 30][10]` | `[INVALID_INDEX_ERROR (7)] Trying to access non-existent array index (10).` |

## Reference

- [Core errors](README.md)
- [`GET`](../functions/GET.md)
- [Array type](../types/Array.md)
