# Undefined

**Basic** type of the [**Core**](../README.md) standard.

## Description

**Undefined** is the state of a context variable that is declared but has no value yet (not to be mistaken with [**Null**](Null.md), which is a regular value that means "no data").

**Undefined** belongs to variables only. It is never a value of an expression: it is never passed to a function as an argument, never returned by a function, and never stored in an array or an object.

## Creation

The only way to create an **Undefined** variable is a declaration without a value: a sequence that consists only of a context variable that does not exist yet.

| Formula | Meaning |
| :------ | :------ |
| `$x` | Declares `$x` with no value. The sequence returns [`SUCCESS`](../errors/SUCCESS.md). |

There is no `undefined` literal and no `UNDEFINED` constant, so a variable that has a value cannot become **Undefined** again. Environment variables are never **Undefined**.

## Semantics

- **Reading** an **Undefined** variable results in [`UNDEFINED_ERROR`](../errors/UNDEFINED_ERROR.md). The error is propagated like any other **Error** (see [Evaluation](../../../semantics/evaluation.md#2-direct-extraction)).
- **Assigning**: an **Undefined** variable can be assigned a value of any type with [`SET`](../procedures/SET.md) (`=`) or [`INIT`](../procedures/INIT.md) (`:=`), without a [`TYPE_ERROR`](../errors/TYPE_ERROR.md). After the assignment, the type rule of `SET` applies.
- **Checking**: `ISERR($x)` returns `true` for an **Undefined** variable, because the read results in an **Error**.
- Follows **pass-by-value** semantics in the containers that store it.

## Serialization

Used only to show the state of a variable (e.g. in a debugger), because an **Undefined** value is never the result of an expression.

| Value | Serialized |
| :---: | :--------: |
| undefined | `undefined` |

## Reference

- [Core types](README.md)
- [`UNDEFINED_ERROR`](../errors/UNDEFINED_ERROR.md)
- [Values](../../../core/values.md#states)
- [Literals](../../../syntax/literals.md#5-undefined)
- [Serialization](../semantics/serialization.md#undefined-values)
