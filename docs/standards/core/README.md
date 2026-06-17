# FormuLang Core

**FormuLang** **Core** standard documentation.

## Basic information

**Name**: `Core`

**Version**: `0.1`

**Identifier**: `core-0.1`

**Description**: Elementary standard defining core **FormuLang** concepts and structures. Basis of every other extension.

## Context structure

### 1. Context procedures

| Procedure | Description | Example | Equivalent |
| :-------- | :---------- | :------ | :--------- |
| `SET` | Overrides context variable. | `$SET p MUL(PI, r^2)` | `$p = PI * r^2` |
| `INIT` | Initializes non-existing variable. Ignored if variable already exists. | `$INIT sum 0` | `$sum := 0` |

### 2. Context constants

***Core*** standard does not require predefined context constants.

### 3. Context variables

All context variables are defined by user.

## Environment structure

### 1. Environment procedures

| Procedure | Description | Example |
| :-------- | :---------- | :------ |
| `SET` | Overrides environment variable. | `@SET array_indexing 1` |
| `REQUIRE` | Ensures that solutions supports specified standard. | `@REQUIRE "core-1.x"` |
| `ALIAS` | Creates non-whitespace alias for specified set of symbols. | `@ALIAS U UPPERCASE` |

### 2. Environment constants

| Constant | Type | Initial value | Description |
| :------- | :--: | :------------ | :---------- |
| `STANDARDS` | `Array` | `[ "core-1.0" ]` | Stores the array of supported standards' identifiers. |
| `E` | `Number` | `2.718281828459045` | Euler's number. Used in calculus, compound interest, and exponential growth calculations. |
| `PI` | `Number` | `3.141592653589793` | Circle's perimeter do diameter ratio. Used in geometry and trygonometry. |
| `PHI` | `Number` | `1.618033988749894` | Golden ratio. |

### 3. Environment variables

| Variable | Type | Initial value | Description |
| :------- | :--: | :------------ | :---------- |
| `array_indexing` | `Number` | `0` | Base of access-by-index array operations. When accessing the array element, the variable's value is subtracted from target index. Usable in solutions for users, who are not familiar with 0-based indexing. |
| `suppress_errors` | `Boolean` | `false` | Prevents returning errors in evaluation process by turning them into `null` values. |

## Built-in Functions

### 1. Arithmetic Functions

Functions responsible for mathematical calculations on **Number** values.

| Function | Operator | Description | Return Type |
| :------- | :------: | :---------- | :---------: |
| `ADD(a, b)` | `+` | Adds two numbers. | `Number` |
| `SUB(a, b)` | `-` | Subtracts the second number from the first. | `Number` |
| `MUL(a, b)` | `*` | Multiplies two numbers. | `Number` |
| `DIV(a, b)` | `/` | Divides the first number by the second. | `Number` |
| `MOD(a, b)` | `%` | Returns the remainder of division. | `Number` |
| `POW(base, exp)` | `^` | Raises base to the power of exponent. | `Number` |
| `EXP(base)` | | Raises base to the power of natural exponent. Alias for `POW(base, E)` | `Number` |
| `ROOT(num, n)` | | Calculates the n-th root of a number. | `Number` |
| `SQRT(num)` | | Calculates the square root. Alias for `ROOT(num, 2)`. | `Number` |
| `LOG(value, base)` | | Calculates the logarithm of value with specified base. | `Number` |
| `LN(value)` | | Calculates the natural logarithm of value. Alias for `LOG(value, E)` | `Number` |
| `ABS(num)` | | Returns the absolute value. | `Number` |
| `NEG(num)` | `-` | Negates the number. | `Number` |
| `CEIL(number, precision)` | | Rounds the number up to the specific precision. | `Number` |
| `FLOOR(number, precision)` | | Rounds the number down to the specific precision. | `Number` |
| `ROUND(number, precision)` | | Rounds the number automaticly to the specific precision. | `Number` |
| `CLAMP(value, min, max)` | | Clamps the value to the range between min and max. | `Number` |

### 2. Logic & Comparison Functions

Functions that evaluate conditions and return **Boolean** values.

| Function | Operator | Description | Parameter Type | Return Type |
| :------- | :------: | :---------- | :------------- | :---------: |
| `AND(a, b)` | `&&` | Checks if both arguments are true. | `Boolean`, `Boolean` | `Boolean` |
| `OR(a, b)` | `\|\|` | Checks if at least one argument is true. | `Boolean`, `Boolean` | `Boolean` |
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
| `IF(condition, then, else)` | Returns `then` value if condition is `TRUE`, otherwise `else`. | `IF(x > 10, "High", "Low")` |
| `ERROR(message)` | Stops execution and returns an error with a custom message. | `ERROR("Invalid input")` |

