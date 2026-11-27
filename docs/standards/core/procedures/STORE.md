# STORE

Context [**Core**](../README.md) standard procedure. Writes a value to the [memory](../../../core/context.md#memory) of the context under a key. The value can be read in the next iterations with [`RECALL`](../functions/RECALL.md).

Introduced in `core-1.2`.

## Overloads

### Overload 1

Signature: `STORE(key <Text>, value <Any>)`

| # | Name | Description |
| - | :--: | :---------- |
| 1 | key | Key of the value. Any **Text**, also an empty one. |
| 2 | value | Value to be stored. Cannot be an **Error** or a **Delegate**. |

Behavior:

- The write is collected and applied after the current iteration (or frame), so `RECALL(key)` gives the stored value from the next iteration on. In the current iteration, `RECALL(key)` still gives the value from before the iteration.
- If the same key is written more than once in one iteration (also with [`CLEAR`](CLEAR.md)), the last write wins.
- A write executed in a branch of `IF` that is not selected, or in an argument of `AND` or `OR` that does not decide the result, is discarded. A write of an iteration that results in an **Error** is discarded.

See [Memory](../../../core/context.md#memory) for the full rules.

## Result

[`SUCCESS`](../errors/SUCCESS.md) **Error**.

## Examples

Iteration Context with `N` = `4`:

| Formula | Results of the iterations |
| :------ | :------------------------ |
| `$sum = RECALL("sum", 0) + I` <br> `STORE("sum", $sum)` <br> `$sum` | `0`, `1`, `3`, `6` |
| `STORE("x", I)` <br> `RECALL("x")` | `null`, `0`, `1`, `2` (the write is visible from the next iteration) |
| `STORE("x", 1)` <br> `STORE("x", 2)` <br> `RECALL("x")` | `null`, `2`, `2`, `2` (the last write wins) |
| `IF(I == 1, STORE("x", I), 0)` <br> `RECALL("x")` | `null`, `null`, `1`, `1` (only the selected branch writes) |
| `STORE "x" I` | `SUCCESS` in every iteration (call without parentheses) |

## Errors

- [`OPERATION_ERROR`](../errors/OPERATION_ERROR.md) - the context has no memory (the Default Context).
- [`ARGUMENT_ERROR`](../errors/ARGUMENT_ERROR.md) - `key` is not a **Text**, or `value` is a **Delegate**. If one of the arguments is an **Error**, the procedure is not executed and that **Error** is returned (see [Common rules](README.md#common-rules)).

## Reference

- [Core procedures](README.md)
- [`RECALL`](../functions/RECALL.md)
- [`CLEAR`](CLEAR.md)
- [Memory](../../../core/context.md#memory)
