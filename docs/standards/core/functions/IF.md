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

## Errors

- [`ARGUMENT_ERROR`](../errors/ARGUMENT_ERROR.md) - `condition` is not a **Boolean**. If `condition` is an **Error**, that **Error** is returned instead.


## Reference

- [Core standard](../README.md)