### 4. Text Functions

Functions for manipulating **Text** strings.

| Function | Description | Return Type |
| :------- | :---------- | :---------: |
| `CONCAT(text1, text2)` | Joins two text strings together. | `Text` |
| `TRIM(text)` | Removes white spaces at the beginning and end. | `Text` |
| `UPPERCASE(text)` | Transforms text into uppercase. | `Text` |
| `LOWERCASE(text)` | Transforms text into lowercase. | `Text` |
| `BOOLTOSTR(boolean)` | Transforms boolean into text. | `Text` |
| `NUMTOSTR(number)` | Transforms number into text. | `Text` |
| `ARRTOSTR(array)` | Transforms array into text. | `Text` |
| `JOIN(array, separator)` | Joins array elements into a single text string using the specified separator. | `Array`, `Text` | `Text` |
| `SPLIT(text, separator)` | Splits a text string into an array by the specified separator. | `Text`, `Text` | `Array` |

### 5. Array & Collection Functions

Functions operating on **Arrays** and collections.

| Function | Description | Return Type |
| :------- | :---------- | :---------: |
| `ARRAY(elements...)` | Creates an array from provided arguments. Alias for `[...]`. | `Array` |
| `SUM(array)` | Calculates the sum of all elements in the array. | `Number` |
| `PROD(array)` | Calculates the product of all elements in the array. | `Number` |
| `AVG(array)` | Calculates the mean average value of numbers in an array. | `Number` |
| `LEN(array)` | Returns the number of elements in the array. | `Number` |
| `MAX(array)` | Returns the largest value in the array. | `Number` |
| `MIN(array)` | Returns the smallest value in the array. | `Number` |
| `RANGE(array, start, end)` | Returns a sub-array from the `start` index up to (but not including) the `end` index. | `Array` |
| `MAP(array, lambda)` | Returns the copy of an array modified by applying a lambda function to it's every element. | `Array` |
| `FILTER(array, lambda)` | Returns a new array with elements that satisfy the lambda function condition. | `Array` |

### 6. Type Functions

Type-related functions.

| Function | Description | Return Type |
| :------- | :---------- | :---------: |
| `ISNULL(value)` | Checks if value's base type is `Null` | `Boolean` |
| `NOTNULL(value)` | Checks if value's base type is not `Null` | `Boolean` |
| `ISBOOL(value)` | Checks if value's base type is `Boolean` | `Boolean` |
| `NOTBOOL(value)` | Checks if value's base type is not `Boolean` | `Boolean` |
| `ISNUM(value)` | Checks if value's base type is `Number` | `Boolean` |
| `NOTNUM(value)` | Checks if value's base type is not `Number` | `Boolean` |
| `ISTEXT(value)` | Checks if value's base type is `Text` | `Boolean` |
| `NOTTEXT(value)` | Checks if value's base type is not `Text` | `Boolean` |
| `ISERR(value)` | Checks if value's base type is `Error` | `Boolean` |
| `NOTERR(value)` | Checks if value's base type is not `Error` | `Boolean` |
| `ISARR(value)` | Checks if value's base type is `Array` | `Boolean` |
| `NOTARR(value)` | Checks if value's base type is not `Array` | `Boolean` |
| `ISARR(value)` | Checks if value's base type is `Array` | `Boolean` |
| `NOTARR(value)` | Checks if value's base type is not `Array` | `Boolean` |

## Errors

### Error categories

| Codes | Category |
| :---: | :------- |
| `0` | Success result |
| `1 - 999` | Core standard errors |
| `1000...` | Extension standards errors |

### Error list

| Code | Name | Description |
| :--- | :--- | :---------- |
| `0` | `SUCCESS` | Operation executed successfully. The only exception, when returning **Error** value doesn't abort evaluation. |
| `1` | `TYPE_ERROR` | Non-**Undefined** value is being overriden with other type. |
| `2` | `INCORRECT_PARAMETERS_ERROR` | Provided function parameters have incorrect type or quantity. |
| `3` | `INVALID_INDEX_ERROR` | Trying to access array element with incorrect index. |
| `4` | `INVALID_FIELD_ERROR` | Trying to access object element with incorrect name. |
| `10` | `NOT_SUPPORTED_ERROR` | Solution doesn't support required standard. |

## Reference
- [Containers](../core/containers.md)
- [Functions](../core/functions.md)
- [Context](../core/context.md)
- [Environment](../core/environment.md)