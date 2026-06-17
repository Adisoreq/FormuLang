# Comparison

Comparison of FormuLang against similar formula and expression languages — covering its strengths, weaknesses, and key differentiators.

---

## Strengths

### 1. Application-agnostic standard

FormuLang is a **language specification**, not a library or platform feature. It can be implemented by any parser/interpreter and embedded into any host application, without being tied to a specific runtime or ecosystem.

### 2. Pure, deterministic evaluation

Functions are strictly **side-effect-free and deterministic**: the same input always produces the same output. This makes formulas easy to test, cache, and reason about, which is critical for real-time and financial use cases.

### 3. Rich type system

FormuLang defines a broad set of types: `Null`, `Boolean`, `Number`, `Text`, `Array`, `Object`, `Error`, `Undefined`, and lambda functions. This exceeds the type coverage of most embedded formula systems.

### 4. Error-as-value

Errors are **first-class values**, not thrown exceptions. Formulas can produce, inspect, and propagate error values gracefully without crashing evaluation — enabling robust error handling directly in expressions.

### 5. Clear variable scoping model

The `$`/`@` sigil convention formally separates **context variables** (local to an evaluation) from **environment variables** (provided globally by the host application). This makes integration contracts explicit and predictable.

### 6. Operators as syntactic sugar

All infix operators (`+`, `-`, `>`, `^`, …) are defined as shorthand for named functions (`ADD`, `SUB`, `GT`, `POW`, …). This unifies the function and operator models, simplifying parser implementation and reasoning about precedence.

### 7. Lambda functions

FormuLang natively supports **anonymous lambda functions** (`(x) => expr`), enabling higher-order operations such as `FILTER`, `MAP`, and `REDUCE` — a feature absent from most formula systems.

### 8. Multi-line, multi-statement formulas

Unlike single-expression formula languages (Excel, Math.js), FormuLang supports **multi-statement formulas** with named local variables, making complex logic readable and maintainable.

### 9. Well-defined evaluation pipeline

The six-stage pipeline (cleanup → tokenization → parsing → validation → computation → finalization) is formally specified, giving implementors a clear contract and making behaviour auditable.

### 10. Open standard

Licensed under **CC BY 4.0** — free to implement, extend, and redistribute.

---

## Weaknesses

### 1. Alpha-stage specification

The project is at **v0.1.0-alpha**. The specification is not yet stable; breaking changes may still occur, and no production-ready reference implementation exists yet.

### 2. No reference implementation

FormuLang is currently **specification-only**. Adopters must write their own parser, which increases the barrier to entry compared to solutions that ship a ready-to-use library.

### 3. No iteration constructs

There are no loop primitives (`for`, `while`, `each`). Iteration relies on functional higher-order functions (`MAP`, `FILTER`, `REDUCE`), which may feel unfamiliar to users coming from imperative languages.

### 4. No I/O or async capabilities

FormuLang is intentionally **stateless and synchronous**. There is no file access, network calls, timers, or async evaluation — by design, but this limits use cases that require side-effecting operations.

### 5. Small ecosystem

No package manager, no standard library beyond built-in functions, no community tooling (REPL, debugger, linter, IDE plugin) yet.

### 6. No string interpolation

Text values cannot embed expressions inline (e.g., `"Value is {x}"`). Concatenation must be done explicitly via functions like `CONCAT`.

### 7. Limited error recovery

Evaluation is all-or-nothing per formula. There is no mechanism to partially evaluate a formula and skip only the failing sub-expression.

---

## Solutions

### 1. Microsoft Excel Formulas

#### Description

Excel formulas are single-expression, cell-referenced calculations embedded in spreadsheet cells. They are the most widely used formula system in the world, with a large built-in function library.

#### Similarities

- Expression-oriented: every formula evaluates to a single result.
- Rich built-in function library covering arithmetic, text, logic, and lookup operations.
- Errors are represented as values (`#DIV/0!`, `#N/A`, `#VALUE!`, …), similar to FormuLang's error-as-value model.
- Supports arrays and array operations (especially in modern Excel with dynamic arrays).

#### Differences

| | FormuLang | Excel Formulas |
| :--- | :--- | :--- |
| **Scope** | Embeddable language standard | Tied to Microsoft Excel / spreadsheet model |
| **Variables** | Named `$` variables | Cell references (A1, B2, …) |
| **Multi-statement** | Yes | No — single expression per cell |
| **Lambda functions** | Yes (native) | Limited — Excel 365 introduced `LAMBDA` recently |
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
- Designed to be embedded — not a standalone language.

#### Differences

| | FormuLang | EspoCRM Formula |
| :--- | :--- | :--- |
| **Scope** | General-purpose, application-agnostic | Tightly coupled to EspoCRM data model |
| **Side effects** | None (pure) | Can read and write record fields (`entity\setAttribute`) |
| **Lambda functions** | Yes | No |
| **Type system** | Formal, with Undefined/Error types | Implicit, no formal specification |
| **Multi-platform** | Yes — open standard | No — EspoCRM-only |
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
| **Execution model** | Single stateless evaluation | Implicit loop over historical bars |
| **Persistent state** | None | Built-in (`var`, `varip`) — state persists across bars |
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
| **Text operations** | Rich text functions | Minimal |
| **Object type** | Yes (`{ key: value }`) | No |
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
- Rich built-in functions for text, numbers, lists, dates.
- Supports list (array) operations with functional patterns.
- Deterministic evaluation — no side effects in pure formulas.

#### Differences

| | FormuLang | Coda Formulas |
| :--- | :--- | :--- |
| **Scope** | General-purpose embeddable standard | Coda platform only |
| **Lambda / higher-order** | Native lambda functions | Anonymous formula blocks in some list functions |
| **Type system** | Formal specification | Implicit, platform-defined |
| **Host integration** | Formal context (`$`) and environment (`@`) model | Table rows and columns as implicit context |
| **Multi-statement** | Yes | No — single expression |
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
| Object type | ✅ | ❌ | ❌ | ❌ | ❌ | ❌ |
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