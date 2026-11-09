<div align="center">

<img src="../raw/images/icons/monogram.svg" height="60" alt="FormuLang monogram" />

# Documentation

**FormuLang** technical documentation overview.

</div>

## Core concepts
- [**Formula**](core/formula.md) - the text that is executed, its sequences and its result.
- [**Primitives**](core/primitives.md) - basic elements of **FormuLang**: types, values, containers, and functions.
  - [**Types**](core/types.md) - category attributes that specify how values are interpreted, validated and computed.
  - [**Containers**](core/containers.md) - variables and constants used to store and access named values.
  - [**Functions**](core/functions.md) - autonomous blocks that process inputs and return a computed output.
  - [**Context**](core/context.md) - scoped data container for a single formula execution.
  - [**Environment**](core/environment.md) - global abstraction layer between **FormuLang** and the host application.

## Syntax Specification
Definition of valid symbols, grammar rules, and text structure.
- [**Symbols**](syntax/symbols.md) - allowed characters and their classification.
  - [**Operators**](syntax/operators.md) - arithmetic (`+`, `-`), logical (`&&`, `||`), and other operators.
  - [**Literals**](syntax/literals.md) - syntax for expressing values directly in formulas.
  - [**Naming**](syntax/naming.md) - identifier rules and naming conventions.
  - [**Functions**](syntax/functions.md) - function invocation and lambda expression syntax.

## Semantics & Execution
How the code is interpreted and executed.
- [**Validation**](semantics/validation.md) - environment integrity checks and syntax errors, before any other stage.
- [**Cleanup**](semantics/cleanup.md) - input normalization and whitespace compression.
- [**Tokenization**](semantics/tokenization.md) - splitting formulas into sequences and expressions.
- [**Operator Parsing**](semantics/operator-parsing.md) - determining operator roles, binding power, and delimiter contexts.
- [**Parsing**](semantics/parsing.md) - resolving expression trees and building the primitive map.
- [**Evaluation**](semantics/evaluation.md) - resolving the primitive map into computed values.
- [**Finalization**](semantics/finalization.md) - wrapping the computed value into the returned result.
- [**Execution**](semantics/execution.md) - full execution pipeline walkthrough.
  - [**Pre-execution**](semantics/pre-execution.md) - building the context from the environment before execution.
  - [**Post-execution**](semantics/post-execution.md) - consuming the result and releasing the context after execution.

## Standards
Formal specifications defining built-in functions, constants, and procedures.
- [**Core**](standards/core/README.md) - elementary standard, the basis of every other extension.
- [**Stock**](standards/stock/README.md) - market data: candles, indicators, candle patterns and strategies (in progress).

## Examples
Practical usage scenarios.
- [Common Formulas](standards/core/examples/common_formulas.md)
- [Context Examples](standards/core/examples/context_examples.md)
- [Environment Examples](standards/core/examples/environment_examples.md)
- [Array Examples](standards/core/examples/array_examples.md)
- [Number Examples](standards/core/examples/number_examples.md)
- [Text Examples](standards/core/examples/text_examples.md)
