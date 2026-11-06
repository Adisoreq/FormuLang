# Comparison

Comparison of FormuLang with similar formula and expression languages: its strengths, its weaknesses and the main differences.

---

## Strengths

### 1. Application-agnostic standard

FormuLang is a **language specification**, not a library or a feature of one platform. Any parser or interpreter can implement it, in any programming language, and any host application can embed it.

### 2. Pure, deterministic evaluation

Functions have **no side effects** and are **deterministic**: the same arguments always give the same result. Only procedures (`SET`, `INIT`, `COND_SET`) change variables. Formulas are therefore easy to test and to cache, which is important for real-time and financial calculations.

### 3. Formal type system

FormuLang defines the types `Null`, `Boolean`, `Number`, `Text`, `Array`, `Object`, `Delegate` and `Error`, and the `Undefined` state of a variable. Every function documents the types that it accepts and returns. Most embedded formula languages convert types implicitly and do not specify the rules.

### 4. Error-as-value

Errors are **values**, not exceptions. A formula can create an error, check it (`ISERR`) and select another value instead (`IF`). An error that is not handled stops the execution and becomes the result of the formula.

### 5. Clear variable scoping model

The `$` and `@` sigils separate **context variables** (local to an execution) from **environment variables** (provided by the host application). A reader of the formula sees at once which values come from the host.

### 6. Operators as syntactic sugar

All operators (`+`, `-`, `>`, `^`, …) are a short form of named functions (`ADD`, `SUB`, `GRE`, `POW`, …). The parser translates them to function calls, so the evaluation has to handle only function calls.

### 7. Lambda functions

FormuLang supports **anonymous lambda functions** (`(x) => expr`). Functions such as `MAP`, `FILTER`, `MAX` and `MIN` accept them as arguments. Most formula languages do not have lambdas.

### 8. Multi-line, multi-statement formulas

Unlike single-expression formula languages (Excel, Coda), FormuLang supports **formulas with many statements** and named local variables. A long calculation can be split into named steps.

### 9. Well-defined execution pipeline

The six stages of the execution (validation → clean-up → tokenization → parsing → evaluation → finalization) are specified in detail, so different implementations give the same results.

### 10. Open standard

Licensed under **CC BY 4.0**: anyone can implement, extend and redistribute it.

---

## Weaknesses

### 1. Alpha-stage specification

The project is at version **0.1.0-alpha** (Core standard `0.2`). The specification is not stable yet, so breaking changes can still occur.

### 2. No reference implementation

FormuLang is currently **specification-only**. Adopters must write their own parser, which increases the barrier to entry compared to solutions that ship a ready-to-use library.

### 3. No iteration constructs

There are no loops (`for`, `while`, `each`). Iteration uses functions with lambda arguments (`MAP`, `FILTER`), which can be unfamiliar to users of imperative languages.

### 4. No I/O or async capabilities

FormuLang is **stateless and synchronous** by design. There is no file access, no network calls, no timers and no asynchronous execution. Tasks that need side effects must be done by the host application.

### 5. Small ecosystem

There is no package manager, no library beyond the functions of the standards, and no tools (REPL, debugger, linter, IDE plugin) yet.

### 6. No string interpolation

Text values cannot contain expressions (e.g. `"Value is {x}"`). Texts must be joined with `+`, `CONCAT` or `JOIN`.

### 7. Limited error recovery

An **Error** that reaches the root of a sequence aborts the execution, and the error becomes the formula's result (unless `suppress_errors` is enabled). Errors can be handled inside an expression with `ISERR` and `IF`, but there is no mechanism to catch an error for a whole sequence or to return a partial result.

---

## Solutions

### 1. Microsoft Excel Formulas

#### Description

Excel formulas are single-expression, cell-referenced calculations embedded in spreadsheet cells. They are the most widely used formula system, with a large library of built-in functions.

#### Similarities

- Expression-oriented: every formula evaluates to a single result.
- Large library of built-in functions for arithmetic, text, logic and lookup.
- Errors are represented as values (`#DIV/0!`, `#N/A`, `#VALUE!`, …), similar to FormuLang's error-as-value model.
- Supports arrays and array operations (especially in modern Excel with dynamic arrays).

#### Differences

| | FormuLang | Excel Formulas |
| :--- | :--- | :--- |
| **Scope** | Embeddable language standard | Tied to Microsoft Excel / spreadsheet model |
| **Variables** | Named `$` variables | Cell references (A1, B2, …) |
| **Multi-statement** | Yes | No — single expression per cell |
| **Lambda functions** | Yes | Only in Microsoft 365 (`LAMBDA`) |
| **Type system** | Null, Boolean, Number, Text, Array, Object, Error, Undefined | Implicit coercion, no formal type model |
| **Side effects** | None (pure) | Volatile functions (`NOW()`, `RAND()`) allowed |
| **Embeddability** | Designed for embedding | Not embeddable independently |
| **Open standard** | Yes (CC BY 4.0) | Proprietary |

---

### 2. EspoCRM Formula Script

#### Description

EspoCRM Formula is a scripting layer embedded in the EspoCRM platform, used to define field values, validation logic, and automation rules on CRM records.

#### Similarities

- Formula-based evaluation with named variables and built-in functions.
- Context-injected variables provided by the host application.
- Supports conditionals, string operations, and arithmetic.
- Embedded in a host application, not a standalone language.

#### Differences

| | FormuLang | EspoCRM Formula |
| :--- | :--- | :--- |
| **Scope** | General-purpose, application-agnostic | Tightly coupled to EspoCRM data model |
| **Side effects** | None (pure) | Can read and write record fields (`entity\setAttribute`) |
| **Lambda functions** | Yes | No |
| **Type system** | Formal, with Undefined/Error types | Implicit, no formal specification |
| **Multi-platform** | Yes, open standard | No, EspoCRM only |
| **Error handling** | Error-as-value | No structured error type |
| **Standard** | Open, versioned specification | Undocumented internals |

