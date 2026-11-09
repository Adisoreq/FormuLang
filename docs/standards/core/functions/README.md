# Core/Functions

Built-in functions introduced by **Core** standard.


## Functions

### 1. Arithmetic Functions

Functions responsible for mathematical calculations on **Number** values.

| Function | Operator | Description | Return Type |
| :------- | :------: | :---------- | :---------: |
| `ADD(a, b)` | `+` | Adds two numbers or joins two texts. [[Read more]](ADD.md) | `Number` / `Text` |
| `SUB(a, b)` | `-` | Subtracts the second number from the first. [[Read more]](SUB.md) | `Number` |
| `MUL(a, b)` | `*` | Multiplies two numbers. [[Read more]](MUL.md) | `Number` |
| `DIV(a, b)` | `/` | Divides the first number by the second. [[Read more]](DIV.md) | `Number` |
| `MOD(a, b)` | `%` | Returns the remainder of division. [[Read more]](MOD.md) | `Number` |
| `POW(base, exp)` | `^` | Raises base to the power of exponent. [[Read more]](POW.md) | `Number` |
| `EXP(base)` | | Raises Euler's number `E` to the power of `base`. Alias for `POW(E, base)`. [[Read more]](EXP.md) | `Number` |
| `ROOT(num, n)` | | Calculates the n-th root of a number. [[Read more]](ROOT.md) | `Number` |
| `SQRT(num)` | | Calculates the square root. Alias for `ROOT(num, 2)`. [[Read more]](SQRT.md) | `Number` |
| `LOG(value, base)` | | Calculates the logarithm of value with specified base. [[Read more]](LOG.md) | `Number` |
| `LN(value)` | | Calculates the natural logarithm of value. Alias for `LOG(value, E)` [[Read more]](LN.md) | `Number` |
| `ABS(num)` | | Returns the absolute value. [[Read more]](ABS.md) | `Number` |
| `NEG(num)` | `-` | Negates the number. [[Read more]](NEG.md) | `Number` |
| `CEIL(number, precision)` | | Rounds the number up to the specific precision. [[Read more]](CEIL.md) | `Number` |
| `FLOOR(number, precision)` | | Rounds the number down to the specific precision. [[Read more]](FLOOR.md) | `Number` |
| `ROUND(number, precision)` | | Rounds the number automatically to the specific precision. [[Read more]](ROUND.md) | `Number` |
| `CLAMP(value, min, max)` | | Clamps the value to the range between min and max. [[Read more]](CLAMP.md) | `Number` |
| `SIGN(num)` | | Returns `1` for a positive number, `-1` for a negative number and `0` for zero. [[Read more]](SIGN.md) | `Number` |
| `TRUNC(number, precision)` | | Cuts off the digits after the specific precision (rounds towards zero). [[Read more]](TRUNC.md) | `Number` |

### 2. Logic & Comparison Functions

Functions that evaluate conditions and return **Boolean** values.

| Function | Operator | Description | Return Type |
| :------- | :------: | :---------- | :---------: |
| `AND(a, b)` | `&&` | Checks if both arguments are true. [[Read more]](AND.md) | `Boolean` |
| `OR(a, b)` | `\|\|` | Checks if at least one argument is true. [[Read more]](OR.md) | `Boolean` |
| `XOR(a, b)` | | Checks if exactly one argument is true. [[Read more]](XOR.md) | `Boolean` |
| `NOT(val)` | `!` | Inverts the boolean value. [[Read more]](NOT.md) | `Boolean` |
| `EQU(a, b)` | `==` | Checks if values are identical. [[Read more]](EQU.md) | `Boolean` |
| `NEQ(a, b)` | `!=` | Checks if values are different. [[Read more]](NEQ.md) | `Boolean` |
| `GRE(a, b)` | `>` | Checks if `a` is greater than `b`. [[Read more]](GRE.md) | `Boolean` |
| `LES(a, b)` | `<` | Checks if `a` is lesser than `b`. [[Read more]](LES.md) | `Boolean` |
| `GEQ(a, b)` | `>=` | Checks if `a` is greater or equal to `b`. [[Read more]](GEQ.md) | `Boolean` |
| `LEQ(a, b)` | `<=` | Checks if `a` is lesser or equal to `b`. [[Read more]](LEQ.md) | `Boolean` |

### 3. Control Flow Functions

Functions used for conditional logic and error handling.

