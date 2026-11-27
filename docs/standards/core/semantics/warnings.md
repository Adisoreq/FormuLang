# Core/Warnings

This document defines the **warnings** of the **Core** standard (since `core-1.2`): messages about formulas that are valid, but are probably not what the author meant. They complement the [validation](validation.md), which reports only errors.


## Principles

- A warning never changes the result of a formula and never aborts the execution.
- Warnings are produced during the [preparation](../../../semantics/execution.md#execution-modes) of a formula, after the [parsing](parsing.md), and are returned to the host application together with the prepared formula (for example, to show them in an editor). They are not returned by the formula itself.
- A formula that fails in the validation or in the parsing has no warnings: only its errors are reported.
- An implementation may produce other warnings, but it must produce at least the warnings of this document, with a message that identifies the problem and its position.
- Every warning has a **code** (below), a message and a position (line and column, both counted from 1, of the original formula text).
- Warnings are returned in the order of their positions; warnings at the same position are in the order of the table below.
- The position of a warning about a sequence is the first character of the sequence; the position of a metadata warning is the `<` of the metadata block.


## Warnings

| Code | Problem | Message pattern |
| :--- | :------ | :-------------- |
| `UNUSED_VALUE` | A sequence that is not the last one, whose root is not a procedure call (an assignment or another procedure) and not a function of an extension standard with side effects. Its value is computed and discarded. | `The value of the sequence at line <L> is not used.` |
| `CONTINUED_LINE` | A sequence that starts with the prefix operator `-` or `!` and follows another sequence on the previous line, separated by a new line (not by `;`). It is probably the continuation of the previous line, but a new line ends a sequence. | `The sequence at line <L> starts with "<op>": a new line ends the previous sequence. Put the operator at the end of the previous line, or the expression in parentheses.` |
| `METADATA_TYPE` | A known key of the [metadata](../../../core/metadata.md) has a value of a wrong type (e.g. `id: 5`). | `Metadata key "<key>" must be of type <Type>.` |
| `METADATA_CONTEXT` | The `context` of the metadata is not the context type of the execution, nor one of its base types. | `The formula is written for the context "<metadata>", but is executed in "<actual>".` |

`CONTINUED_LINE` is reported only for the operators that can start an expression (`-`, `!`). A sequence that starts with an operator that cannot start an expression (e.g. `&&`, `||`, `*`, `+`) is a `SYNTAX_ERROR` of the parsing; see [Messages of the parsing errors](#messages-of-the-parsing-errors).


## Messages of the parsing errors

A long expression split into lines without parentheses is a common mistake:

```php
$buy = CLOSE[I] > $ema
       && $rsi < 30
```

The new line ends the first sequence, so the second one starts with `&&`, which has no left operand: a `SYNTAX_ERROR`. When a sequence that is not the first one starts with a binary operator that cannot start an expression, the message of the error should say so:

| Problem | Message pattern |
| :------ | :-------------- |
| A sequence starts with a binary operator | `Line <L> starts with "<op>", which has no left operand: a new line ends the previous sequence. Put "<op>" at the end of the previous line, or the expression in parentheses.` |

The code of the error stays `SYNTAX_ERROR`; only the message is more precise. Within parentheses, a new line does not end the sequence, so the expression can be written in several lines:

```php
$buy = (CLOSE[I] > $ema
        && $rsi < 30)
```


## Examples

| Formula | Warnings |
| :------ | :------- |
| `$a = 1` <br> `$a + 1` <br> `$a` | `UNUSED_VALUE` at line 2 |
| `$a = 1` <br> `$a` | none (the last sequence is the result) |
| `$x = $a` <br> `- $b` | `CONTINUED_LINE` at line 2 (and `UNUSED_VALUE`, if it is not the last sequence) |
| `$x = $a -` <br> `$b` | none, but a `SYNTAX_ERROR` (`-` has no right operand at the end of the line) |
| `$x = ($a` <br> `- $b)` | none (the new line is inside parentheses) |
| `<@ { id: 5 } @>` <br> `1` | `METADATA_TYPE` (`id` must be a **Text**) |
| `$buy = $a` <br> `&& $b` | none, but a `SYNTAX_ERROR` with the message of the [parsing errors](#messages-of-the-parsing-errors) |


## Reference

- [Validation](../../../semantics/validation.md#warnings)
- [Core Validation](validation.md)
- [Core Parsing](parsing.md)
- [Metadata](../../../core/metadata.md)
