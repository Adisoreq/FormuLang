# CALL

Control flow [**Core**](../README.md) standard function. Calls a [Delegate](../types/Delegate.md) with the given arguments. The call syntax `delegate(arguments)` is translated into `CALL`, e.g. `$f(2)` is `CALL($f, 2)` (see [Calling delegates](../../../syntax/functions.md#calling-delegates)).

## Overloads

### Overload 1

Signature: `CALL(function <Delegate>, ...arguments? <Any>)`

Collection template:

| # | Name |   | Base type | Extended type | Any type | Multiple | Optional |
| - | :--: | - | :-------: | :-----------: | :------: | :------: | :------: |
| 1 | function | | Delegate | - | false | false | false |
| 2 | arguments | | - | - | true | true | true |

Algorithm:

- If `function` refers to a **lambda**, invokes it with `arguments` as described in [lambda invocation](../../../semantics/evaluation.md#lambda-invocation): the number of arguments must be equal to the number of its parameters, otherwise returns an `ARGUMENT_ERROR`. An **Error** argument is bound like any other value
- If `function` refers to a **named function**, calls it with `arguments` exactly like a [function call](../../../semantics/evaluation.md#3-function-call) written with its name: the first matching overload is executed, and if none matches, the result is the leftmost **Error** argument or an `ARGUMENT_ERROR`
- If `function` refers to a **procedure** (e.g. `SET`), returns an `OPERATION_ERROR`: procedures are called only by their names
- Returns the result of the call unchanged, including an **Error**
- A lambda invocation deeper than the [invocation depth limit](../../../semantics/evaluation.md#invocation-depth) (256) returns an `OPERATION_ERROR`

Examples:

| Formula | Result |
| :------ | :----- |
| `$double = (x) => x * 2` <br> `$double(4)` | `8` |
| `CALL((x, y) => x + y, 1, 2)` | `3` |
| `$f = ABS` <br> `$f(-3)` | `3` |
| `$apply = (f, x) => f(x)` <br> `$apply((v) => v + 1, 1)` | `2` |
| `$ops = { inc: (x) => x + 1 }` <br> `$ops.inc(1)` | `2` |
| `((x) => x * 2)(4)` | `8` |
| `$double(1, 2)` | `[ARGUMENT_ERROR (6)] ...` |
| `$n = 5` <br> `$n(1)` | `[ARGUMENT_ERROR (6)] ...` |
| `$f = (n) => $f(n + 1)` <br> `$f(0)` | `[OPERATION_ERROR (3)] ...` |

## Errors

- [`ARGUMENT_ERROR`](../errors/ARGUMENT_ERROR.md) - `function` is not a **Delegate**, or a lambda receives another number of arguments than its number of parameters, or the arguments match no overload of a named function. If one of the arguments of `CALL` is an **Error** and `function` is not a **Delegate**, the leftmost **Error** is returned instead (see [Evaluation](../../../semantics/evaluation.md#3-function-call)).
- [`OPERATION_ERROR`](../errors/OPERATION_ERROR.md) - `function` is a procedure, or the invocation depth limit is exceeded.
- An **Error** returned by the called function is returned unchanged.


## Reference

- [Core standard](../README.md)
- [Calling delegates](../../../syntax/functions.md#calling-delegates)
- [Delegate](../types/Delegate.md)