| Function | Description | Example |
| :--- | :--- | :--- |
| `IF(condition, then, else)` | Returns `then` value if condition is `TRUE`, otherwise `else`. [[Read more]](IF.md) | `IF($x > 10, "High", "Low")` |
| `ERROR(message)` | Returns an error with a custom message. The error aborts the execution if it reaches the root of a sequence. [[Read more]](ERROR.md) | `ERROR("Invalid input")` |

### 4. Text Functions

Functions for manipulating **Text** strings.

| Function | Description | Return Type |
| :------- | :---------- | :---------: |
| `CONCAT(text1, text2)` | Joins two text strings together. [[Read more]](CONCAT.md) | `Text` |
| `TRIM(text)` | Removes white spaces at the beginning and end. [[Read more]](TRIM.md) | `Text` |
| `UPPERCASE(text)` | Transforms text into uppercase. [[Read more]](UPPERCASE.md) | `Text` |
| `LOWERCASE(text)` | Transforms text into lowercase. [[Read more]](LOWERCASE.md) | `Text` |
| `JOIN(array, separator)` | Joins array elements into a single text string using the specified separator. [[Read more]](JOIN.md) | `Text` |
| `SPLIT(text, separator)` | Splits a text string into an array by the specified separator. [[Read more]](SPLIT.md) | `Array` |
| `LEN(text)` | Returns the number of characters in the text. [[Read more]](LEN.md) | `Number` |
| `SUBSTR(text, start, length)` | Returns `length` characters of the text, beginning at `start` (follows `@array_indexing`). Without `length`, returns the rest of the text. [[Read more]](SUBSTR.md) | `Text` |
| `FIND(text, part)` | Returns the position of the first occurrence of `part` (follows `@array_indexing`), or `null`. [[Read more]](FIND.md) | `Number` / `Null` |
| `CONTAINS(text, part)` | Checks if the text contains `part`. [[Read more]](CONTAINS.md) | `Boolean` |
| `STARTS(text, part)` | Checks if the text begins with `part`. [[Read more]](STARTS.md) | `Boolean` |
| `ENDS(text, part)` | Checks if the text ends with `part`. [[Read more]](ENDS.md) | `Boolean` |
| `REPLACE(text, search, replacement)` | Replaces every occurrence of `search` with `replacement`. [[Read more]](REPLACE.md) | `Text` |
| `REVERSE(text)` | Returns the characters of the text in the reverse order. [[Read more]](REVERSE.md) | `Text` |

### 5. Array & Collection Functions

Functions operating on **Arrays** and collections.

| Function | Description | Return Type |
| :------- | :---------- | :---------: |
| `ARRAY(elements...)` | Creates an array from provided arguments. Alias for `[...]`. [[Read more]](ARRAY.md) | `Array` |
| `GET(array, index)` / `GET(object, key)` | Returns the value at an array index or object key. Operator forms: `array[index]` and `object.key`. [[Read more]](GET.md) | `Any` |
| `SUM(array)` | Calculates the sum of all elements in the array. [[Read more]](SUM.md) | `Number` |
| `PROD(array)` | Calculates the product of all elements in the array. [[Read more]](PROD.md) | `Number` |
| `AVG(array)` | Calculates the mean average value of numbers in an array. [[Read more]](AVG.md) | `Number` |
| `LEN(array)` | Returns the number of elements in the array. [[Read more]](LEN.md) | `Number` |
| `MAX(...)` | Returns the largest of the numbers, or of the array elements (optionally mapped by a handler). [[Read more]](MAX.md) | `Number` |
| `MIN(...)` | Returns the smallest of the numbers, or of the array elements (optionally mapped by a handler). [[Read more]](MIN.md) | `Number` |
| `RANGE(array, first_index, last_index)` | Returns a sub-array from `first_index` up to and including `last_index`. [[Read more]](RANGE.md) | `Array` |
| `SEQ(n, step, start)` / `SEQ(n, generator)` | Creates an array of `n` numbers forming a sequence, starting at `@array_indexing` by default. [[Read more]](SEQ.md) | `Array` |
| `MAP(array, lambda)` | Returns the copy of an array modified by applying a lambda function to each of its elements. The lambda can receive the index as the second parameter. [[Read more]](MAP.md) | `Array` |
| `FILTER(array, lambda)` | Returns a new array with elements that satisfy the lambda function condition. [[Read more]](FILTER.md) | `Array` |
| `REDUCE(array, lambda, initial)` | Combines all elements into a single value: `(acc, e) => ...` or `(acc, e, i) => ...`, starting with `initial`. [[Read more]](REDUCE.md) | `Any` |
| `ANY(array, lambda)` | Checks if at least one element satisfies the lambda function condition. [[Read more]](ANY.md) | `Boolean` |
| `ALL(array, lambda)` | Checks if every element satisfies the lambda function condition. [[Read more]](ALL.md) | `Boolean` |
| `FIND(array, value)` | Returns the index of the first element equal to `value` (follows `@array_indexing`), or `null`. [[Read more]](FIND.md) | `Number` / `Null` |
| `CONTAINS(array, value)` | Checks if the array has an element equal to `value`. [[Read more]](CONTAINS.md) | `Boolean` |
| `HAS(array, index)` | Checks if the array has an element at the index (follows `@array_indexing`). Checks the index, not the value. [[Read more]](HAS.md) | `Boolean` |
| `SORT(array)` / `SORT(array, handler)` | Returns the elements in ascending order: numbers, texts, or elements ordered by the handler results. The sort is stable. [[Read more]](SORT.md) | `Array` |
| `REVERSE(array)` | Returns the elements in the reverse order. [[Read more]](REVERSE.md) | `Array` |

