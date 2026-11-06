# SYNTAX_ERROR

[**Core**](../README.md) standard error. Code: `2`.

Evaluated formula breaks the syntax rules.

## Cause

Created automatically by the validator, tokenizer or the parser when a formula has incorrect syntax.

## Behavior

Syntax errors always abort the execution, regardless of the `suppress_errors` environment variable.

## Reference

- [Core errors](README.md)
- [Parsing](../../../semantics/parsing.md)
- [Core validation](../semantics/validation.md)
- [Tokenization](../../../semantics/tokenization.md)
