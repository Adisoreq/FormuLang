# TEXT

Conversion [**Core**](../README.md) standard function. Converts provided value to `Text`.

The result is the [serialized](../semantics/serialization.md) form of the value, created with the default serialization parameters.

`TEXT` has a separate overload for every base type except **Error**. An **Error** argument matches no overload, so it is propagated (see [Evaluation](../../../semantics/evaluation.md#3-function-call)): it reaches the root of the sequence and aborts the execution, unless a function that accepts **Any type** handles it first.

## Overloads

### Overload 1

Signature: `TEXT(value <Null>)`

Collection template:

| # | Name |   | Base type | Extended type | Any type | Multiple | Optional |
| - | :--: | - | :-------: | :-----------: | :------: | :------: | :------: |
| 1 | value | | Null | - | false | false | false |

Algorithm:

- Always returns `"null"`

---

### Overload 2

Signature: `TEXT(value <Boolean>)`

Collection template:

| # | Name |   | Base type | Extended type | Any type | Multiple | Optional |
| - | :--: | - | :-------: | :-----------: | :------: | :------: | :------: |
| 1 | value | | Boolean | - | false | false | false |

Algorithm:

- Returns `"true"` if value is `true` or `"false"` if value is `false`

---

### Overload 3

Signature: `TEXT(value <Number>)`

Collection template:

| # | Name |   | Base type | Extended type | Any type | Multiple | Optional |
| - | :--: | - | :-------: | :-----------: | :------: | :------: | :------: |
| 1 | value | | Number | - | false | false | false |

Algorithm:

- Returns the decimal notation of the number, without trailing zeros ([Number values](../semantics/serialization.md#number-values), `decimal_place` = `-1`)

---

### Overload 4

Signature: `TEXT(value <Text>)`

Collection template:

| # | Name |   | Base type | Extended type | Any type | Multiple | Optional |
| - | :--: | - | :-------: | :-----------: | :------: | :------: | :------: |
| 1 | value | | Text | - | false | false | false |

Algorithm:

- Returns the value

---

### Overload 5

Signature: `TEXT(value <Array>)`

Collection template:

| # | Name |   | Base type | Extended type | Any type | Multiple | Optional |
| - | :--: | - | :-------: | :-----------: | :------: | :------: | :------: |
| 1 | value | | Array | - | false | false | false |

Algorithm:

- Returns the serialized array ([Array values](../semantics/serialization.md#array-values), `split_array` = `false`)

---

### Overload 6

Signature: `TEXT(value <Object>)`

Collection template:

| # | Name |   | Base type | Extended type | Any type | Multiple | Optional |
| - | :--: | - | :-------: | :-----------: | :------: | :------: | :------: |
| 1 | value | | Object | - | false | false | false |

Algorithm:

- Returns the serialized object ([Object values](../semantics/serialization.md#object-values), `split_object` = `false`, `include_object_class` = `false`)

---

### Overload 7

Signature: `TEXT(value <Delegate>)`

Collection template:

| # | Name |   | Base type | Extended type | Any type | Multiple | Optional |
| - | :--: | - | :-------: | :-----------: | :------: | :------: | :------: |
| 1 | value | | Delegate | - | false | false | false |

Algorithm:

- Returns the serialized delegate ([Delegate values](../semantics/serialization.md#delegate-values))


## Examples

| value | TEXT(value) |
| :-: | :-------: |
| null | "null" |
| true | "true" |
| 25 | "25" |
| -12.0 | "-12" |
| "abc" | "abc" |
| [ 1, 2, 3 ] | "[1, 2, 3]" |
| { name: "John", age: 24 } | "{ name: \"John\", age: 24 }" |
| AVG | "AVG(args) => any" |
| `ERROR("Invalid")` | `Error`: "Invalid" (propagated) |


## Errors

- [`ARGUMENT_ERROR`](../errors/ARGUMENT_ERROR.md) - the value has a base type that no overload accepts. If the value is an **Error**, that **Error** is returned instead (see [Evaluation](../../../semantics/evaluation.md#3-function-call)).


## Reference

- [Serialization](../semantics/serialization.md)
- [Evaluation](../../../semantics/evaluation.md#3-function-call)
- [Text](../types/Text.md)
- [BOOL](BOOL.md)
- [NUMBER](NUMBER.md)
- [Core standard](../README.md)