---

### 3. TradingView Pine Script

#### Description

Pine Script is TradingView's domain-specific language for creating custom technical indicators and trading strategies. It is designed around the concept of iterating over historical price bars (candles).

#### Similarities

- Mathematical and statistical operations on numerical series (arrays).
- Scoped variables and named functions.
- Expression-oriented computation producing a single result per bar.
- Planned **Stock Extension** in FormuLang covers the same indicator use case (`SMA`, `CLOSE`, `OPEN`, `VOLUME`, candle objects).

#### Differences

| | FormuLang | Pine Script |
| :--- | :--- | :--- |
| **Scope** | General-purpose embeddable standard | Financial charting DSL |
| **Execution model** | Single stateless execution | Implicit loop over historical bars |
| **Persistent state** | Optional persistent context | Built-in (`var`, `varip`), state persists across bars |
| **Visual output** | None | Native plotting (`plot`, `barcolor`, `label.new`, …) |
| **Side effects** | None | Order execution, alerts, drawings |
| **Embeddability** | Yes | TradingView platform only |
| **Lambda functions** | Yes | No |
| **Open standard** | Yes | Proprietary |

---

### 4. Math.js Expressions

#### Description

Math.js is a JavaScript library that provides a parser for mathematical expressions. It is widely used for building calculators and scientific tools in browser and Node.js environments.

#### Similarities

- Embeddable expression evaluator aimed at mathematical calculations.
- Operators map to underlying functions (similar to FormuLang's operator-as-sugar model).
- Supports complex numbers, matrices (analogous to FormuLang `Array`), units, and symbolic math.
- Deterministic, pure expression evaluation.

#### Differences

| | FormuLang | Math.js Expressions |
| :--- | :--- | :--- |
| **Nature** | Language standard (multi-implementable) | JavaScript library (single implementation) |
| **Type system** | Null, Boolean, Number, Text, Array, Object, Error, Undefined | Number, BigNumber, Complex, Matrix, Unit, string |
| **Text operations** | Basic text functions (`TRIM`, `SPLIT`, `JOIN`, …) | Minimal |
| **Object type** | Yes (`{ key: value }`) | Yes (`{ key: value }`) |
| **Lambda functions** | Yes | Limited (arrow functions in scope) |
| **Error handling** | Error-as-value | Thrown JavaScript exceptions |
| **Host integration** | Formal context/environment model | Scope object passed to `evaluate()` |
| **Multi-statement** | Yes | Yes (via semicolons) |
| **Open standard** | Yes (CC BY 4.0) | Open source library (Apache 2.0), not a standard |

---

### 5. Coda Formulas

#### Description

Coda is a document platform that exposes a formula language for computed columns, buttons, and automation. Its formula syntax is inspired by spreadsheet formulas and functional programming.

#### Similarities

- Expression-oriented: every formula returns a single value.
- Many built-in functions for text, numbers, lists and dates.
- Supports list (array) operations with functional patterns.
- Deterministic evaluation, with no side effects in pure formulas.

#### Differences

| | FormuLang | Coda Formulas |
| :--- | :--- | :--- |
| **Scope** | General-purpose embeddable standard | Coda platform only |
| **Lambda / higher-order** | Native lambda functions | Anonymous formula blocks in some list functions |
| **Type system** | Formal specification | Implicit, platform-defined |
| **Host integration** | Formal context (`$`) and environment (`@`) model | Table rows and columns as implicit context |
| **Multi-statement** | Yes | No, single expression |
| **Open standard** | Yes (CC BY 4.0) | Proprietary |
| **Error type** | First-class `Error` value | Propagated automatically, not first-class |

---

## Summary table

| Feature | FormuLang | Excel | EspoCRM | Pine Script | Math.js | Coda |
| :--- | :---: | :---: | :---: | :---: | :---: | :---: |
| Embeddable / app-agnostic | ✅ | ❌ | ❌ | ❌ | ✅ | ❌ |
| Open standard | ✅ | ❌ | ❌ | ❌ | ❌ | ❌ |
| Pure / side-effect-free | ✅ | ⚠️ | ❌ | ❌ | ✅ | ✅ |
| Lambda functions | ✅ | ⚠️ | ❌ | ❌ | ⚠️ | ⚠️ |
| Error-as-value | ✅ | ✅ | ❌ | ❌ | ❌ | ⚠️ |
| Multi-statement formulas | ✅ | ❌ | ⚠️ | ✅ | ✅ | ❌ |
| Formal type system | ✅ | ❌ | ❌ | ⚠️ | ⚠️ | ❌ |
| Object type | ✅ | ❌ | ❌ | ❌ | ✅ | ❌ |
| Persistent state | ❌ | ✅ | ✅ | ✅ | ❌ | ✅ |
| Production-ready | ❌ | ✅ | ✅ | ✅ | ✅ | ✅ |

> ✅ Supported &nbsp;|&nbsp; ⚠️ Partial / limited &nbsp;|&nbsp; ❌ Not supported

---

## Reference

- [Microsoft Excel Formulas](https://support.microsoft.com/en-us/office/formulas-and-functions-294d9486-b332-48ed-b489-abe7d0f9eda9)
- [EspoCRM Formula script](https://docs.espocrm.com/administration/formula/)
- [TradingView Pine Script](https://www.tradingview.com/pine-script-docs/)
- [Math.js Expressions](https://mathjs.org/docs/expressions/)
- [Coda Formulas](https://coda.io/formulas)