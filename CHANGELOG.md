# Changelog

Main language changes: syntax, semantics and implementation structures.

Changes of the standards are in their own changelogs, e.g. the [Core changelog](./docs/standards/core/CHANGELOG.md). The list of standards is on the [standards](./docs/standards) page.

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