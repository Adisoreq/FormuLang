# FormuLang Core

**FormuLang** **Core** standard documentation.


## Basic information

**Name**: `Core`

**Latest version**: `0.2`

**Identifier**: `core-0.2`

**Description**: Elementary standard defining core **FormuLang** concepts and structures. Basis of every other extension.

The Core [validation](semantics/validation.md) and [parsing](semantics/parsing.md) algorithms define how formulas are validated and parsed.

Changes between versions: [Core changelog](CHANGELOG.md).

## Context structure

### 1. Context types

The **Core** standard defines two [context types](../../core/context.md#context-types):

| Context type | Base type | Context constants | Expected result |
| :----------- | :-------- | :---------------- | :-------------- |
| [Default Context](../../core/context.md#1-default-context) | - | none | any value |
| [Iteration Context](../../core/context.md#2-iteration-context) | Default Context | `I`, `N`, `PREV` | any value |

### 2. Context constants

| Constant | Context type | Type | Description |
| :------- | :----------- | :--: | :---------- |
| `I` | Iteration Context | `Number` | Index of the current iteration. Follows `@array_indexing`: the first iteration is `@array_indexing`. |
| `N` | Iteration Context | `Number` | Number of iterations. Does not depend on `@array_indexing`. |
| `PREV` | Iteration Context | `Any` | Result of the previous iteration, `null` in the first iteration. |

### 3. Context variables

All context variables are defined by user.

## Environment structure

### 1. Environment constants

| Constant | Type | Initial value | Description |
| :------- | :--: | :------------ | :---------- |
| `STANDARDS` | `Array` | `[ "core-0.2" ]` | Stores the array of supported standards' identifiers. |
| `E` | `Number` | `2.718281828459045` | Euler's number. Used in calculus, compound interest, and exponential growth calculations. |
| `PI` | `Number` | `3.141592653589793` | Ratio of a circle's circumference to its diameter. Used in geometry and trigonometry. |
| `PHI` | `Number` | `1.618033988749894` | Golden ratio. |
| `NULL` | `Null` | `null` | Null value. Equivalent of the `null` literal. |
| `TRUE` | `Boolean` | `true` | Equivalent of the `true` literal. |
| `FALSE` | `Boolean` | `false` | Equivalent of the `false` literal. |

### 2. Environment variables

| Variable | Type | Initial value | Description |
| :------- | :--: | :------------ | :---------- |
| `array_indexing` | `Number` | `0` | Base of access-by-index array operations. When accessing the array element, the variable's value is subtracted from target index. Usable in solutions for users, who are not familiar with 0-based indexing. |
| `suppress_errors` | `Boolean` | `false` | Prevents aborting the execution: an **Error** (other than `SUCCESS`) returned by the root of a sequence is turned into a `null` value and the execution continues. |

### 3. Serialization variables

Environment variables that control [serialization](semantics/serialization.md#serialization-parameters) (e.g. the `TEXT` function and console display).

| Variable | Type | Initial value | Description |
| :------- | :--: | :------------ | :---------- |
| `decimal_place` | `Number` | `-1` | Decimal place at which serialized numbers end. A negative value does not limit the notation. |
| `split_array` | `Boolean` | `false` | Places every serialized array element in a new line. |
| `split_object` | `Boolean` | `false` | Places every serialized key-value pair in a new line. |
| `include_object_class` | `Boolean` | `false` | Precedes serialized objects with their class notation. |
| `max_array_preview` | `Number` | `-1` | Maximal number of serialized array elements. Longer arrays are abbreviated with ` ... `. A negative value does not limit arrays. |


## Built-in Procedures

Procedures are part of the **Core** standard. They operate on context or environment state; they are not stored in either structure. Details: [Core procedures](procedures/README.md).

| Procedure | Scope | Description | Example | Equivalent |
| :-------- | :---- | :---------- | :------ | :--------- |
| [`SET`](procedures/SET.md) | Context, Environment | Overrides a variable. Environment variables are overridden only for the current execution. | `SET $result 100` | `$result = 100` |
| [`INIT`](procedures/INIT.md) | Context, Environment | Initializes a variable only if it does not exist yet or has no value. | `INIT $result 100` | `$result := 100` |
| [`COND_SET`](procedures/COND_SET.md) | Context, Environment | Overrides a variable only if it already exists. | `COND_SET $result 100` | `$result ?= 100` |
| [`REQUIRE`](procedures/REQUIRE.md) | Environment | Ensures that the environment supports the requested standard. | `REQUIRE "core-0.x"` | |


## Built-in Functions

### 1. Arithmetic Functions

Functions responsible for mathematical calculations on **Number** values.

| Function | Operator | Description | Return Type |
| :------- | :------: | :---------- | :---------: |
| `ADD(a, b)` | `+` | Adds two numbers or joins two texts. | `Number` / `Text` |
| `SUB(a, b)` | `-` | Subtracts the second number from the first. | `Number` |
| `MUL(a, b)` | `*` | Multiplies two numbers. | `Number` |
| `DIV(a, b)` | `/` | Divides the first number by the second. | `Number` |
| `MOD(a, b)` | `%` | Returns the remainder of division. | `Number` |
| `POW(base, exp)` | `^` | Raises base to the power of exponent. | `Number` |
| `EXP(base)` | | Raises Euler's number `E` to the power of `base`. Alias for `POW(E, base)`. | `Number` |
| `ROOT(num, n)` | | Calculates the n-th root of a number. | `Number` |
| `SQRT(num)` | | Calculates the square root. Alias for `ROOT(num, 2)`. | `Number` |
| `LOG(value, base)` | | Calculates the logarithm of value with specified base. | `Number` |
| `LN(value)` | | Calculates the natural logarithm of value. Alias for `LOG(value, E)` | `Number` |
| `ABS(num)` | | Returns the absolute value. | `Number` |
| `NEG(num)` | `-` | Negates the number. | `Number` |
| `CEIL(number, precision)` | | Rounds the number up to the specific precision. | `Number` |
| `FLOOR(number, precision)` | | Rounds the number down to the specific precision. | `Number` |
| `ROUND(number, precision)` | | Rounds the number automatically to the specific precision. | `Number` |
| `CLAMP(value, min, max)` | | Clamps the value to the range between min and max. | `Number` |

### 2. Logic & Comparison Functions

Functions that evaluate conditions and return **Boolean** values.

| Function | Operator | Description | Parameter Type | Return Type |
| :------- | :------: | :---------- | :------------- | :---------: |
| `AND(a, b)` | `&&` | Checks if both arguments are true. | `Boolean`, `Boolean` | `Boolean` |
| `OR(a, b)` | `\|\|` | Checks if at least one argument is true. | `Boolean`, `Boolean` | `Boolean` |
| `XOR(a, b)` | | Checks if only one argument is true. | `Boolean`, `Boolean` | `Boolean` |
| `NOT(val)` | `!` | Inverts the boolean value. | `Boolean` | `Boolean` |
| `EQU(a, b)` | `==` | Checks if values are identical. | `Any`, `Any` | `Boolean` |
| `NEQ(a, b)` | `!=` | Checks if values are different. | `Any`, `Any` | `Boolean` |
| `GRE(a, b)` | `>` | Checks if `a` is greater than `b`. | `Number`, `Number` | `Boolean` |
| `LES(a, b)` | `<` | Checks if `a` is lesser than `b`. | `Number`, `Number` | `Boolean` |
| `GEQ(a, b)` | `>=` | Checks if `a` is greater or equal to `b`. | `Number`, `Number` | `Boolean` |
| `LEQ(a, b)` | `<=` | Checks if `a` is lesser or equal to `b`. | `Number`, `Number` | `Boolean` |

### 3. Control Flow Functions

Functions used for conditional logic and error handling.

| Function | Description | Example |
| :--- | :--- | :--- |
| `IF(condition, then, else)` | Returns `then` value if condition is `TRUE`, otherwise `else`. | `IF($x > 10, "High", "Low")` |
| `ERROR(message)` | Returns an error with a custom message. The error aborts the execution if it reaches the root of a sequence. | `ERROR("Invalid input")` |

### 4. Text Functions

Functions for manipulating **Text** strings.

| Function | Description | Return Type |
| :------- | :---------- | :---------: |
| `CONCAT(text1, text2)` | Joins two text strings together. | `Text` |
| `TRIM(text)` | Removes white spaces at the beginning and end. | `Text` |
| `UPPERCASE(text)` | Transforms text into uppercase. | `Text` |
| `LOWERCASE(text)` | Transforms text into lowercase. | `Text` |
| `JOIN(array, separator)` | Joins array elements into a single text string using the specified separator. | `Text` |
| `SPLIT(text, separator)` | Splits a text string into an array by the specified separator. | `Array` |

### 5. Array & Collection Functions

Functions operating on **Arrays** and collections.

| Function | Description | Return Type |
| :------- | :---------- | :---------: |
| `ARRAY(elements...)` | Creates an array from provided arguments. Alias for `[...]`. | `Array` |
| `GET(array, index)` / `GET(object, key)` | Returns the array element at the index or the object value at the key. Operator forms: `array[index]` and `object.key`. [[Read more]](functions/GET.md) | `Any` |
| `SUM(array)` | Calculates the sum of all elements in the array. | `Number` |
| `PROD(array)` | Calculates the product of all elements in the array. | `Number` |
| `AVG(array)` | Calculates the mean average value of numbers in an array. | `Number` |
| `LEN(array)` | Returns the number of elements in the array. | `Number` |
| `MAX(...)` | Returns the largest of the numbers, or of the array elements (optionally mapped by a handler). | `Number` |
| `MIN(...)` | Returns the smallest of the numbers, or of the array elements (optionally mapped by a handler). | `Number` |
| `RANGE(array, first_index, last_index)` | Returns a sub-array from `first_index` up to and including `last_index`. | `Array` |
| `SEQ(n, step, start)` / `SEQ(n, generator)` | Creates an array of `n` numbers forming a sequence, starting at `@array_indexing` by default. [[Read more]](functions/SEQ.md) | `Array` |
| `MAP(array, lambda)` | Returns the copy of an array modified by applying a lambda function to each of its elements. The lambda can receive the index as the second parameter: `(e, i) => ...`. | `Array` |
| `FILTER(array, lambda)` | Returns a new array with elements that satisfy the lambda function condition. | `Array` |

### 6. Type Functions

Type-related functions.

| Function | Description | Return Type |
| :------- | :---------- | :---------: |
| `ISNULL(value)` | Checks if value's base type is `Null` | `Boolean` |
| `ISBOOL(value)` | Checks if value's base type is `Boolean` | `Boolean` |
| `ISNUM(value)` | Checks if value's base type is `Number` | `Boolean` |
| `ISTEXT(value)` | Checks if value's base type is `Text` | `Boolean` |
| `ISERR(value)` | Checks if value's base type is `Error` | `Boolean` |
| `ISARR(value)` | Checks if value's base type is `Array` | `Boolean` |
| `ISOBJ(value)` | Checks if value's base type is `Object` | `Boolean` |
| `ISDEL(value)` | Checks if value's base type is `Delegate` | `Boolean` |


### 7. Conversion Functions

| Function | Description | Return Type |
| :------- | :---------- | :---------: |
| `BOOL(value)` | Converts value to `Boolean`. [[Read more]](functions/BOOL.md) | `Boolean` |
| `NUMBER(value)` | Converts value to `Number`. [[Read more]](functions/NUMBER.md) | `Number` |
| `TEXT(value)` | Converts value to `Text`. [[Read more]](functions/TEXT.md) | `Text` |


## Reference
- [Containers](../../core/containers.md)
- [Functions](../../core/functions.md)
- [Context](../../core/context.md)
- [Environment](../../core/environment.md)
