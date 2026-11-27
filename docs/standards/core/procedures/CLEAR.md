# CLEAR

Context [**Core**](../README.md) standard procedure. Removes a key, or every key, from the [memory](../../../core/context.md#memory) of the context.

Introduced in `core-1.2`.

## Overloads

### Overload 1: One key

Signature: `CLEAR(key <Text>)`

| # | Name | Description |
| - | :--: | :---------- |
| 1 | key | Key to be removed. Removing a key that is not stored is not an error. |

Behavior:

- The removal is collected and applied after the current iteration (or frame), like a write of [`STORE`](STORE.md): from the next iteration on, `RECALL(key)` gives `null` (or its `fallback`).
- If the same key is also written with `STORE` in the same iteration, the last of the writes wins.

### Overload 2: Every key

Signature: `CLEAR()`

Behavior:

- Removes every key stored in the memory, after the current iteration. A `STORE` executed after `CLEAR()` in the same iteration is applied after the removal, so its key is kept.

Both overloads follow the rules of [Memory](../../../core/context.md#memory): a removal in a branch of `IF` that is not selected, in an argument of `AND` or `OR` that does not decide the result, or in an iteration that results in an **Error**, is discarded.

## Result

[`SUCCESS`](../errors/SUCCESS.md) **Error**.

## Examples

Iteration Context with `N` = `4`:

| Formula | Results of the iterations |
| :------ | :------------------------ |
| `STORE("x", I)` <br> `IF(I == 1, CLEAR("x"), 0)` <br> `RECALL("x")` | `null`, `0`, `null`, `2` |
| `IF(I == 2, CLEAR(), 0)` <br> `$c = RECALL("c", 0) + 1` <br> `STORE("c", $c)` <br> `$c` | `1`, `2`, `3`, `4` (the `STORE` after `CLEAR()` is kept) |
| `CLEAR("missing")` | `SUCCESS` |

## Errors

- [`OPERATION_ERROR`](../errors/OPERATION_ERROR.md) - the context has no memory (the Default Context).
- [`ARGUMENT_ERROR`](../errors/ARGUMENT_ERROR.md) - `key` is not a **Text**. If the argument is an **Error**, the procedure is not executed and that **Error** is returned.

## Reference

- [Core procedures](README.md)
- [`STORE`](STORE.md)
- [`RECALL`](../functions/RECALL.md)
- [Memory](../../../core/context.md#memory)
