# Delegate

**Complex** type of the [**Core**](../README.md) standard.

## Description

Delegate is a type storing a reference to a function — either a **named native function** or an **anonymous lambda** — instead of its returned value. Used to pass functions as arguments to higher-order functions. A delegate referring to a lambda holds the [lambda tree](../../../semantics/parsing.md#lambda-trees) built during parsing.

## Literal

Defined using a [lambda function expression](../../../syntax/functions.md#lambda-function-expression), e.g. `(x) => MUL(x, 2)`. A lambda is not invoked when evaluated; its value is the delegate.

## Serialization

| Stored function | Function type | Serialized |
| :-------------- | :------------ | :--------- |
| `AVG` | Named function | `AVG(args) => any` |
| `(x, y) => x * y` | Lambda function | `(x, y) => any` |

## Semantics

- Follows **pass-by-reference** semantics.
- Invoking a lambda delegate with a number of arguments different from the number of its parameters results in [`ARGUMENT_ERROR`](../errors/ARGUMENT_ERROR.md).

## Related functions

- [`ISDEL`](../functions/ISDEL.md)
- [`MAP`](../functions/MAP.md)
- [`FILTER`](../functions/FILTER.md)

## Reference

- [Core types](README.md)
- [Lambda invocation](../../../semantics/evaluation.md#lambda-invocation)
- [Literals](../../../syntax/literals.md#9-lambda-function)
- [Serialization](../semantics/serialization.md#delegate-values)
