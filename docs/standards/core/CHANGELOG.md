# Core changelog

Changes of the [**Core**](README.md) standard. Changes of the language itself (syntax, semantics, implementation structures) are in the [main changelog](../../../CHANGELOG.md).

## 0.2 (in progress)

Identifier: `core-0.2`.

### Added
- Function `TEXT` ([TEXT](functions/TEXT.md)), listed in the functions index but previously missing. It returns the [serialized](semantics/serialization.md) value.
- Functions `ISOBJ` and `ISDEL`, listed in the functions index but previously missing. `XOR` is now in the [functions index](functions/README.md).
- Function overload `ADD(Text, Text)`, so the `+` operator also concatenates texts.
- Every function document has an **Algorithm** for each overload and an **Errors** section:
  - Numeric failures return `OPERATION_ERROR`: division by zero, a logarithm of a non-positive number, a root or a power without a real result, a result that is not finite, a precision that is not a whole number, and `CLAMP` with `min` greater than `max`.
  - `ROUND` rounds half away from zero. A negative precision rounds to tens, hundreds, etc. `MOD` has the sign of the dividend.
  - `AVG`, `MAX` and `MIN` of an empty array return `OPERATION_ERROR`. `SUM([])` is `0` and `PROD([])` is `1`.
  - `RANGE` returns `INVALID_INDEX_ERROR` for an index outside of the array and for `first_index` greater than `last_index`.
  - `EQU` and `NEQ` compare arrays and objects by value, and delegates by reference.
  - `FILTER` returns `OPERATION_ERROR` if the lambda returns a value that is not a **Boolean**. `MAX` and `MIN` return it if the handler returns a value that is not a **Number**.
- `SUM`, `PROD`, `AVG`, `MAX` and `MIN` use the `Array<Number>` [element type](../../implementation/argument_template.md#properties). An array with an element of another type matches no overload, so the call returns `ARGUMENT_ERROR`, or the first **Error** element.
- Errors `ENVIRONMENT_ERROR` (code 10) and `NOT_SUPPORTED_ERROR` (code 11, returned by `REQUIRE`).
- Error [`UNDEFINED_ERROR`](errors/UNDEFINED_ERROR.md) (code 12): a context variable that is declared but has no value is being read.
- [Procedures](procedures/README.md) documentation, with a separate document for `SET`, `INIT`, `COND_SET` and `REQUIRE`, including the requirement format of `REQUIRE`. `SET`, `INIT` and `COND_SET` work on both context and environment variables.
- [Validation](semantics/validation.md) algorithm: environment integrity checks and a single-pass scan of the raw formula (symbols, comments, text literals and escape sequences, delimiters) that collects all errors.
- [Parsing](semantics/parsing.md) algorithm (Pratt parser): sequence splitting, prefix and infix steps, function and procedure calls, lambda parameter lists, operator translation table.
- [Types](types/README.md) and [errors](errors/README.md) are documented like functions: an index `README.md` and a separate document for every type and error.
- [Context types](../../core/context.md#context-types): a context type has a base type, context constants and an expected result. The Core standard defines **Default Context** and **Iteration Context** (constants `I`, `N` and `PREV`). `I` follows `@array_indexing`; context variables are not kept between iterations.
- Environment constants `NULL`, `TRUE` and `FALSE` in the Core environment structure and in the validation checks.
- Serialization parameters are environment variables (`decimal_place`, `split_array`, `split_object`, `include_object_class`) and are checked by the validation.
- Serialization variable `max_array_preview`, which abbreviates long arrays: `[1, 2, 3, ..., 99, 100]`.
- Function [`SEQ`](functions/SEQ.md): an array of `n` numbers, `SEQ(n)`, `SEQ(n, step)`, `SEQ(n, step, start)` and `SEQ(n, generator)`. By default, it starts at `@array_indexing`.
- [`MAP`](functions/MAP.md) accepts a lambda with 2 parameters, `(e, i) => ...`, where `i` is the index of the element (following `@array_indexing`).

### Changed
- The version is `0.2` (identifier `core-0.2`). Examples use it instead of `core-1.0`.
- `REQUIRE` version patterns have the segments `n`, `n+` and `x`. A `+` raises only the lower limit of its own segment: `core-0.2+` allows `core-0.5`, but not `core-1.0`. `core-1+` allows `core-1.0` and `core-2.3`.
- `TEXT` has one overload for every base type except **Error**, so an **Error** argument is propagated to the root of the sequence and aborts the execution.
- `MAX` and `MIN`: the array overload is split into `(numbers <Array<Number>>)` and `(elements <Array>, handler <Delegate>)`.
- `ARRAY` accepts no arguments (`ARRAY()` is `[ ]`).
- [**Undefined**](types/Undefined.md) is only the state of a variable that is declared but has no value. It is never a value of an expression: it is never passed to a function, returned by a function or stored in an array or object. The only way to create it is the declaration `$x`. The `undefined` literal and the `UNDEFINED` constant are removed.
- `UNKNOWN_SYMBOL_ERROR` is also returned when a formula reads a context variable or a constant that does not exist.
- `INIT` (`:=`) also stores the value when the variable is declared but has no value.
- The **Loop context** is replaced with the **Iteration Context**.

### Fixed
- `ISERR` could never return `true`, and `IF(c, x, ERROR(...))` always returned an error. `ISERR` and the `then` and `else` parameters of `IF` now receive errors as values.
- Conversion functions: the index used `NUM` instead of `NUMBER`, and `NUMBER` and `TEXT` showed `Boolean` as the return type.
- `XOR`: the signature and the example header used `OR`.
- `EXP` was described as `POW(base, E)`. It is `POW(E, base)`.
- `RANGE`: the Core README said that `last_index` is not included, but the function document and its examples include it.
- The `JOIN` and `SPLIT` rows had an extra table column. `ABS` showed a `| |` operator that the syntax does not define.
- The procedures table showed `SET` twice, once for each scope.
- Environment examples: removed the nonexistent `RETURN` procedure, and replaced `ARRTOSTR(SUPPORTED_STANDARDS)` with `JOIN(STANDARDS, ", ")`.
- Broken relative links in the Core README and the Core examples.
- A wrong key in a [serialization](semantics/serialization.md) example, and typos.

## 0.1 (2026-03-16)

### Added
- First specification of the Core standard: context and environment structure, built-in functions and procedures, types, errors and examples.