### 6. Type Functions

Type-related functions.

| Function | Description | Return Type |
| :------- | :---------- | :---------: |
| `ISNULL(value)` | Checks if value's base type is `Null` [[Read more]](ISNULL.md) | `Boolean` |
| `ISBOOL(value)` | Checks if value's base type is `Boolean` [[Read more]](ISBOOL.md) | `Boolean` |
| `ISNUM(value)` | Checks if value's base type is `Number` [[Read more]](ISNUM.md) | `Boolean` |
| `ISTEXT(value)` | Checks if value's base type is `Text` [[Read more]](ISTEXT.md) | `Boolean` |
| `ISERR(value)` | Checks if value's base type is `Error` [[Read more]](ISERR.md) | `Boolean` |
| `ISARR(value)` | Checks if value's base type is `Array` [[Read more]](ISARR.md) | `Boolean` |
| `ISOBJ(value)` | Checks if value's base type is `Object` [[Read more]](ISOBJ.md) | `Boolean` |
| `ISDEL(value)` | Checks if value's base type is `Delegate` [[Read more]](ISDEL.md) | `Boolean` |

### 7. Conversion Functions

| Function | Description | Return Type |
| :------- | :---------- | :---------: |
| `BOOL(value)` | Converts value to `Boolean`. [[Read more]](BOOL.md) | `Boolean` |
| `NUMBER(value)` | Converts value to `Number`. [[Read more]](NUMBER.md) | `Number` |
| `TEXT(value)` | Converts value to `Text`. [[Read more]](TEXT.md) | `Text` |

### 8. Trigonometric Functions

Trigonometric functions on **Number** values. Angles are in radians; use `RAD` and `DEG` to convert degrees.

| Function | Description | Return Type |
| :------- | :---------- | :---------: |
| `SIN(angle)` | Calculates the sine of an angle. [[Read more]](SIN.md) | `Number` |
| `COS(angle)` | Calculates the cosine of an angle. [[Read more]](COS.md) | `Number` |
| `TAN(angle)` | Calculates the tangent of an angle. [[Read more]](TAN.md) | `Number` |
| `ASIN(value)` | Calculates the arcsine, from `-PI / 2` to `PI / 2`. [[Read more]](ASIN.md) | `Number` |
| `ACOS(value)` | Calculates the arccosine, from `0` to `PI`. [[Read more]](ACOS.md) | `Number` |
| `ATAN(value)` | Calculates the arctangent, from `-PI / 2` to `PI / 2`. [[Read more]](ATAN.md) | `Number` |
| `ATAN2(y, x)` | Calculates the angle of the point `(x, y)`, from `-PI` to `PI`. [[Read more]](ATAN2.md) | `Number` |
| `DEG(radians)` | Converts radians to degrees. [[Read more]](DEG.md) | `Number` |
| `RAD(degrees)` | Converts degrees to radians. [[Read more]](RAD.md) | `Number` |

### 9. Object Functions

Functions operating on **Objects**.

| Function | Description | Return Type |
| :------- | :---------- | :---------: |
| `KEYS(object)` | Returns the keys of the object, in the order in which they were defined. [[Read more]](KEYS.md) | `Array` |
| `HAS(object, key)` | Checks if the object has a value stored under the key. [[Read more]](HAS.md) | `Boolean` |


## Reference

- [Core standard](../README.md)
- [Core types](../types/README.md)
- [Core functions](../functions/README.md)
