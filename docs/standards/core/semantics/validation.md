# Core/Validation

This document defines the basic validation algorithm required by the **Core** standard. It implements the [validation](../../../semantics/validation.md) stage of the execution process.

The algorithm checks the environment, and then scans the raw formula text once, character by character, tracking whether the current position is inside a comment, a text literal or plain code. Unlike [tokenization](../../../semantics/tokenization.md) and [parsing](parsing.md), it does not stop at the first problem: every problem is appended to the result and the scan continues.


## Input and output

| | Description |
| :-- | :---------- |
| **Input** | Unprocessed formula text and the [environment](../../../core/environment.md). |
| **Output** | Array of [errors](../errors/README.md) in the order of detection, empty if the formula is valid. |

Environment problems are reported as [`ENVIRONMENT_ERROR`](../errors/ENVIRONMENT_ERROR.md) and formula problems as [`SYNTAX_ERROR`](../errors/SYNTAX_ERROR.md). The detail text of every error contains the position of the problem (line and column, both counted from 1).


## Validator state

| Property | Description | Default value |
| :------- | :---------- | :-----------: |
| Errors | Array of the errors found so far. | [ ] <br/> (empty array) |
| Mode | Current scanning mode: **Code**, **Text** or **Comment**. | Code |
| Escape sequence | Whether the previous character was an unescaped backslash inside a text literal. | false |
| Delimiter stack | Opening delimiters (`(`, `[`, `{`) that are not closed yet, with their positions. | [ ] <br/> (empty stack) |
| Text start | Position of the opening quotation mark of the current text literal. | - |
| Line, Column | Position of the current character. | 1, 0 |


## Environment checks

