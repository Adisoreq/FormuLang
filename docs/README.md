# FormuLang Documentation

**FormuLang** technical documentation overview.

## Core concepts
- [**Primitives**](core/primitives.md) - elementary building blocks of **FormuLang**: types, values, containers, and functions.
  - [**Types**](core/types.md) - category attributes that specify how values are interpreted, validated and computed.
  - [**Containers**](core/containers.md) - variables and constants used to store and access named values.
  - [**Functions**](core/functions.md) - autonomous blocks that process inputs and return a computed output.
  - [**Context**](core/context.md) - scoped data container for a single formula evaluation.
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
- [**Cleanup**](semantics/cleanup.md) - input normalization and whitespace compression.
- [**Tokenization**](semantics/tokenization.md) - splitting formulas into sequences and expressions.
- [**Parsing**](semantics/parsing.md) - resolving expression trees and building the primitive map.
- [**Evaluation**](semantics/evaluation.md) - full evaluation pipeline walkthrough.

## Standards
Formal specifications defining built-in functions, constants, and procedures.
- [**Core**](standards/core/README.md) - elementary standard, the basis of every other extension.

## Examples
Practical usage scenarios.
- [Common Formulas](standards/core/examples/common_formulas.md)
- [Context Examples](standards/core/examples/context_examples.md)
- [Environment Examples](standards/core/examples/environment_examples.md)
- [Array Examples](standards/core/examples/array_examples.md)
- [Number Examples](standards/core/examples/number_examples.md)
- [Text Examples](standards/core/examples/text_examples.md)
