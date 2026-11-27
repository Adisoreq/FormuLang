# AND

Logical [**Core**](../README.md) standard function. Checks if all the arguments are true.

Operator form: `a && b`.

## Overloads

### Overload 1

Signature: `AND(a <Boolean>, b <Boolean>)`

Collection template:

| # | Name |   | Base type | Extended type | Any type | Multiple | Optional |
| - | :--: | - | :-------: | :-----------: | :------: | :------: | :------: |
| 1 | a | | Boolean | - | false | false | false |
| 2 | b | | Boolean | - | false | false | false |

Algorithm:

- Returns `true` if both `a` and `b` are `true`; otherwise returns `false`

Examples:

|  a  |  b  | AND(a, b) |
| :-: | :-: | :-------: |
| true | true | true |
| true | false | false |
| false | false | false |

---

### Overload 2

Signature: `AND(...values <Boolean>)`

Since `core-1.2`. At least 2 arguments; with exactly 2 it is the same as the overload 1.

Collection template:

| # | Name |   | Base type | Extended type | Any type | Multiple | Optional |
| - | :--: | - | :-------: | :-----------: | :------: | :------: | :------: |
| 1 | values | | Boolean | - | false | true | false |

Algorithm:

- Returns `true` if every argument is `true`; otherwise returns `false`

Examples:

| Formula | Result |
| :------ | :----- |
| `AND(true, true, true)` | `true` |
| `AND(true, false, true)` | `false` |
| `AND(CLOSE[I] > $ema, $rsi < 30, $volume > $avg)` | `true` if all three conditions are met |


## Short circuit

Since `core-1.2`, the arguments are checked from the left, and the first `false` **decides** the result:

1. If an argument is an **Error** before the first `false`, that **Error** is returned (as for every [function call](../../../semantics/evaluation.md#3-function-call)).
2. Otherwise, if an argument is `false`, the result is `false`. The arguments after it are not used: an **Error** among them is discarded, and so is a value that is not a **Boolean**.
3. Otherwise, the rules of the overloads apply.

The same rules apply to the operator: `a && b && c` is `AND(AND(a, b), c)`, so its result is the same as `AND(a, b, c)`.

| Formula | `core-1.1` | `core-1.2` |
| :------ | :--------- | :--------- |
| `false && ERROR("x")` | `[CUSTOM_ERROR (1)] x` | `false` |
| `AND(false, 1)` | `[ARGUMENT_ERROR (6)] ...` | `false` |
| `ERROR("x") && false` | `[CUSTOM_ERROR (1)] x` | `[CUSTOM_ERROR (1)] x` |
| `true && ERROR("x")` | `[CUSTOM_ERROR (1)] x` | `[CUSTOM_ERROR (1)] x` |
| `READY($ema, 1) && CLOSE[I] > $ema[I]` | an **Error** while `$ema[I]` is `null` | `false` while `$ema[I]` is `null` |

All the arguments are still computed before `AND` is called, so the assignments in the arguments after the deciding one are executed. The writes to the [memory](../../../core/context.md#memory) (`STORE`, `CLEAR`) in those arguments are discarded. A lazy evaluation that does not compute them at all is planned for `core-2.0`.

## Performance

An implementation **may** skip the computation of the arguments after the deciding one, with the same conditions as the [branch of `IF`](IF.md#performance) that is not selected: the result and every side effect must be the same as when all the arguments are computed. Writes to the memory are not a side effect for this rule, because they are discarded.

## Errors

- [`ARGUMENT_ERROR`](../errors/ARGUMENT_ERROR.md) - the arguments match no overload and no argument decides the result (e.g. `AND(true, 1)`, or one argument). If one of the arguments before the deciding one is an **Error**, that **Error** is returned instead (see [Evaluation](../../../semantics/evaluation.md#3-function-call)).


## Reference

- [Core standard](../README.md)
- [`OR`](OR.md)
- [`IF`](IF.md)
