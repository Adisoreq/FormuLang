# Metadata

**Metadata** is information about a formula that the host application can read without executing it: its identifier, its context type, its parameters, a description for the user. It is written at the beginning of the formula in a **metadata block**.

Introduced in [**Core**](../standards/core/README.md) `1.2`.


## Metadata block

```php
<@ {
  id: "sma-cross",
  name: "SMA cross",
  description: "Buys when the fast SMA crosses above the slow one.",
  context: "Stock.Strategy",
  parameters: {
    fast: { type: "Number", default: 10, min: 1, description: "Period of the fast SMA" },
    slow: { type: "Number", default: 50, min: 1 }
  }
} @>
REQUIRE "stock-1.2+"
...
```

A metadata block is `<@`, one [Object literal](../syntax/literals.md), and `@>`.

Rules:

1. The block is recognized only as the **first element** of the formula: only white space and [comments](../syntax/operators.md#1-formula-and-line-structure) may be before it. Anywhere else, `<@` is the operator `<` followed by an environment variable, as in `$a <@array_indexing`.
2. A formula has at most one metadata block. A second `<@` at the beginning of a line after the block is an ordinary `<` without a left operand (a `SYNTAX_ERROR` of the parsing).
3. The content of the block is **one Object literal** made of **constant values** only:
   - **Number**, **Text** and **Boolean** literals and `null`;
   - the unary `-` directly before a **Number** literal;
   - **Array** and **Object** literals whose elements and values are constant values.

   Variables, constants (e.g. `PI`), function calls, lambdas and other operators are not allowed. The content can therefore be read without an environment and without executing anything.
4. White space, new lines and comments are allowed inside the block, as inside any Object literal.
5. The content is code, not a comment: a **Text** literal inside the block may contain `@>`, `#` or `<#`.
6. The block never takes part in the evaluation. A formula with a metadata block gives the same result as the same formula without it.

A formula whose metadata block breaks the rules 3 - 5, or is not closed, results in a `SYNTAX_ERROR`.


## Metadata reading

**Metadata reading** is a step of the [execution](../semantics/execution.md), after the [validation](../semantics/validation.md) and before the [clean-up](../semantics/cleanup.md):

| | Description |
| :-- | :---------- |
| **Input** | Validated formula text. |
| **Output** | The metadata **Object** (`{ }` if the formula has no block), and the formula text with the block removed. |

Algorithm:

1. Skip the white space and the comments at the beginning of the formula (with the comment rules of the [clean-up](../semantics/cleanup.md#2-removing-comments)).
2. If the next two characters are not `<@`, return `{ }` and the formula unchanged.
3. Find the end of the block: the first `@>` after `<@` that is outside a **Text** literal and outside a comment. If there is none, return a `SYNTAX_ERROR` (metadata block not closed).
4. [Tokenize](../semantics/tokenization.md) and [parse](../semantics/parsing.md) the content between `<@` and `@>` as one sequence. If it is not one Object literal of constant values, return a `SYNTAX_ERROR`.
5. Compute the Object literal. This needs no context and no environment.
6. Replace the block, both markers included, with one `[New line]` if it contains a line break, or with one `[Space]` otherwise (as a [scoped comment](../semantics/cleanup.md#2-removing-comments)), so the line numbers of the rest of the formula do not change.
7. Return the Object and the formula text.

The host application can run the validation and the metadata reading alone, without the other steps, to read the metadata of a formula (for example, to show its parameters in an editor). The result of the metadata reading is a part of the [prepared formula](../semantics/execution.md#execution-modes).


## Metadata keys

The metadata Object is a plain **Object**. Its keys are defined by the standards:

| Key level | Owner | Example |
| :-------- | :---- | :------ |
| Lowercase keys at the top level | [**Core**](../standards/core/README.md#metadata) | `id`, `name`, `parameters` |
| One top-level key per extension standard, equal to its name in lowercase | the extension standard | `stock: { category: "Trend" }` |
| `x`, with one key per host application | the host application | `x: { montblanc: { color: "#ff0000" } }` |

Rules:

- An extension standard never defines a top-level key other than its own.
- A key that a standard does not define is **kept** in the Object and **ignored**: a formula with the metadata of a newer standard, or of another host application, still runs.
- The values of the known keys are checked by the [validation warnings](../standards/core/semantics/warnings.md): a value of a wrong type is a **warning**, not an error. Wrong metadata never stops a formula.
- The metadata does not change the context. For example, `context: "Iteration"` does not create an Iteration Context: the host application chooses the context type and may compare it with the metadata.


## Compatibility

`<@` at the beginning of a formula has no left operand, so it was a `SYNTAX_ERROR` before `core-1.2`. A formula with a metadata block cannot be executed by an implementation of an earlier version; a host application may cut the block out (with the algorithm above) before it passes the formula to such an implementation.


## Reference

- [Formula](formula.md)
- [Execution](../semantics/execution.md)
- [Core metadata keys](../standards/core/README.md#metadata)
- [Literals](../syntax/literals.md)
