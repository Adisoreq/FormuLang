# ISDEL

Type [**Core**](../README.md) standard function. Checks if value's base type is `Delegate`.

## Overloads

### Overload 1

Signature: `ISDEL(value <Any>)`

Collection template:

| # | Name |   | Base type | Extended type | Any type | Multiple | Optional |
| - | :--: | - | :-------: | :-----------: | :------: | :------: | :------: |
| 1 | value | | - | - | true | false | false |

Algorithm:

- Returns `true` if the base type of `value` is **Delegate**; otherwise returns `false`

Examples:

| value | ISDEL(value) |
| :-: | :-------: |
| `(x) => MUL(x, 2)` | true |
| 5 | false |
| "text" | false |
| [ 1, 2, 3 ] | false |

> **Note:** A [lambda function](../../../syntax/functions.md#lambda-function-expression) is not invoked when it is evaluated; its value is a **Delegate** referring to the stored lambda tree. That is why `ISDEL` receives the delegate itself, not the result of the lambda's body.

## Errors

None. The argument accepts **Any type**, so an **Error** argument is received as a value and is not propagated.


## Reference

- [Core standard](../README.md)
- [Core functions](README.md)
- [Delegate type](../types/Delegate.md)
