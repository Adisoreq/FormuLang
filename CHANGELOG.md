<div align="center">

<img src="./raw/images/icons/monogram.svg" height="50" alt="FormuLang monogram" />

# Changelog

Main language changes: syntax, semantics, functionality and implementation structures.

</div>


## 2026-11-28

New versions of the standards: Core `1.3` ([Core changelog](./docs/standards/core/CHANGELOG.md)) and Stock `1.3` ([Stock changelog](./docs/standards/stock/CHANGELOG.md)), both backward compatible. The design and the proposals that were not taken are in [Proposals for the 1.3 standards](./docs/misc/proposals_1.3.md).

### Added
- [Missing values](./docs/standards/core/README.md#missing-values): comparisons with `null` give `false`, arithmetic and aggregates with `null` give `null`, and a key of `null` is `null`.
- Array and object functions that return a copy: `APPEND`, `INSERT`, `PUT`, `REMOVE`, `VALUES`, `ENTRIES`, `FROM_ENTRIES`, `CONCAT` of arrays, `MERGE` of many objects, and `GET` with a fallback.
- The Stock function [`SIGNAL_SCORE(buy, sell, weights)`](./docs/standards/stock/functions/SIGNAL_SCORE.md), the signal `SCORE(buy) - SCORE(sell)` of a strategy, and the [formula results](./docs/standards/stock/README.md#formula-results) of the Stock standard.
- Conformance tests: [tests/core/functions/core13.json](./tests/core/functions/core13.json) and [tests/stock/stock13.json](./tests/stock/stock13.json).

### Changed
- The [standards](./docs/standards/README.md) list, [Environment](./docs/core/environment.md) and `README.md` refer to `core-1.3` and `stock-1.3`.

## 2026-11-27 (formula models)

### Added
- [Formula models](./docs/implementation/formula_models.md): definitions of indicators, patterns and strategies read from the metadata, parameter specifications with one normalization algorithm and its problems, instances, runs and live runs, given by the implementations to host applications. They are implementation structures, not a part of the language, so the versions of the standards do not change. Conformance tests: [tests/stock/models.json](./tests/stock/models.json), with the new outcomes `definition`, `invalid`, `parameters`, `problems`, `outputs`, `matches` and `signals` and the case key `given`.

## 2026-11-27

New versions of the standards: Core `1.2` ([Core changelog](./docs/standards/core/CHANGELOG.md)) and Stock `1.2` ([Stock changelog](./docs/standards/stock/CHANGELOG.md)), both backward compatible. They are specified; the implementations follow. The design is in [Proposals for the 1.2 standards](./docs/misc/proposals.md).

### Added
- [Metadata](./docs/core/metadata.md): the metadata block `<@ { ... } @>` at the beginning of a formula, in [Operators](./docs/syntax/operators.md#1-formula-and-line-structure) and [Formula](./docs/core/formula.md#metadata), and the new step [metadata reading](./docs/core/metadata.md#metadata-reading) of the [execution](./docs/semantics/execution.md).
- [Execution modes](./docs/semantics/execution.md#execution-modes): preparation and evaluation, cold and hot execution, prepared formulas.
- [Memory](./docs/core/context.md#memory), `HISTORY` and [resumed iterations](./docs/core/context.md#resumed-iterations) in [Context](./docs/core/context.md).
- [Warnings](./docs/semantics/validation.md#warnings) in Validation, defined by [Core Warnings](./docs/standards/core/semantics/warnings.md).

### Changed
- The [execution steps](./docs/semantics/execution.md#execution-steps) are numbered 1 - 7: the metadata reading is step 2. [Clean-up](./docs/semantics/cleanup.md), [Tokenization](./docs/semantics/tokenization.md), [Parsing](./docs/semantics/parsing.md) and [Evaluation](./docs/semantics/evaluation.md) give their new step numbers.
- [Proposals for the 1.2 standards](./docs/misc/proposals.md) describe the whole design of `1.2`, the changes kept for `2.0` and what stays in the host application.
- The [standards](./docs/standards/README.md) list, [Environment](./docs/core/environment.md) and `README.md` refer to `core-1.2` and `stock-1.2`.

## 2026-11-25

New versions of the standards: Core `1.1` ([Core changelog](./docs/standards/core/CHANGELOG.md)) and Stock `1.1` ([Stock changelog](./docs/standards/stock/CHANGELOG.md)), both backward compatible.

### Added
- [Calling delegates](./docs/syntax/functions.md#calling-delegates) in the function syntax, the delegate call in [Operators](./docs/syntax/operators.md), [Operator parsing](./docs/semantics/operator-parsing.md) and [Core parsing](./docs/standards/core/semantics/parsing.md#delegate-call), and the [invocation depth](./docs/semantics/evaluation.md#invocation-depth) in Evaluation.
- Conformance tests for Core `1.1` ([calls](./tests/core/functions/calls.json), [new functions](./tests/core/functions/core11.json)) and Stock `1.1` ([LAG and WINDOW](./tests/stock/stock11.json)).
- [`IF`, "Performance"](./docs/standards/core/functions/IF.md#performance): an implementation may skip the computation of the branch that is not selected when it has no side effects and the result of the formula is the same (a Boolean condition, no procedures, no functions with side effects, no delegates with unknown bodies). [Evaluation](./docs/semantics/evaluation.md#4-result-propagation) links to it.
- Conformance tests `core.functions.basics.031` - `034`: `IF` with a condition that is not a Boolean.

### Changed
- `README.md`: an [Implementations](./README.md#implementations) section with FormuLang.NET and FormuLang-TS (packages, installation, web previews); the version is `1.1` and the implementations are done. [Future plans](./docs/misc/future_plans.md) and the [conformance tests](./tests/README.md) link to the libraries; the npm package is `formulang-ts`.
- The documentation refers to `core-1.1` and `stock-1.1`: the [standards](./docs/standards/README.md) list, [Environment](./docs/core/environment.md), [Future plans](./docs/misc/future_plans.md) and the Core and Stock READMEs.

### Fixed
- Conformance case `core.syntax.unicode.011` expected only the first error for `$zółw = 1`, but step 3.3 of the [validation algorithm](./docs/standards/core/semantics/validation.md#validation-algorithm) reports every invalid symbol. The case now expects both (`ó` at column 3 and `ł` at column 4), as both implementations already report.
- [`IF`, "Errors"](./docs/standards/core/functions/IF.md#errors) described only `ARGUMENT_ERROR` and an **Error** in `condition`. As for every [function call](./docs/semantics/evaluation.md#3-function-call) that matches no overload, a condition that is not a Boolean gives the leftmost **Error** argument, also one in `then` or `else`, and `ARGUMENT_ERROR` only if there is none. The section now says so, with examples; a condition is never converted implicitly (`BOOL` converts it). The behavior of `core-1.0` does not change.

## 2026-11-23

Preparation of the first release, **1.0**. Standard changes are in the [Core changelog](./docs/standards/core/CHANGELOG.md) (`core-1.0`) and the [Stock changelog](./docs/standards/stock/CHANGELOG.md) (`stock-1.0`).

### Added
- Scoped comments `<# ... #>` in [Operators](./docs/syntax/operators.md#1-formula-and-line-structure), [Clean-up](./docs/semantics/cleanup.md#2-removing-comments) and [Core Validation](./docs/standards/core/semantics/validation.md).
- Unicode characters inside text literals: [Text characters](./docs/syntax/symbols.md#text-characters); [Tokenization](./docs/semantics/tokenization.md) and validation check the characters by mode.
- [Time Context](./docs/core/context.md#3-time-context) and the `NOW` constant in [Pre-execution](./docs/semantics/pre-execution.md).
- [Conformance tests](./tests/README.md): JSON test cases with a [schema](./tests/schema.json) and a validation script.

### Changed
- The documentation refers to `core-1.0` and `stock-1.0`: the [standards](./docs/standards/README.md) list, examples of `REQUIRE`, [Environment](./docs/core/environment.md), [Comparison](./docs/misc/comparison.md) and [Future plans](./docs/misc/future_plans.md).
- `README.md`: status, badge and the syntax example.

### Fixed
- Typos in [Literals](./docs/syntax/literals.md), [Symbols](./docs/syntax/symbols.md) and [Tokenization](./docs/semantics/tokenization.md).

## 2026-11-09

Core standard changes of this date are in the [Core changelog](./docs/standards/core/CHANGELOG.md) (version `0.3`).

### Changed
- The documentation refers to the Core standard version `0.3` (identifier `core-0.3`): the [standards](./docs/standards/README.md) list, the [Environment](./docs/core/environment.md) example and [Comparison](./docs/misc/comparison.md).

## 2026-11-07

Core standard changes of this date are in the [Core changelog](./docs/standards/core/CHANGELOG.md) (version `0.2`).

### Changed
- [Evaluation](./docs/semantics/evaluation.md#2-direct-extraction) defines how variables are read: a sequence that is only a context variable that does not exist declares it with no value, a variable that does not exist resolves to `UNKNOWN_SYMBOL_ERROR` (`ENVIRONMENT_ERROR` for `@`), and a variable with no value resolves to `UNDEFINED_ERROR`. The error is propagated to the root of the sequence and aborts the execution.
- **Undefined** has no literal: the `undefined` keyword and the `UNDEFINED` constant are removed from [Literals](./docs/syntax/literals.md#5-undefined) and from the parser. In [Parsing](./docs/semantics/parsing.md), `Undefined` is only a placeholder type of a variable until evaluation.
- `:=` and `?=` in [Operators](./docs/syntax/operators.md) are described in the same way as `INIT` and `COND_SET`.

- Rewrote the descriptive text of `README.md`, [Comparison](./docs/misc/comparison.md) and several introductions in plain language, without marketing phrases.
- The [documentation index](./docs/README.md) lists [Formula](./docs/core/formula.md) and [Validation](./docs/semantics/validation.md).

### Fixed
- [Values](./docs/core/values.md): `Error` was listed as a pass-by-value basic type and the nonexistent `Tuple` type as a complex type.
- [Comparison](./docs/misc/comparison.md): `GT` instead of `GRE`, the nonexistent `REDUCE` function, the old order of the execution stages, and Math.js objects shown as not supported.

## 2026-11-06

Core standard changes of this date are in the [Core changelog](./docs/standards/core/CHANGELOG.md) (version `0.2`).

### Added
- [Argument template](./docs/implementation/argument_template.md): the **Element type** property (`Array<Number>`). An array with an element of another type matches no overload, so the call returns `ARGUMENT_ERROR`, or the first **Error** element. [Evaluation](./docs/semantics/evaluation.md#3-function-call) describes this rule.

### Fixed
- `README.md`: the pipeline order now starts with validation, as in [Execution](./docs/semantics/execution.md). The example used `PRIME`, which no standard defines.
- `argument_collection_template.md`: the `MAX` walkthrough marked the array argument as multiple, `JOIN` used an old optional-argument notation, and an example had a missing parenthesis. `ARRAY` accepts no arguments.
- The comma example in `operators.md` used `SUM(1, 2, 3)`, but `SUM` accepts one array.
- Broken anchors in `functions.md` and `naming.md`, and typos.

## 2026-11-05

Core standard changes of this date are in the [Core changelog](./docs/standards/core/CHANGELOG.md) (version `0.2`).

### Added
- [Validation](./docs/semantics/validation.md) describes the general validation process. The Core algorithm is in [Core Validation](./docs/standards/core/semantics/validation.md).
- Evaluation: sequence result check and error propagation rules.
- Added the `object["key"]` notation (equivalent to `object.key` and `GET(object, "key")`). Object literal keys may be written as identifiers or as text literals (`{ key: 1 }` equals `{ "key": 1 }`); a key that is not a valid identifier or is repeated in the same literal is a `SYNTAX_ERROR`.

### Changed
- The `\#` escape was removed. Clean-up and validation recognize text literals, so `#` is a comment sigil only outside of them; inside a text it is an ordinary character.
- Removed `PAIR` from the object literal translation; `{ k1: a, "k2": b }` now translates to `OBJECT("k1",a,"k2",b)` (alternating keys and values).
- Renamed the terms of the formula processing: the whole process is now called **Execution** (previously *Evaluation*), and its fifth stage is now called **Evaluation** (previously *Computing*). `docs/semantics/evaluation.md` became [execution.md](./docs/semantics/execution.md), and `docs/semantics/computing.md` became [evaluation.md](./docs/semantics/evaluation.md). Pre-evaluation and post-evaluation are now pre-execution and post-execution.
- Rewrote the example in [Evaluation](./docs/semantics/evaluation.md) so that it continues the [Parsing](./docs/semantics/parsing.md#example) example.
- Added a description of named (overload matching) versus anonymous lambda functions to [Functions](./docs/core/functions.md), [Function call](./docs/implementation/function_call.md), [Argument collection template](./docs/implementation/argument_collection_template.md) and [Functions syntax](./docs/syntax/functions.md). A lambda body is parsed once, autonomously, into a stored lambda tree; invoking the lambda only evaluates that tree with the arguments bound to the parameter leaves. A lambda invoked with a wrong number of arguments resolves to `ARGUMENT_ERROR`. Procedures are an explicit exception to the hermetization principle.
- Rewrote [Parsing](./docs/semantics/parsing.md) and [Operator Parsing](./docs/semantics/operator-parsing.md): per-sequence parsing queues, expression trees as a forest, canonical primitive map keys, operand/operator positions, delimiter contexts, sequence boundaries inside delimiters, and extended validation rules.
- `+` is always translated to `ADD`.
- Number tokens no longer include a sign; `-` and `+` are part of a number only as an exponent sign (`1e-3`). Negation is resolved by the parser.
- The tokenizer closes a number at white space and at the end of a line, and emits a `[New line]` token between lines.
- An **Error** no longer aborts the execution as soon as it is created. It is a regular value; the execution is aborted when the root of a sequence returns an **Error** other than `SUCCESS` (or the error becomes `null` when `suppress_errors` is enabled). If no overload matches and an argument is an **Error**, that error is propagated instead of `ARGUMENT_ERROR`. `ISERR` and the `then`/`else` parameters of `IF` receive errors as values.

### Fixed
- Tokenizer: `2+3`, `10-5` and `f(x)-1` were not tokenized correctly; the unreachable duplicate-dot error; swapped letter columns in the decision table.
- Broken links to formula sequences and to the operator length section.
- Parsing example: missing `+` operator in the expression tree, inconsistent queue levels and primitive map keys.
- Assignment operator examples now use the `$` sigil.
- Sigils: examples in `cleanup.md`, `inheritance.md`, `containers.md`, `operators.md`, `functions.md` and the environment documentation now write every variable with `$`/`@` (e.g. `$ x`, `MUL(x, y)`, `MOVE(c, ...)`). Added the sigil rule to `containers.md` and `naming.md`.

## 2026-09-08

### Changed
- Removed the formal split of formulas into environment/context/return sections.
- `$` and `@` sigils now mark individual operands (user and environment variables) instead of entire statement sequences.
- The formula result is now defined as the value of the last evaluated statement, instead of a dedicated return section.
- Standard-defined functions, procedures, and constants (e.g. `SET`, `REQUIRE`, `PI`, `E`) no longer carry a sigil.
- Updated all core, syntax, semantics, and standards documentation/examples to the new sigil and statement model.

## 2026-06-17

### Fixed
- Corrected `CONCAT` result comment in `README.md` example.
- Removed incomplete `$div_result` placeholder from `README.md` example.
- Fixed typo: `extesion` → `extension` in `README.md`.
- Fixed punctuation in `README.md` Reference section.

## 2026-03-16

### Added
- Core elements documentation.
- Syntax documentation.
- Examples.
- [Core standard](./docs/standards/core/) specification.

## 2026-02-16

### Added
- Initial project structure.
- **Spec:** Definition of core syntax (Arithmetic, Logic, Arrays).
- **Spec:** Definition of Simple and Extended dialects.
- **Docs:** Basic `README.md` with examples and project status.
- **Legal:** `LICENSE.txt` (CC BY 4.0).