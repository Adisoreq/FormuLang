# Evaluation

**Evaluation** is the fifth stage of the [execution](./execution.md) process, where every entry of the [primitive map](./parsing.md#3-primitive-map) built during [parsing](./parsing.md) is resolved into a concrete value, following the processing order established by the [parsing queue](./parsing.md#1-parsing-queue).

## Description

- If the evaluated primitive is either a [**literal value**](../core/values.md) or a [**value container**](../core/containers.md), its value is extracted directly.
- If the evaluated primitive is a [**function**](../core/functions.md), the extracted value is computed by calling the function with its resolved arguments.
- If the evaluated primitive is a [**lambda function**](../core/functions.md#named-and-anonymous-functions), its body is **not** evaluated. The value is a [Delegate](../standards/core/types/Delegate.md) referring to the [lambda tree](./parsing.md#lambda-trees) stored during parsing; the body is evaluated only when the lambda is [invoked](#lambda-invocation).

## Evaluation phases

### 1. Queue traversal

#### Description

Entries of the primitive map are dequeued in the order defined by the parsing queue — **bottom-up**, from the deepest level to the shallowest. This guarantees that every argument a function depends on has already been resolved to a value by the time the function itself is dequeued.

### 2. Direct extraction

#### Description

**Values** and **value containers** (constants and variables) don't require computation — their stored value is read directly and written back into the primitive map under the same expression key.

#### Reading variables

A variable is read when the entry is dequeued, so it holds the value assigned by the previous sequences. The read follows these rules:

1. The variable argument of [`SET`](../standards/core/procedures/SET.md), [`INIT`](../standards/core/procedures/INIT.md) and [`COND_SET`](../standards/core/procedures/COND_SET.md) (the left operand of `=`, `:=` and `?=`) is **not** read. The procedure receives the variable itself.
2. **Declaration**: if the root of a sequence is a context variable that does not exist, the variable is declared with no value ([**Undefined**](../standards/core/types/Undefined.md)) and the sequence returns `SUCCESS`.
3. A context variable that does not exist resolves to an [`UNKNOWN_SYMBOL_ERROR`](../standards/core/errors/UNKNOWN_SYMBOL_ERROR.md) **Error**.
4. An environment variable that does not exist resolves to an [`ENVIRONMENT_ERROR`](../standards/core/errors/ENVIRONMENT_ERROR.md) **Error**.
5. A context variable that has no value (**Undefined**) resolves to an [`UNDEFINED_ERROR`](../standards/core/errors/UNDEFINED_ERROR.md) **Error**.
6. Otherwise, the variable resolves to its stored value. If the variable is the root of a sequence, this value is the result of the sequence.

An **Error** created by a read is a regular value, so it is propagated by the [function call](#3-function-call) rules and aborts the execution when it reaches the root of a sequence. An **Undefined** value is therefore never passed to a function.

| Formula | Result |
| :------ | :----- |
| `$x` | `SUCCESS` (`$x` is declared) |
| `$x` <br> `$x + 1` | `[UNDEFINED_ERROR (12)] Variable "x" has no value.` |
| `$y + 1` | `[UNKNOWN_SYMBOL_ERROR (5)] Variable "y" is not defined.` |
| `$x` <br> `$x = 2` <br> `$x` | `2` |

### 3. Function call

#### Description

For a **named function** primitive, its resolved arguments are matched against the function's [argument collection template](../implementation/argument_collection_template.md) to select the first matching overload. The function is then invoked through a [function call](../implementation/function_call.md) structure, which binds the resolved **Function** and **Arguments**, and stores the computed **Result**.

If no overload matches the provided arguments, the result depends on the arguments:

- if at least one argument is an **Error** value, the function is not executed and the call resolves to the **leftmost** of those **Error** values, unchanged (including its code and details);
- otherwise, if an array argument did not match an [element type](../implementation/argument_template.md#properties) because one of its elements is an **Error**, the call resolves to the first such **Error** element, unchanged;
- otherwise, the call resolves to an `ARGUMENT_ERROR` **Error** value.

An **Error** value is a regular value: a template with **Any type** matches it, so functions such as [`ISERR`](../standards/core/functions/ISERR.md) or the `then` and `else` parameters of [`IF`](../standards/core/functions/IF.md) receive it as is. A template with a specific base type does not match it, so the call propagates the error as described above.

Procedures (for example `SET`) never accept **Error** arguments. A procedure called with an **Error** argument is not executed and propagates the error in the same way.

#### Lambda invocation

A lambda function has no overloads, so no argument matching is performed. It is invoked by the function it was passed to (for example [`MAP`](../standards/core/functions/MAP.md) or [`FILTER`](../standards/core/functions/FILTER.md)), through the same [function call](../implementation/function_call.md) structure:

1. The number of arguments must be equal to the number of the lambda's parameters. Otherwise the body is not evaluated and the call resolves to an `ARGUMENT_ERROR` **Error** value. Argument types are not validated, and an **Error** argument is bound like any other value.
2. The arguments are bound to the **Parameter** leaves of the stored lambda tree. The binding belongs to this invocation only, so separate invocations don't affect each other.
3. Only the evaluation of the stored tree is performed: its parsing queue is traversed bottom-up exactly as described in the phases above, and function calls inside the body follow the rules of this phase. Clean-up, tokenization and parsing are **not** repeated.
4. The value of the body's root expression is the result of the call, returned directly and stored as the **Result** of the function call.

### 4. Result propagation

#### Description

Once computed, a function's result is written back into the primitive map under its expression key, making it available to any parent expression that depends on it. An **Error** result is stored like any other value; it affects only the expressions that receive it as an argument, according to the [function call](#3-function-call) rule above.

Because the queue is processed bottom-up, **all** arguments of a call are computed before the call itself. The arguments of `IF` that are not selected are therefore computed too: an **Error** they produce is discarded by `IF`, but any side effect (for example, an assignment) is executed anyway.

### 5. Sequence result

#### Description

When the root expression of a sequence is computed, its result is checked:

- If it is an **Error** with a code other than `SUCCESS` (0), the execution is **aborted**: the remaining sequences are not evaluated and the **Error** becomes the result of the formula. If the environment variable `suppress_errors` is **true**, the **Error** is replaced with `null` instead and the execution continues with the next sequence.
- Otherwise (any other value, including the `SUCCESS` **Error** returned by assignments and other procedures), the execution continues with the next sequence.

An **Error** value that does not reach the root of a sequence — because it was discarded or handled inside the expression, e.g. by `ISERR` or an unselected `IF` branch — does not abort the execution.

Syntax errors are detected before evaluation, and always abort the execution.

#### Example

| Sequence | Root result | Execution |
| :------- | :---------- | :--------- |
| `$x = 4` | `SUCCESS` | Continues. |
| `$y = IF($x > 0, DIV(1, $x), ERROR("Negative!"))` | `SUCCESS` | Continues; the `ERROR` call was computed, but discarded by `IF`. |
| `$z = IF($x < 0, 1, ERROR("Not negative!"))` | `CUSTOM_ERROR` (`SET` propagates the `Error` argument) | Aborts; the formula's result is `Error: "Not negative!"`. |
| `ISERR(ERROR("a"))` | `true` | Continues; the error was handled by `ISERR`. |

## Example

Continuing the [parsing example](./parsing.md#example):

### Primitive map (before evaluation)

| Expression | Primitive type | Base type | Value |
| :--------- | :------------- | :-------- | :---- |
| `"core-0.2+"` | Value | `Text` | core-0.2+ |
| `REQUIRE("core-0.2+")` | Function | `Error` | |
| `$a` | Variable | `Undefined` | |
| `4` | Value | `Number` | 4.0 |
| `SET($a,4)` | Function | `Error` | |
| `$b` | Variable | `Undefined` | |
| `3` | Value | `Number` | 3.0 |
| `SET($b,3)` | Function | `Error` | |
| `2` | Value | `Number` | 2.0 |
| `POW($a,2)` | Function | `Number` | |
| `POW($b,2)` | Function | `Number` | |
| `ADD(POW($a,2),POW($b,2))` | Function | `Number` | |
| `$c` | Variable | `Undefined` | |
| `SET($c,ADD(POW($a,2),POW($b,2)))` | Function | `Error` | |
| `SQRT($c)` | Function | `Number` | |

### Primitive map (after evaluation)

| Expression | Primitive type | Base type | Value |
| :--------- | :------------- | :-------- | :---- |
| `"core-0.2+"` | Value | `Text` | core-0.2+ |
| `REQUIRE("core-0.2+")` | Function | `Error` | `SUCCESS` |
| `$a` | Variable | `Number` | 4.0 |
| `4` | Value | `Number` | 4.0 |
| `SET($a,4)` | Function | `Error` | `SUCCESS` |
| `$b` | Variable | `Number` | 3.0 |
| `3` | Value | `Number` | 3.0 |
| `SET($b,3)` | Function | `Error` | `SUCCESS` |
| `2` | Value | `Number` | 2.0 |
| `POW($a,2)` | Function | `Number` | 16.0 |
| `POW($b,2)` | Function | `Number` | 9.0 |
| `ADD(POW($a,2),POW($b,2))` | Function | `Number` | 25.0 |
| `$c` | Variable | `Number` | 25.0 |
| `SET($c,ADD(POW($a,2),POW($b,2)))` | Function | `Error` | `SUCCESS` |
| `SQRT($c)` | Function | `Number` | 5.0 |

> [!NOTE]
> Entries are evaluated in the order of the parsing queues, sequence by sequence. Each `SET` call writes the value of its second argument into the variable, so `$a`, `$b` and `$c` become `Number` once their assignment is evaluated; the `SUCCESS` **Error** returned by `REQUIRE` and `SET` does not abort the execution.
>
> The root of the last sequence is `SQRT($c)`, so the result of the formula is `5`.


## Reference

- [Execution](./execution.md)
- [Parsing](./parsing.md)
- [Finalization](./finalization.md)
- [Primitives](../core/primitives.md)
- [Functions](../core/functions.md)
- [Argument collection template](../implementation/argument_collection_template.md)
- [Function call](../implementation/function_call.md)