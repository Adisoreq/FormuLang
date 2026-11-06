# Operators

Operators and formula markers organize expression structure, separate sequences, and perform operations on values (operands).

This document distinguishes line-level markers and sequence separators from operators parsed within an expression.
Character-level symbol inventory is documented in [symbols](symbols.md). Parser roles, binding power, and validation rules are defined in [operator Parsing](../semantics/operator-parsing.md).


## Operator families

### 1. Formula and line structure

These markers operate before or at the boundary of a formula sequence; they are not expression operators with binding power.

| Marker | Symbol | Role | Example |
| :----- | :----: | :--- | :------ |
| Line boundary | `[New line]` (`\n`) | Ends the current line and its sequence. | `$x = 1`<br/>`$y = 2` |
| Line comment | `#` | Ignores the marker and all text to its right on the same line. A newline ends the comment. Inside a text literal `#` is an ordinary character. | `$x = 1 # note` |

### 2. Sequence separator

The semicolon separates sequences on the same line. It is processed only in the portion of the line that remains after removing a comment.

| Marker | Symbol | Role | Example |
| :----- | :----: | :--- | :------ |
| Sequence separator | `;` | Ends the current sequence and starts the next one. | `$x = 1; $y = 2` |

For example, in `$x = 1; # note; ignored`, the first semicolon separates sequences; the semicolon after `#` is part of the comment.

### 3. Expression scope sigils

These sigils are interpreted within a sequence and bind to the following identifier.

| Sigil | Role | Description | Example |
| :---: | :--- | :---------- | :------ |
| `$` | Context variable | Marks the following identifier as a user-defined [context](../core/context.md) variable. | `$x = 0` |
| `@` | Environment variable | Marks the following identifier as an [environment](../core/environment.md) variable. | `@array_indexing = 1` |

### 4. Structural operators

Structural operators group or divide sub-expressions.

| Operator | Symbol | Description | Example |
| :------- | :----: | :---------- | :------ |
| Parentheses | `( )` | Group expressions and enforce precedence. | `($a + $b) * $c` |
| Brackets | `[ ]` | Define arrays or access an indexed element or an object property. | `[1, 2, 3]`, `$arr[$index]`, `$obj["value"]` |
| Braces | `{ }` | Define objects. | `{ x: 1, y: 2 }`, `{ "x": 1, "y": 2 }` |
| Comma | `,` | Separates arguments or collection items. | `ADD(1, 2)`, `[1, 2, 3]` |
| Colon | `:` | Separates object key from value. | `{ x: 1 }` |
| Dot | `.` | Accesses an object property. | `$obj.value` |

In **Core**, `array[index]`, `object["key"]` and `object.key` are equivalent to the corresponding [GET](../standards/core/functions/GET.md) overloads. `object.key` is a shorthand for `object["key"]`.

### 5. Arithmetic operators

Arithmetic operators perform mathematical calculations on **Number** values.

| Operator | Symbol | Description | Example | Equivalent Function |
| :--- | :---: | :--- | :--- | :--- |
| Addition | `+` | Adds two numbers. | `10 + 5` | `ADD(10, 5)` |
| Subtraction | `-` | Subtracts the second number from the first. | `10 - 5` | `SUB(10, 5)` |
| Multiplication | `*` | Multiplies two numbers. | `10 * 5` | `MUL(10, 5)` |
| Division | `/` | Divides the first number by the second. | `10 / 5` | `DIV(10, 5)` |
| Modulo | `%` | Returns the remainder of division. | `10 % 3` | `MOD(10, 3)` |
| Exponentiation | `^` | Raises the first number to the power of the second. | `10 ^ 2` | `POW(10, 2)` |
| Negation | `-` | Negates the number. | `-$x` | `NEG($x)` |

### 6. Comparison operators

Comparison operators evaluate the relationship between two values and return a **Boolean** result (`TRUE` or `FALSE`).

| Operator | Symbol | Description | Example | Equivalent Function |
| :--- | :---: | :--- | :--- | :--- |
| Equal | `==` | Checks if two values are identical. | `$a == $b` | `EQU($a, $b)` |
| Not Equal | `<>` / `!=` | Checks if two values are different. | `$a <> $b` / `$a != $b` | `NEQ($a, $b)` |
| Greater Than | `>` | Checks if the left value is greater than the right. | `$a > $b` | `GRE($a, $b)` |
| Less Than | `<` | Checks if the left value is less than the right. | `$a < $b` | `LES($a, $b)` |
| Greater or Equal | `>=` | Checks if left is greater than or equal to right. | `$a >= $b` | `GEQ($a, $b)` |
| Less or Equal | `<=` | Checks if left is less than or equal to right. | `$a <= $b` | `LEQ($a, $b)` |

### 7. Logical operators

Logical operators combine **Boolean** expressions.

| Operator | Symbol | Description | Example | Equivalent Function |
| :--- | :---: | :--- | :--- | :--- |
| AND | `&&` | Checks if both operands are true. | `$x && $y` | `AND($x, $y)` |
| OR | `\|\|` | Checks if at least one operand is true. | `$x \|\| $y` | `OR($x, $y)` |
| NOT | `!` | Reverses the boolean state of the operand. | `!$x` | `NOT($x)` |

### 8. Text operators

Operators used for string manipulation.

| Operator | Symbol | Description | Example | Equivalent Function |
| :--- | :---: | :--- | :--- | :--- |
| Concatenation | `+` | Joins two **Text** values together. | `"Hello " + "World"` | `ADD("Hello ", "World")` |

### 9. Assignment and lambda operators

Used to assign values to variables.

| Operator | Symbol | Description | Example |
| :--- | :---: | :--- | :--- |
| Assignment | `=` | Assigns the value on the right to the variable on the left. | `$x = 10` |
| Initial assignment | `:=` | Assigns the value on the right to the variable on the left, but only if the variable does not exist or has no value (**Undefined**). Translated to `INIT`. | `$x := 10` |
| Conditional assignment | `?=` | Assigns the value on the right to the variable on the left, but only if the variable exists. Translated to `COND_SET`. | `$x ?= 10` |
| Lambda function assignment | `=>` | Creates a temporary, indirectly typed function with custom functionality. | `MAP([2, 4, 6], (element) => POW(element, 2))` |


## Operator length

This table lists operator tokens recognized during tokenization. `#` begins a line comment, which is removed during [clean-up](../semantics/cleanup.md). A new line is emitted by the tokenizer as a `[New line]` boundary token, which is not an operator and is not part of this table.

| Length | Operators |
| ------ | --------- |
| 1-character operators | `$` `@` `;` `=` `(` `)` `[` `]` `{` `}` `"` `,` `:` `.` `>` `<` `+` `-` `*` `/` `%` `^` `!` |
| 2-character operators | `:=` `?=` `=>` `&&` `\|\|` `>=` `<=` `==` `<>` `!=` |


## Reference

- [Symbols](symbols.md)
- [Functions syntax](functions.md)
- [Operator Parsing](../semantics/operator-parsing.md)
- [Execution](../semantics/execution.md)
- [Cleanup](../semantics/cleanup.md)
- [Containers](../core/containers.md)