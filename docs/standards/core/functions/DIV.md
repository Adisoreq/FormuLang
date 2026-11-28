# DIV

Arithmetical [**Core**](../README.md) standard function. Divides the first number by the second.

## Overloads

### Overload 1

Signature: `DIV(a <Number>, b <Number>)`

Collection template:

| # | Name |   | Base type | Extended type | Any type | Multiple | Optional |
| - | :--: | - | :-------: | :-----------: | :------: | :------: | :------: |
| 1 | a | | Number | - | false | false | false |
| 2 | b | | Number | - | false | false | false |

Algorithm:

- If `b` is `0`, returns an `OPERATION_ERROR`
- Otherwise, returns the quotient `a / b`

Examples:

|  a  |  b  | DIV(a, b) |
| :-: | :-: | :-------: |
| 10 | 2 | 5 |
| 7 | 2 | 3.5 |
| 5 | 0 | `Error` |

> **Note:** Dividing by zero returns an **Error** value instead of a **Number**.

---

### Overload 2: Missing values

Since `core-1.3`. Signature: `DIV(a <Number | Null>, b <Number | Null>)`, with at least one argument `null`. Operator form: `a / b`.

Collection template:

| # | Name |   | Base type | Extended type | Any type | Multiple | Optional |
| - | :--: | - | :-------: | :-----------: | :------: | :------: | :------: |
| 1 | a | | Number, Null | - | false | false | false |
| 2 | b | | Number, Null | - | false | false | false |

Algorithm:

- Returns `null` (see [Missing values](../README.md#missing-values))
- `null / 0` is `null`: the division by zero is not checked when an argument is `null`

Examples:

|  a  |  b  | DIV(a, b) |
| :-: | :-: | :-------: |
| null | 1 | null |
| 1 | null | null |
| null | null | null |

## Errors

- [`OPERATION_ERROR`](../errors/OPERATION_ERROR.md) - `b` is `0`, or the result is not a finite number.
- [`ARGUMENT_ERROR`](../errors/ARGUMENT_ERROR.md) - the arguments match no overload. If one of the arguments is an **Error**, that **Error** is returned instead (see [Evaluation](../../../semantics/evaluation.md#3-function-call)).


## Reference

- [Core standard](../README.md)
