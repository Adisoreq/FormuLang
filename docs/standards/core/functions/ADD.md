# ADD

Arithmetical [**Core**](../README.md) standard function. Returns the sum of 2 numbers or the concatenation of 2 texts. Operator form: `a + b`.

## Overloads

### Overload 1: Numbers

Signature: `ADD(a <Number>, b <Number>)`

Collection template:

| # | Name |   | Base type | Extended type | Any type | Multiple | Optional |
| - | :--: | - | :-------: | :-----------: | :------: | :------: | :------: |
| 1 | a | | Number | - | false | false | false |
| 2 | b | | Number | - | false | false | false |

Algorithm:

- Returns the sum `a + b`

Examples:

|  a  |  b  | ADD(a, b) |
| :-: | :-: | :-------: |
| 10 | 20 | 30 |
| -4 | 4 | 0 |
| 0.2 | 2.3 | 2.5 |

### Overload 2: Texts

Signature: `ADD(text1 <Text>, text2 <Text>)`

Joins two text strings together. Equivalent to [CONCAT](CONCAT.md).

Collection template:

| # | Name |   | Base type | Extended type | Any type | Multiple | Optional |
| - | :--: | - | :-------: | :-----------: | :------: | :------: | :------: |
| 1 | text1 | | Text | - | false | false | false |
| 2 | text2 | | Text | - | false | false | false |

Algorithm:

- Returns a new **Text** that contains the characters of `text1` followed by the characters of `text2`

Examples:

| text1 | text2 | ADD(text1, text2) |
| :-: | :-: | :-------: |
| "Hello, " | "world!" | "Hello, world!" |
| "" | "test" | "test" |


## Errors

- [`OPERATION_ERROR`](../errors/OPERATION_ERROR.md) - the result is not a finite number (for example, it is too large).
- [`ARGUMENT_ERROR`](../errors/ARGUMENT_ERROR.md) - the arguments match no overload. If one of the arguments is an **Error**, that **Error** is returned instead (see [Evaluation](../../../semantics/evaluation.md#3-function-call)).


## Reference

- [Core standard](../README.md)