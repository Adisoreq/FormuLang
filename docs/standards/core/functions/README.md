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
| `CEIL(number, precision?)` | | Rounds the number up to the specific precision (`0` by default). [[Read more]](CEIL.md) | `Number` |
| `FLOOR(number, precision?)` | | Rounds the number down to the specific precision (`0` by default). [[Read more]](FLOOR.md) | `Number` |
| `ROUND(number, precision?)` | | Rounds the number automatically to the specific precision (`0` by default). [[Read more]](ROUND.md) | `Number` |
| `CLAMP(value, min, max)` | | Clamps the value to the range between min and max. [[Read more]](CLAMP.md) | `Number` |
| `SIGN(num)` | | Returns `1` for a positive number, `-1` for a negative number and `0` for zero. [[Read more]](SIGN.md) | `Number` |
| `TRUNC(number, precision?)` | | Cuts off the digits after the specific precision, `0` by default (rounds towards zero). [[Read more]](TRUNC.md) | `Number` |

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
| `LES(a, b)` | `<` | Checks if `a` is less than `b`. [[Read more]](LES.md) | `Boolean` |
| `GEQ(a, b)` | `>=` | Checks if `a` is greater or equal to `b`. [[Read more]](GEQ.md) | `Boolean` |
| `LEQ(a, b)` | `<=` | Checks if `a` is less than or equal to `b`. [[Read more]](LEQ.md) | `Boolean` |

### 3. Control Flow Functions

Functions used for conditional logic and error handling.

| Function | Description | Example |
| :--- | :--- | :--- |
| `IF(condition, then, else)` | Returns `then` value if condition is `TRUE`, otherwise `else`. [[Read more]](IF.md) | `IF($x > 10, "High", "Low")` |
| `ERROR(message)` | Returns an error with a custom message. The error aborts the execution if it reaches the root of a sequence. [[Read more]](ERROR.md) | `ERROR("Invalid input")` |
| `IFNULL(value, fallback)` | Returns `value`, or `fallback` if `value` is `null`. [[Read more]](IFNULL.md) | `IFNULL(PREV, 0)` |
| `IFERR(value, fallback)` | Returns `value`, or `fallback` if `value` is an **Error**. [[Read more]](IFERR.md) | `IFERR($a / $b, 0)` |
| `CALL(function, arguments...)` | Calls a delegate. Operator form: `delegate(arguments)`, e.g. `$f(2)`. [[Read more]](CALL.md) | `CALL($double, 4)` |

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
| `FORMAT(template, values)` | Replaces the placeholders of the template (`{}`, `{0}`, `{key}`, `{:.2}`) with the elements of an array or the values of an object. [[Read more]](FORMAT.md) | `Text` |

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
| `FIRST(array)` / `FIRST(array, handler)` | Returns the first element, or the first element that satisfies the handler; `null` if there is none. [[Read more]](FIRST.md) | `Any` |
| `LAST(array)` / `LAST(array, handler)` | Returns the last element, or the last element that satisfies the handler; `null` if there is none. [[Read more]](LAST.md) | `Any` |

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
| `ISINT(value)` | Checks if the value is a whole number (`false` for other types) [[Read more]](ISINT.md) | `Boolean` |
| `ISEVEN(value)` | Checks if the value is an even whole number (`false` for other types) [[Read more]](ISEVEN.md) | `Boolean` |
| `ISODD(value)` | Checks if the value is an odd whole number (`false` for other types) [[Read more]](ISODD.md) | `Boolean` |

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
| `MERGE(object1, object2)` | Returns a new object with the keys of both objects; the value of `object2` wins. [[Read more]](MERGE.md) | `Object` |

### 10. Time Functions

Functions operating on points in time. A point in time is a **Number**: Unix time in milliseconds, UTC (`0` is `1970-01-01 00:00:00.000`). The current time is the `NOW` environment constant. The functions use the local time defined by the `@time_offset` environment variable (minutes from UTC). Supported years: `1` - `9999`.

| Function | Description | Return Type |
| :------- | :---------- | :---------: |
| `YEAR(time)` | Returns the year. [[Read more]](YEAR.md) | `Number` |
| `MONTH(time)` | Returns the month, from `1` to `12`. [[Read more]](MONTH.md) | `Number` |
| `DAY(time)` | Returns the day of the month, from `1` to `31`. [[Read more]](DAY.md) | `Number` |
| `WEEKDAY(time)` | Returns the ISO day of the week, from `1` (Monday) to `7` (Sunday). [[Read more]](WEEKDAY.md) | `Number` |
| `HOUR(time)` | Returns the hour, from `0` to `23`. [[Read more]](HOUR.md) | `Number` |
| `MINUTE(time)` | Returns the minute, from `0` to `59`. [[Read more]](MINUTE.md) | `Number` |
| `SECOND(time)` | Returns the second, from `0` to `59`. [[Read more]](SECOND.md) | `Number` |
| `MILLISECOND(time)` | Returns the millisecond, from `0` to `999`. [[Read more]](MILLISECOND.md) | `Number` |
| `DATE(year, month, day, hour, minute, second, millisecond)` | Creates a point in time from its parts (`hour` and the next parts are optional). [[Read more]](DATE.md) | `Number` |
| `FORMAT_TIME(time, format)` | Converts a point in time to text, e.g. `"YYYY-MM-DD hh:mm:ss.iii"`. [[Read more]](FORMAT_TIME.md) | `Text` |

Durations are plain numbers of milliseconds, so they are computed with arithmetic: `$t + 24 * 60 * 60 * 1000` is one day later, `($end - $start) / 1000` is a duration in seconds.

### 11. Statistical Functions

Functions describing a set of **Number** values. The mean is computed with [`AVG`](AVG.md). The `_P` functions treat the numbers as a whole population, the `_S` functions as a sample of a larger population.

| Function | Description | Return Type |
| :------- | :---------- | :---------: |
| `MEDIAN(numbers)` | Returns the middle value (the mean of the two middle values for an even count). [[Read more]](MEDIAN.md) | `Number` |
| `VAR_P(numbers)` | Calculates the population variance. [[Read more]](VAR_P.md) | `Number` |
| `VAR_S(numbers)` | Calculates the sample variance. [[Read more]](VAR_S.md) | `Number` |
| `STDEV_P(numbers)` | Calculates the population standard deviation (used e.g. by Bollinger Bands). [[Read more]](STDEV_P.md) | `Number` |
| `STDEV_S(numbers)` | Calculates the sample standard deviation. [[Read more]](STDEV_S.md) | `Number` |


## Reference

- [Core standard](../README.md)
- [Core types](../types/README.md)
- [Core functions](../functions/README.md)
