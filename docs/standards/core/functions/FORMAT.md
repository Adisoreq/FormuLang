# FORMAT

Text [**Core**](../README.md) standard function. Builds a text from a template by replacing its placeholders with values.

## Template syntax

A **template** is a **Text** in which every pair of braces `{ }` is a **placeholder**. Every other character is copied to the result unchanged.

| Placeholder | Description | Values |
| :---------- | :---------- | :----- |
| `{}` | The next element of the array: the first `{}` takes the first element, the second `{}` the second element, and so on. | Array |
| `{index}` | The element of the array at `index` (a whole number, follows `@array_indexing`, like [`GET`](GET.md)). The same element can be used many times. | Array |
| `{key}` | The value of the object at `key` (a key following the [identifier naming restrictions](../../../syntax/naming.md#naming-restrictions)). | Object |
| `{{` / `}}` | A literal `{` / `}` character. | any |

A placeholder may end with a **format specifier**, separated by a colon (`:`):

| Specifier | Description | Example |
| :-------- | :---------- | :------ |
| *(none)* | The value is converted with [`TEXT`](TEXT.md), so the [serialization variables](../README.md#3-serialization-variables) apply. | `{}` with `12.5` → `12.5` |
| `.n` | Only for a **Number**: the number is rounded to `n` decimal places (`n` is a whole number from `0`), with the same rule as [`ROUND`](ROUND.md), and always written with exactly `n` decimal places. `@decimal_place` is ignored. | `{:.2}` with `12.5` → `12.50` |

Specifiers can be used with every kind of placeholder: `{:.2}`, `{0:.2}`, `{price:.2}`.

Rules:

- A template uses either `{}` or `{index}` placeholders, not both. Mixing them is an `OPERATION_ERROR`.
- `{}` and `{index}` require an **Array**, `{key}` requires an **Object**.
- Elements of the array that are not used by the template are ignored.
- White space inside braces is not allowed: `{ 0 }` is an `OPERATION_ERROR`.

## Overloads

### Overload 1: Array values

Signature: `FORMAT(template <Text>, values <Array>)`

Collection template:

| # | Name |   | Base type | Extended type | Any type | Multiple | Optional |
| - | :--: | - | :-------: | :-----------: | :------: | :------: | :------: |
| 1 | template | | Text | - | false | false | false |
| 2 | values | | Array | - | false | false | false |

Algorithm:

1. Reads `template` from the first to the last character and builds the result:
   1. `{{` appends `{`, and `}}` appends `}`.
   2. `{` opens a placeholder, which ends at the next `}`. A `{` without a closing `}`, or a single `}` outside a placeholder, returns an `OPERATION_ERROR`.
   3. The content of a placeholder is split at the first `:` into a **selector** and a **specifier**.
   4. The selector selects the value:
      - empty: the next unused position of the sequential counter, starting with the first element of `values`;
      - a whole number: the element of `values` at that index (the index follows `@array_indexing`);
      - anything else (for example a key): returns an `OPERATION_ERROR`.
   5. If the template has both an empty selector and a number selector, returns an `OPERATION_ERROR`.
   6. If the selected index is outside of `values`, returns an `INVALID_INDEX_ERROR`.
   7. If the selected value is an **Error**, returns that **Error**.
   8. The value is converted to **Text** according to the specifier (see [Template syntax](#template-syntax)) and appended. A specifier other than `.n`, or `.n` used with a value that is not a **Number**, returns an `OPERATION_ERROR`.
2. Returns the result.

Examples (with `@array_indexing` = `0`):

| template | values | FORMAT(template, values) |
| :------- | :----- | :----------------------- |
| `"Mam {} jablek i {} gruszek."` | `[ 10, 5 ]` | `"Mam 10 jablek i 5 gruszek."` |
| `"{1} before {0}"` | `[ "a", "b" ]` | `"b before a"` |
| `"{0}{0}{0}"` | `[ "ha" ]` | `"hahaha"` |
| `"Price: {:.2} zł"` | `[ 12.5 ]` | `"Price: 12.50 zł"` |
| `"{:.0}%"` | `[ 99.5 ]` | `"100%"` |
| `"Set: {{{}}}"` | `[ 7 ]` | `"Set: {7}"` |
| `"{} and {}"` | `[ [1, 2], true ]` | `"[1, 2] and true"` |
| `"No placeholders"` | `[ 1 ]` | `"No placeholders"` |
| `"{} {}"` | `[ 1 ]` | `[INVALID_INDEX_ERROR (7)] ...` |
| `"{} {1}"` | `[ 1, 2 ]` | `[OPERATION_ERROR (3)] ...` |
| `"{:.2}"` | `[ "text" ]` | `[OPERATION_ERROR (3)] ...` |
| `"{"` | `[ 1 ]` | `[OPERATION_ERROR (3)] ...` |

### Overload 2: Object values

Signature: `FORMAT(template <Text>, values <Object>)`

Collection template:

| # | Name |   | Base type | Extended type | Any type | Multiple | Optional |
| - | :--: | - | :-------: | :-----------: | :------: | :------: | :------: |
| 1 | template | | Text | - | false | false | false |
| 2 | values | | Object | - | false | false | false |

Algorithm:

- The same as in [Overload 1](#overload-1-array-values), except for the selector:
  - a key following the identifier naming restrictions: the value of `values` at that key. If `values` has no such key, returns an `INVALID_KEY_ERROR`;
  - empty, a number or anything else: returns an `OPERATION_ERROR`.

Examples:

| template | values | FORMAT(template, values) |
| :------- | :----- | :----------------------- |
| `"{name} ma {age} lat"` | `{ name: "Ola", age: 24 }` | `"Ola ma 24 lat"` |
| `"{x:.1}, {y:.1}"` | `{ x: 1, y: 2.25 }` | `"1.0, 2.3"` |
| `"{name}"` | `{ }` | `[INVALID_KEY_ERROR (8)] ...` |
| `"{}"` | `{ a: 1 }` | `[OPERATION_ERROR (3)] ...` |

## Errors

- [`OPERATION_ERROR`](../errors/OPERATION_ERROR.md) - the template is not correct: an unclosed `{`, a single `}`, `{}` mixed with `{index}`, a selector that does not match the type of `values`, or a wrong specifier.
- [`INVALID_INDEX_ERROR`](../errors/INVALID_INDEX_ERROR.md) - an index outside of the array, or more `{}` placeholders than elements.
- [`INVALID_KEY_ERROR`](../errors/INVALID_KEY_ERROR.md) - a key that the object does not have.
- An **Error** selected by a placeholder is returned unchanged.
- [`ARGUMENT_ERROR`](../errors/ARGUMENT_ERROR.md) - the arguments match no overload. If one of the arguments is an **Error**, that **Error** is returned instead (see [Evaluation](../../../semantics/evaluation.md#3-function-call)).

## Reference

- [Core standard](../README.md)
- [`TEXT`](TEXT.md)
- [`JOIN`](JOIN.md)
- [Serialization](../semantics/serialization.md)
