# RECALL

Memory [**Core**](../README.md) standard function. Returns the value stored under a key in the [memory](../../../core/context.md#memory) of the context by [`STORE`](../procedures/STORE.md) in one of the previous iterations.

Introduced in `core-1.2`.

## Overloads

### Overload 1

Signature: `RECALL(key <Text>)`

Equivalent of `RECALL(key, null)`.

### Overload 2

Signature: `RECALL(key <Text>, fallback <Any>)`

Collection template:

| # | Name |   | Base type | Extended type | Any type | Multiple | Optional |
| - | :--: | - | :-------: | :-----------: | :------: | :------: | :------: |
| 1 | key | | Text | - | false | false | false |
| 2 | fallback | | - | - | true | false | false |

Algorithm:

- If the memory, as it was at the start of the current iteration (or frame), has a value under `key`, returns that value
- Otherwise, returns `fallback`

Writes of the current iteration are not visible: `RECALL` gives the same value wherever it is called within one iteration. It is not a side effect, so `RECALL` does not disable the [optimization of `IF`](IF.md#performance).

Examples (Iteration Context, `N` = `3`):

| Formula | Results of the iterations |
| :------ | :------------------------ |
| `RECALL("x")` | `null`, `null`, `null` |
| `RECALL("x", 0)` | `0`, `0`, `0` |
| `STORE("x", I * 10)` <br> `RECALL("x", -1)` | `-1`, `0`, `10` |
| `$prev = RECALL("close")` <br> `STORE("close", SOURCE[I])` <br> `$prev` | `null`, then the previous value of `SOURCE` |

## Errors

- [`OPERATION_ERROR`](../errors/OPERATION_ERROR.md) - the context has no memory (the Default Context).
- [`ARGUMENT_ERROR`](../errors/ARGUMENT_ERROR.md) - `key` is not a **Text**. If `key` is an **Error**, that **Error** is returned instead. `fallback` accepts any value, including an **Error**, which is returned only when the key is not stored.

## Reference

- [Core standard](../README.md)
- [`STORE`](../procedures/STORE.md)
- [`CLEAR`](../procedures/CLEAR.md)
- [Memory](../../../core/context.md#memory)
