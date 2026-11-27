# IF

Control flow [**Core**](../README.md) standard function. Returns `then` value if condition is `true`, otherwise `else`.

## Overloads

### Overload 1

Signature: `IF(condition <Boolean>, then <Any>, else <Any>)`

Collection template:

| # | Name |   | Base type | Extended type | Any type | Multiple | Optional |
| - | :--: | - | :-------: | :-----------: | :------: | :------: | :------: |
| 1 | condition | | Boolean | - | false | false | false |
| 2 | then | | - | - | true | false | false |
| 3 | else | | - | - | true | false | false |

Algorithm:

- If `condition` is `true`, returns `then`
- Otherwise, returns `else`
- The value that is not returned is discarded, even if it is an **Error**

Examples:

| condition | then | else | IF(condition, then, else) |
| :-: | :-: | :-: | :-------: |
| true | "High" | "Low" | "High" |
| false | 1 | 0 | 0 |
| false | "High" | "Low" | "Low" |
| true | 1 | `ERROR("Invalid")` | 1 |
| false | 1 | `ERROR("Invalid")` | `Error`: "Invalid" |

> **Note:** `then` and `else` accept any value, including an **Error**. An **Error** in the branch that is not selected is discarded and does not affect the result. An **Error** in `condition` is propagated.
>
> All arguments are computed before `IF` is called, so side effects in both branches (for example, assignments) are executed regardless of the condition. Use `IF` only to select a value.
>
> Since `core-1.2`, the writes to the [memory](../../../core/context.md#memory) (`STORE`, `CLEAR`) executed in the branch that is not selected are discarded: `IF($cond, STORE("x", 1), 0)` writes only when `$cond` is `true`. The same holds for an `IF` nested in that branch. A lazy `IF` that does not compute the other branch at all, assignments included, is planned for `core-2.0`.

## Performance

The branch that is not selected is computed only for its side effects: its value, even an **Error**, is discarded. A formula executed once per iteration often computes a costly value in one branch and uses it only once, e.g. the first value of an indicator: `IF(ISNULL(PREV), AVG(RANGE(SOURCE, 0, I)), PREV + ...)`. Computing both branches in every iteration does the costly work every time.

An implementation **may** therefore skip the computation of the branch that is not selected, as long as the result of the formula and every side effect are the same as when both branches are computed. In practice, this holds when:

- `condition` is a **Boolean**. For any other value, `IF` matches no overload and the [function call](../../../semantics/evaluation.md#3-function-call) rules may return an **Error** from one of the branches, so both branches are needed;
- the branch has no side effects: it calls no procedure (`SET`, `INIT`, `COND_SET`, also through the operators `=`, `:=` and `?=`; `STORE` and `CLEAR` are allowed, because their writes in a branch that is not selected are discarded), no function that changes the context, the environment or the host application, and no **Delegate** whose body is not known when the branch is skipped (e.g. a lambda stored in a variable and passed to `MAP`);
- skipping the branch, or computing the selected one in another order than the [parsing queue](../../../semantics/parsing.md#1-parsing-queue), cannot change a value read by another part of the formula. For example, an implementation can apply it only to sequences, or values of assignments, without side effects.

The functions of the Core and Stock standards have no side effects. [`RECALL`](RECALL.md) reads the memory as it was at the start of the iteration, so it gives the same value wherever it is computed. Functions added by the host application may have them (e.g. a function that records diagnostics), so an implementation treats them as functions with side effects unless the host application states otherwise.

## Errors

- [`ARGUMENT_ERROR`](../errors/ARGUMENT_ERROR.md) - `condition` is not a **Boolean** (there is no implicit conversion; use [`BOOL`](BOOL.md) to convert a value). If one of the arguments is an **Error**, the leftmost **Error** argument is returned instead, as for every [function call](../../../semantics/evaluation.md#3-function-call) that matches no overload: the **Error** in `condition`, or else an **Error** in `then` or `else`.

| Formula | Result |
| :------ | :----- |
| `IF(1, 2, 3)` | `[ARGUMENT_ERROR (6)] ...` |
| `IF(BOOL(1), 2, 3)` | `2` |
| `IF(ERROR("c"), ERROR("a"), 2)` | `[CUSTOM_ERROR (1)] c` |
| `IF(1, ERROR("a"), 2)` | `[CUSTOM_ERROR (1)] a` |


## Reference

- [Core standard](../README.md)
