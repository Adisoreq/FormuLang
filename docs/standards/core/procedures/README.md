# Core/Procedures

Built-in procedures introduced by **Core** standard.

A [procedure](../../../core/functions.md#function-types) is a named function whose purpose is to modify the [context](../../../core/context.md) or the [environment](../../../core/environment.md). Procedures are the only functions allowed to change state outside of their arguments (see [Functions](../../../core/functions.md#principles)). They are not stored in the context or the environment.


## Procedures

| Procedure | Scope | Operator | Description |
| :-------- | :---- | :------: | :---------- |
| `SET(variable, value)` | Context, Environment | `=` | Overrides the value of a variable. [[Read more]](SET.md) |
| `INIT(variable, value)` | Context, Environment | `:=` | Initializes a variable only if it does not exist yet or has no value. [[Read more]](INIT.md) |
| `COND_SET(variable, value)` | Context, Environment | `?=` | Overrides a variable only if it already exists. [[Read more]](COND_SET.md) |
| `REQUIRE(standard)` | Environment | | Ensures that the environment supports the requested standard. [[Read more]](REQUIRE.md) |


## Common rules

- **Result** - Every procedure returns the [`SUCCESS`](../errors/SUCCESS.md) **Error** when it finishes correctly. Because its code is `SUCCESS`, it never aborts the execution, even though it is usually the root of a sequence.
- **Error arguments** - A procedure never accepts an **Error** argument. If one of the arguments is an **Error**, the procedure is not executed and the leftmost **Error** argument is returned (see [Evaluation](../../../semantics/evaluation.md#3-function-call)).
- **Variable argument** - The first argument of `SET`, `INIT` and `COND_SET` is the variable itself (written with its sigil, `$` for the context and `@` for the environment), not the value stored in it.
- **Scope** - `SET`, `INIT` and `COND_SET` accept both context (`$`) and environment (`@`) variables and differ only in what they do with them; the scope of a variable never causes an `ARGUMENT_ERROR`. Context variables are changed only in the current context. Environment variables are changed [only for the current execution](../../../core/environment.md#overriding-environment-parameters), and cannot be created by a formula.
- **Argument errors** - [`ARGUMENT_ERROR`](../errors/ARGUMENT_ERROR.md) is returned only when the number or types of the arguments don't match an overload, e.g. the first argument of `SET` is not a variable.
- **Call notation** - A procedure can be called like any function, `SET($x, 100)`, or without parentheses, with arguments separated by white space: `SET $x 100` (see [Parsing](../semantics/parsing.md#procedure-call-without-parentheses)).
- **Operators** - `=`, `:=` and `?=` are translated by the parser into `SET`, `INIT` and `COND_SET` (see [Operators](../../../syntax/operators.md)).


## Reference

- [Core standard](../README.md)
- [Core functions](../functions/README.md)
- [Core errors](../errors/README.md)
- [Functions](../../../core/functions.md)
- [Containers](../../../core/containers.md)
