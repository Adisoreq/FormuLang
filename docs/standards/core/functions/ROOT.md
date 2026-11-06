# ROOT

Arithmetical [**Core**](../README.md) standard function. Calculates the n-th root of a number.

## Overloads

### Overload 1

Signature: `ROOT(num <Number>, n <Number>)`

Collection template:

| # | Name |   | Base type | Extended type | Any type | Multiple | Optional |
| - | :--: | - | :-------: | :-----------: | :------: | :------: | :------: |
| 1 | num | | Number | - | false | false | false |
| 2 | n | | Number | - | false | false | false |

Algorithm:

- If `n` is `0`, returns an `OPERATION_ERROR`
- If `num` is less than `0`: if `n` is an odd whole number, returns `NEG(ROOT(NEG(num), n))`; otherwise returns an `OPERATION_ERROR`
- Otherwise, returns `POW(num, 1 / n)`

Examples:

| num | n | ROOT(num, n) |
| :-: | :-: | :-------: |
| 8 | 3 | 2 |
| 16 | 4 | 2 |
| 9 | 2 | 3 |

## Errors

- [`OPERATION_ERROR`](../errors/OPERATION_ERROR.md) - `n` is `0`, or `num` is negative and `n` is not an odd whole number.
- [`ARGUMENT_ERROR`](../errors/ARGUMENT_ERROR.md) - the arguments match no overload. If one of the arguments is an **Error**, that **Error** is returned instead (see [Evaluation](../../../semantics/evaluation.md#3-function-call)).


## Reference

- [Core standard](../README.md)