The environment must provide the following elements of the [Core environment structure](../README.md#environment-structure). Every element that is missing or has a wrong type is reported as an `ENVIRONMENT_ERROR`.

| Element | Kind | Required type | Additional requirement |
| :------ | :--- | :------------ | :--------------------- |
| `STANDARDS` | Constant | `Array` of `Text` | Contains the identifier of the **Core** standard (`core-0.2`). |
| `E` | Constant | `Number` | - |
| `PI` | Constant | `Number` | - |
| `PHI` | Constant | `Number` | - |
| `NULL` | Constant | `Null` | - |
| `TRUE` | Constant | `Boolean` | Must be `true`. |
| `FALSE` | Constant | `Boolean` | Must be `false`. |
| `array_indexing` | Variable | `Number` | Must be a whole number. |
| `suppress_errors` | Variable | `Boolean` | - |
| `decimal_place` | Variable | `Number` | Must be a whole number. |
| `split_array` | Variable | `Boolean` | - |
| `split_object` | Variable | `Boolean` | - |
| `include_object_class` | Variable | `Boolean` | - |
| `max_array_preview` | Variable | `Number` | Must be a whole number. |


## Validation algorithm

1. Initialize the [validator state](#validator-state).
2. For every element of the [environment checks](#environment-checks), in table order, append an `ENVIRONMENT_ERROR` to **Errors** if the element does not meet its requirements.
3. Iterate through every **character** of the formula text. A carriage return (`\r`), a line feed (`\n`) and the pair `\r\n` are all one **line break**. Increase **Column** for every character other than a line break, and handle the **current character**:
   1. If **Mode** is **Comment**: if the character is a line break, set **Mode** to **Code** and start a new line (increase **Line**, set **Column** to 0). Otherwise ignore the character (the content of a comment is not checked), and continue.
   2. Else, if the character is not a [valid symbol](../../../syntax/symbols.md#symbols-list) or a line break, append a `SYNTAX_ERROR` (invalid symbol) and continue.
   3. Else, if the character is a line break:
      1. If **Mode** is **Text**, append a `SYNTAX_ERROR` (text literal not closed) pointing to **Text start**, and set **Mode** to **Code** and **Escape sequence** to false.
      2. Start a new line (increase **Line**, set **Column** to 0) and continue.
   4. Else, if **Mode** is **Text**:
      1. If **Escape sequence** is true: set it to false, and if the character is not an [escape sequence symbol](../../../syntax/symbols.md#escape-sequences) (`\`, `"`, `n`, `t`), append a `SYNTAX_ERROR` (invalid escape sequence).
      2. Else, if the character is a quotation mark (`"`), set **Mode** to **Code**.
      3. Else, if the character is a backslash (`\`), set **Escape sequence** to true.
      4. Any other character, including `#`, is an ordinary part of the text.
   5. Else (**Mode** is **Code**):
      1. If the character is the comment sigil (`#`), set **Mode** to **Comment**. The same rule is used by the [clean-up](../../../semantics/cleanup.md#2-removing-comments).
      2. Else, if the character is a quotation mark (`"`), set **Mode** to **Text** and store its position in **Text start**.
      3. Else, if the character is `(`, `[` or `{`, push it with its position on the **Delimiter stack**.
      4. Else, if the character is `)`, `]` or `}`:
         1. If the **Delimiter stack** is empty, append a `SYNTAX_ERROR` (unmatched closing delimiter).
         2. Else, pop the top of the stack. If it is not the opening delimiter matching the character, append a `SYNTAX_ERROR` (closing delimiter does not match the opening delimiter).
      5. Else, if the character is a semicolon (`;`) and the **Delimiter stack** is not empty, append a `SYNTAX_ERROR` (sequence separator inside a delimiter).
4. After the last character:
   1. If **Mode** is **Text**, append a `SYNTAX_ERROR` (text literal not closed) pointing to **Text start**.
   2. For every opening delimiter left on the **Delimiter stack**, from the top, append a `SYNTAX_ERROR` (opening delimiter not closed).
5. Return **Errors**.

A new line inside an open delimiter is not an error: it is ignored by the [parser](parsing.md#splitting-into-sequences).


## Error messages

Implementations may extend the detail text, but it must identify the problem and its position.

| Problem | Error | Detail text pattern |
| :------ | :---- | :------------------ |
| Missing or wrongly typed constant or variable | `ENVIRONMENT_ERROR` | `Environment constant "<NAME>" is missing or is not of type <Type>.` <br> `Environment variable "<NAME>" is missing or is not of type <Type>.` |
| `array_indexing`, `decimal_place` or `max_array_preview` is not a whole number | `ENVIRONMENT_ERROR` | `Environment variable "<NAME>" must be a whole number.` |
| `TRUE` or `FALSE` has a wrong value | `ENVIRONMENT_ERROR` | `Environment constant "<NAME>" must be <value>.` |
| `STANDARDS` without the Core identifier | `ENVIRONMENT_ERROR` | `Environment constant "STANDARDS" does not contain the Core standard.` |
| Invalid symbol | `SYNTAX_ERROR` | `Invalid symbol "<c>" at line <L>, column <C>.` |
| Invalid escape sequence | `SYNTAX_ERROR` | `Invalid escape sequence "\<c>" at line <L>, column <C>.` |
| Text literal not closed | `SYNTAX_ERROR` | `Text literal is not closed at line <L>, column <C>.` |
| Unmatched closing delimiter | `SYNTAX_ERROR` | `Unmatched "<c>" at line <L>, column <C>.` |
| Delimiters do not match | `SYNTAX_ERROR` | `"<c>" does not match the opening delimiter at line <L>, column <C>.` |
| Opening delimiter not closed | `SYNTAX_ERROR` | `Unclosed "<c>" at line <L>, column <C>.` |
| `;` inside a delimiter | `SYNTAX_ERROR` | `Unexpected ";" inside a delimiter at line <L>, column <C>.` |


## Example

Examples assume a correct environment, unless stated otherwise.

| Formula | Errors |
| :------ | :----- |
| `$x = 4 # ok ; ( "` | none (the comment is not checked) |
| `$x = "Item #1"` | none (`#` inside a text literal is an ordinary character) |
| `MUL(2, 3` | `[SYNTAX_ERROR (2)] Unclosed "(" at line 1, column 4.` |
| `ADD(1, 2))` | `[SYNTAX_ERROR (2)] Unmatched ")" at line 1, column 10.` |
| `ADD(1, 2]` | `[SYNTAX_ERROR (2)] "]" does not match the opening delimiter at line 1, column 9.` |
| `$x = "a\qb"` | `[SYNTAX_ERROR (2)] Invalid escape sequence "\q" at line 1, column 9.` |
| `SUM([1; 2])` | `[SYNTAX_ERROR (2)] Unexpected ";" inside a delimiter at line 1, column 7.` |
| `$x = (1` <br> `$y = "a` | `[SYNTAX_ERROR (2)] Text literal is not closed at line 2, column 6.` <br> `[SYNTAX_ERROR (2)] Unclosed "(" at line 1, column 6.` |
| `$x = 1` with `suppress_errors` set to `"yes"` | `[ENVIRONMENT_ERROR (10)] Environment variable "suppress_errors" is missing or is not of type Boolean.` |

The errors listed in one row are returned together in one array; the first error of the array becomes the result of the formula.


## Reference

- [Validation](../../../semantics/validation.md)
- [Core standard](../README.md)
- [Core errors](../errors/README.md)
- [Core parsing](parsing.md)
- [Symbols](../../../syntax/symbols.md)
- [Clean-up](../../../semantics/cleanup.md)
