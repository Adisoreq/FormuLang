# OR

Logical [**Core**](../README.md) standard function. Checks if at least one argument is true.

Operator form: `a || b`.

## Overloads

### Overload 1

Signature: `OR(a <Boolean>, b <Boolean>)`

Collection template:

| # | Name |   | Base type | Extended type | Any type | Multiple | Optional |
| - | :--: | - | :-------: | :-----------: | :------: | :------: | :------: |
| 1 | a | | Boolean | - | false | false | false |
| 2 | b | | Boolean | - | false | false | false |

Algorithm:

- Returns `true` if `a` or `b` is `true`; otherwise returns `false`

Examples:

|  a  |  b  | OR(a, b) |
| :-: | :-: | :------: |
| true | true | true |
| true | false | true |
| false | false | false |

---

### Overload 2

Signature: `OR(...values <Boolean>)`

Since `core-1.2`. At least 2 arguments; with exactly 2 it is the same as the overload 1.

Collection template:

| # | Name |   | Base type | Extended type | Any type | Multiple | Optional |
| - | :--: | - | :-------: | :-----------: | :------: | :------: | :------: |
| 1 | values | | Boolean | - | false | true | false |

Algorithm:

- Returns `true` if at least one argument is `true`; otherwise returns `false`

Examples:

| Formula | Result |
| :------ | :----- |
| `OR(false, false, true)` | `true` |
| `OR(false, false, false)` | `false` |


## Short circuit

Since `core-1.2`, the arguments are checked from the left, and the first `true` **decides** the result:

1. If an argument is an **Error** before the first `true`, that **Error** is returned (as for every [function call](../../../semantics/evaluation.md#3-function-call)).
2. Otherwise, if an argument is `true`, the result is `true`. The arguments after it are not used: an **Error** among them is discarded, and so is a value that is not a **Boolean**.
3. Otherwise, the rules of the overloads apply.

The same rules apply to the operator: `a || b || c` is `OR(OR(a, b), c)`, so its result is the same as `OR(a, b, c)`.

| Formula | `core-1.1` | `core-1.2` |
| :------ | :--------- | :--------- |
| `true \|\| 1 / 0` | `[OPERATION_ERROR (3)] ...` | `true` |
| `OR(true, "x")` | `[ARGUMENT_ERROR (6)] ...` | `true` |
| `false \|\| ERROR("x")` | `[CUSTOM_ERROR (1)] x` | `[CUSTOM_ERROR (1)] x` |
| `ISNULL($v) \|\| $v > 10` | an **Error** when `$v` is `null` | `true` when `$v` is `null` |

All the arguments are still computed before `OR` is called, so the assignments in the arguments after the deciding one are executed. The writes to the [memory](../../../core/context.md#memory) (`STORE`, `CLEAR`) in those arguments are discarded. A lazy evaluation that does not compute them at all is planned for `core-2.0`.

## Performance

An implementation **may** skip the computation of the arguments after the deciding one, with the same conditions as the [branch of `IF`](IF.md#performance) that is not selected: the result and every side effect must be the same as when all the arguments are computed. Writes to the memory are not a side effect for this rule, because they are discarded.

## Errors

- [`ARGUMENT_ERROR`](../errors/ARGUMENT_ERROR.md) - the arguments match no overload and no argument decides the result (e.g. `OR(false, 1)`, or one argument). If one of the arguments before the deciding one is an **Error**, that **Error** is returned instead (see [Evaluation](../../../semantics/evaluation.md#3-function-call)).


## Reference

- [Core standard](../README.md)
- [`AND`](AND.md)
- [`IF`](IF.md)
