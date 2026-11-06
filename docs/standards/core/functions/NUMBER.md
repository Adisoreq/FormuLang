# NUMBER

Conversion [**Core**](../README.md) standard function. Converts provided value to `Number`.

## Overloads

### Overload 1

Signature: `NUMBER(value <Null>)`

Collection template:

| # | Name |   | Base type | Extended type | Any type | Multiple | Optional |
| - | :--: | - | :-------: | :-----------: | :------: | :------: | :------: |
| 1 | value | | Null | - | false | false | false |

Algorithm:

- Always returns `0`

Example:

| value | NUMBER(value) |
| :-: | :-------: |
| null | 0 |

---

### Overload 2

Signature: `NUMBER(value <Boolean>)`

Collection template:

| # | Name |   | Base type | Extended type | Any type | Multiple | Optional |
| - | :--: | - | :-------: | :-----------: | :------: | :------: | :------: |
| 1 | value | | Boolean | - | false | false | false |

Algorithm:

- Returns `0` if value is `false` or `1` if value is `true`

Example:

| value | NUMBER(value) |
| :-: | :-------: |
| false | 0 |
| true | 1 |

---

### Overload 3

Signature: `NUMBER(value <Number>)`

Collection template:

| # | Name |   | Base type | Extended type | Any type | Multiple | Optional |
| - | :--: | - | :-------: | :-----------: | :------: | :------: | :------: |
| 1 | value | | Number | - | false | false | false |

Algorithm:

- Returns the value

Examples:

| value | NUMBER(value) |
| :-: | :-------: |
| 0 | 0 |
| 25 | 25 |
| -0.4 | -0.4 |

---

### Overload 4

Signature: `NUMBER(value <Text>)`

Collection template:

| # | Name |   | Base type | Extended type | Any type | Multiple | Optional |
| - | :--: | - | :-------: | :-----------: | :------: | :------: | :------: |
| 1 | value | | Text | - | false | false | false |

Algorithm:

- Tries to parse text into number
  - If text content is a valid number, returns it
  - If text content is not a valid number, returns `0`

Examples:

| value | NUMBER(value) |
| :-: | :-------: |
| "" | 0 |
| "2.15" | 2.15 |
| "2.99792458e+8" | 299792458 |
| "zero" | 0 |
| "two" | 0 |


## Errors

- [`ARGUMENT_ERROR`](../errors/ARGUMENT_ERROR.md) - the value has a base type that no overload accepts. If the value is an **Error**, that **Error** is returned instead (see [Evaluation](../../../semantics/evaluation.md#3-function-call)).


## Reference

- [Null](../types/Null.md)
- [Boolean](../types/Boolean.md)
- [Number](../types/Number.md)
- [Text](../types/Text.md)
- [Array](../types/Array.md)
- [Object](../types/Object.md)
- [Core standard](../README.md)
