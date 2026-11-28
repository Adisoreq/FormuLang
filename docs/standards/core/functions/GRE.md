# GRE

Comparison [**Core**](../README.md) standard function. Checks if `a` is greater than `b`.

## Overloads

### Overload 1

Signature: `GRE(a <Number>, b <Number>)`

Collection template:

| # | Name |   | Base type | Extended type | Any type | Multiple | Optional |
| - | :--: | - | :-------: | :-----------: | :------: | :------: | :------: |
| 1 | a | | Number | - | false | false | false |
| 2 | b | | Number | - | false | false | false |

Algorithm:

- Returns `true` if `a` is greater than `b`; otherwise returns `false`

Examples:

|  a  |  b  | GRE(a, b) |
| :-: | :-: | :-------: |
| 5 | 3 | true |
| 3 | 5 | false |
| 5 | 5 | false |

---

### Overload 2: Missing values

Since `core-1.3`. Signature: `GRE(a <Number | Null>, b <Number | Null>)`, with at least one argument `null`. Operator form: `a > b`.

Collection template:

| # | Name |   | Base type | Extended type | Any type | Multiple | Optional |
| - | :--: | - | :-------: | :-----------: | :------: | :------: | :------: |
| 1 | a | | Number, Null | - | false | false | false |
| 2 | b | | Number, Null | - | false | false | false |

Algorithm:

- Returns `false` (see [Missing values](../README.md#missing-values))

Examples:

|  a  |  b  | GRE(a, b) |
| :-: | :-: | :-------: |
| null | 1 | false |
| 1 | null | false |
| null | null | false |

With `null`, the comparisons are not each other's negation: `null > 1` and `null <= 1` are both `false`, so `!(a > b)` is `true` while `a <= b` is `false`. Write the opposite condition directly (e.g. `CLOSE[I] < $ema[I]`), not as a negation.

## Errors

- [`ARGUMENT_ERROR`](../errors/ARGUMENT_ERROR.md) - the arguments match no overload. If one of the arguments is an **Error**, that **Error** is returned instead (see [Evaluation](../../../semantics/evaluation.md#3-function-call)).


## Reference

- [Core standard](../README.md)
