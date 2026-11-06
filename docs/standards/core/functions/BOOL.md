# BOOL

Conversion [**Core**](../README.md) standard function. Converts provided value to `Boolean`.


## Overloads

### Overload 1

Signature: `BOOL(value <Null>)`

Collection template:

| # | Name |   | Base type | Extended type | Any type | Multiple | Optional |
| - | :--: | - | :-------: | :-----------: | :------: | :------: | :------: |
| 1 | value | | Null | - | false | false | false |

Algorithm:

- Always returns `false`

Example:

| value | BOOL(value) |
| :-: | :-------: |
| null | false |

---

### Overload 2

Signature: `BOOL(value <Boolean>)`

Collection template:

| # | Name |   | Base type | Extended type | Any type | Multiple | Optional |
| - | :--: | - | :-------: | :-----------: | :------: | :------: | :------: |
| 1 | value | | Boolean | - | false | false | false |

Algorithm:

- Returns value

Example:

| value | BOOL(value) |
| :-: | :-------: |
| false | false |
| true | true |

---

### Overload 3

Signature: `BOOL(value <Number>)`

Collection template:

| # | Name |   | Base type | Extended type | Any type | Multiple | Optional |
| - | :--: | - | :-------: | :-----------: | :------: | :------: | :------: |
| 1 | value | | Number | - | false | false | false |

Algorithm:

- Returns `false` if provided value is 0 or `true` if otherwise

Examples:

| value | BOOL(value) |
| :-: | :-------: |
| 0 | false |
| 25 | true |
| -0.4 | true |

---

### Overload 4

Signature: `BOOL(value <Text>)`

Collection template:

| # | Name |   | Base type | Extended type | Any type | Multiple | Optional |
| - | :--: | - | :-------: | :-----------: | :------: | :------: | :------: |
| 1 | value | | Text | - | false | false | false |

Algorithm:

- Returns `false` if provided text value is empty or `true` if otherwise

Examples:

| value | BOOL(value) |
| :-: | :-------: |
| "" | false |
| "false" | true |
| "true" | true |
| "This text is not empty!" | true |

---

### Overload 5

Signature: `BOOL(value <Array>)`

Collection template:

| # | Name |   | Base type | Extended type | Any type | Multiple | Optional |
| - | :--: | - | :-------: | :-----------: | :------: | :------: | :------: |
| 1 | value | | Array | - | false | false | false |

Algorithm:

- Returns `false` if provided array is empty or `true` if otherwise

Examples:

| value | BOOL(value) |
| :-: | :-------: |
| [ ] | false |
| [ 2, 4, 8, 16 ] | true |

---

### Overload 6

Signature: `BOOL(value <Object>)`

Collection template:

| # | Name |   | Base type | Extended type | Any type | Multiple | Optional |
| - | :--: | - | :-------: | :-----------: | :------: | :------: | :------: |
| 1 | value | | Object | - | false | false | false |

Algorithm:

- Returns `false` if provided object is empty or `true` if otherwise

Examples:

| value | BOOL(value) |
| :-: | :-------: |
| { } | false |
| { name: "OBJECT", empty: false } | true |


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
