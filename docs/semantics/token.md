# Token

Token is an atomic expression generated from formula sequence during [tokenization](./tokenization.md).


## Token structure

| Property | Description |
| -------- | ----------- |
| Type | Category determining the role of the token |
| Content | Array of symbols grouped by the token |


## Token types

List of token types:

| Type | Description | Content |
| ---- | ----------- | ------- |
| None | Token is not yet specified. | None |
| Operator | Stores one operator or delimiter token, or the `[New line]` boundary between lines. | Consists of a supported 1- or 2-character operator spelling, as defined in [Operators](../syntax/operators.md#operator-length), or of a single new line symbol. |
| Identifier | Stores information about constant, variable, function, or literal (with exception of **number** and **text** literals). | Starts from a **letter** (A-Z, a-z) or **underline** (`_`). Consists of **letters**, **underlines** and **digits**. |
| Number | Stores information about a number literal. | Starts from a digit or a **dot** (`.`) followed by a digit. May contain digits, underlines, letters (exponent marker, hexadecimal prefix and digits), one **dot** (`.`), and a **plus** (`+`) or **minus** (`-`) sign directly after the exponent marker. The sign of a number is never part of the token: `-` is always an operator. |
| Text | Stores information about **text** literal. | Starts and ends with quotation marks (`"`) and may consist of any [allowed symbol](../syntax/symbols.md). |


## Reference

- [Operators](../syntax/operators.md)
- [Operator Parsing](operator-parsing.md)
- [Symbols](../syntax/symbols.md)
- [Tokenization](./tokenization.md)