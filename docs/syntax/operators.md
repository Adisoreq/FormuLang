# Operators

Operators are special symbols used to perform operations on values (operands). They provide a concise syntax for common mathematical and logical manipulations.

## Operator types

### 1. Sequence operators

Sequence operators split expression sequences and dictate their roles.

| Operator | Symbol | Description | Example |
| :------- | :----: | :---------- | :------ |
| Sequence separator | `[New line]` | Separate expression sequences from each other. |  |
| Comment sequence | `#` | Indicates a **comment** sequence | `# This is a comment` |
| Local script sequence | `$` | Indicates the [context](../core/context.md)-scoped variable operation sequence. | `$x = 0` |
| Global script sequence | `@` | Indicates the [environment](../core/environment.md)-scoped variable operation sequence. | `@array_indexing = 1` |

### 2. Expression Delimiters

Expression delimiters group or isolate sub-expressions, control evaluation order, and define data structures.

| Delimiter   | Symbol      | Description                                 | Example                |
| :---------- | :---------- | :------------------------------------------ | :--------------------- |
| Parentheses | `( )`       | Group expressions, enforce precedence       | `(a + b) * c`          |
| Brackets    | `[ ]`       | Define arrays or index elements             | `[1, 2, 3]`, `arr[0]`  |
| Braces      | `{ }`       | Define objects or blocks (future use)       | `{ "x": 1, "y": 2 }`   |

### 3. Expression Separators

Expression separators divide elements within a single expression or structure.

| Separator | Symbol | Description                                 | Example                |
| :-------- | :----: | :------------------------------------------ | :--------------------- |
| Comma     | `,`    | Separates function arguments or array items | `SUM(1, 2, 3)`         |
| Dot       | `.`    | Accesses object properties (future use)     | `obj.value`            |
| Semicolon | `;`    | Separates multiple expressions              | `a = 1; b = 2`         |

### 4. Arithmetic Operators

Arithmetic operators perform mathematical calculations on **Number** values.

| Operator | Symbol | Description | Example | Equivalent Function |
| :--- | :---: | :--- | :--- | :--- |
| Addition | `+` | Adds two numbers. | `10 + 5` | `ADD(10, 5)` |
| Subtraction | `-` | Subtracts the second number from the first. | `10 - 5` | `SUB(10, 5)` |
| Multiplication | `*` | Multiplies two numbers. | `10 * 5` | `MUL(10, 5)` |
| Division | `/` | Divides the first number by the second. | `10 / 5` | `DIV(10, 5)` |
| Modulo | `%` | Returns the remainder of division. | `10 % 3` | `MOD(10, 3)` |
| Exponentiation | `^` | Raises the first number to the power of the second. | `10 ^ 2` | `POW(10, 2)` |
| Negation | `-` | Negates the number | `-x` | `NEG(x)` |

### 5. Comparison Operators

Comparison operators evaluate the relationship between two values and return a **Boolean** result (`TRUE` or `FALSE`).

| Operator | Symbol | Description | Example | Equivalent Function |
| :--- | :---: | :--- | :--- | :--- |
| Equal | `==` | Checks if two values are identical. | `a == b` | `EQU(a, b)` |
| Not Equal | `<>` / `!=` | Checks if two values are different. | `a <> b` / `a != b` | `NEQ(a, b)` |
| Greater Than | `>` | Checks if the left value is greater than the right. | `a > b` | `GRE(a, b)` |
| Less Than | `<` | Checks if the left value is less than the right. | `a < b` | `LES(a, b)` |
| Greater or Equal | `>=` | Checks if left is greater than or equal to right. | `a >= b` | `GEQ(a, b)` |
| Less or Equal | `<=` | Checks if left is less than or equal to right. | `a <= b` | `LEQ(a, b)` |

### 6. Logical Operators

Logical operators combine **Boolean** expressions.

| Operator | Symbol | Description | Example | Equivalent Function |
| :--- | :---: | :--- | :--- | :--- |
| AND | `&&` | Checks if both operands are true. | `x && y` | `AND(x, y)` |
| OR | `\|\|` | Checks if at least one operand is true. | `x \|\| y` | `OR(x, y)` |
| NOT | `!` | Reverses the boolean state of the operand. | `!x` | `NOT(x)` |

### 7. Text Operators

Operators used for string manipulation.

| Operator | Symbol | Description | Example | Equivalent Function |
| :--- | :---: | :--- | :--- | :--- |
| Concatenation | `+` | Joins two **Text** values together. | `"Hello " + "World"` | `CONCAT("Hello ", "World")` |

### 8. Assignment Operators

Used in the **Extended Dialect** to assign values to variables.

| Operator | Symbol | Description | Example |
| :--- | :---: | :--- | :--- |
| Assignment | `=` | Assigns the value on the right to the variable on the left. | `x = 10` |
| Initial assignment | `:=` | Assigns the value on the right to the variable on the left, but only, if left value is unset / undefined. | `x := 10` |
| Labda function assignment | `=>` | Creates a temporary, indirectly typed function with custom functionality. | `MAP(array, (element) => POW(element, 2))` |

## Operator Precedence

The order in which operators are evaluated when multiple operators appear in the same expression. Listed from **lowest binding** (outermost / evaluated last) to **highest binding** (innermost / evaluated first).

1. **Statement sequence**: `[New line]` — Separates independent sequences
2. **Sigils**: `#`, `$`, `@` — Mark the type of a sequence at the start of a line
3. **Expression sequence**: `;` — Separates expressions within the same sigil sequence
4. **Variable assignment**: `=`, `:=`
5. **Lambda assignment**: `=>`
6. **Delimiters**: `( )`, `[ ]`, `{ }` — Group sub-expressions and override precedence
7. **Separators**: `,`, `.` — Separate items within delimiters
8. **Logical**: `&&`, `||`
9. **Comparison**: `>`, `<`, `>=`, `<=`, `==`, `<>`, `!=`
10. **Additive**: `+`, `-` (subtraction)
11. **Multiplicative**: `*`, `/`, `%`
12. **Exponential**: `^`
13. **Unary**: `!`, `-` (negation)

## Reference

- [Symbols](symbols.md)
- [Functions](../core/functions.md)
- [Evaluation Order](../semantics/evaluation.md)
- [Cleanup](../semantics/cleanup.md)
- [Containers](../core/containers.md)