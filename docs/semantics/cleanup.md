# Clean-up

**Clean-up** is the second stage of the [execution](./execution.md) process, where the formula string is compressed by removing comments and unnecessary white spaces.

## Clean-up phases

### 1. Normalization

#### Description

Replaces every `[Tab]` (`\t`) with `[Space]`, and every carriage return (`\r`) character with new line (`\n`).

### 2. Removing comments

#### Description

Removes each **comment sigil** (`#`) that is located outside a [text literal](../syntax/literals.md#4-text), and the remaining characters on that line. The newline is retained as a line boundary. Thus, a semicolon to the left of `#` can separate sequences, but a semicolon to its right is part of the comment and is ignored.

> **Note:** A text literal begins with a quotation mark (`"`) and ends with the next quotation mark that is not preceded by an escaping backslash (`\`), or at the end of the line. A `#` inside a text literal is an ordinary character, e.g. `"Item #1"`.

#### Example

Initial formula:
```
# First comment

$x = 4 # Second comment

$x ^ 2 # Third comment
```

Result:
```


$x = 4 

$x ^ 2 
```

### 3. White space compression

#### Description

Unnecessary white spaces are removed.

#### Removed spaces

- Multi-space - Multiple `[Space]` characters next to each other are turned into single character.
- Trim spaces - White space characters at the start and end of every line are removed.
- Operator spaces - Every `[Space]` next to operator (with exception of literal expression operators) is removed.

#### Example

Initial formula:
```
$x = 2
$y = 3

MUL($x, $y)
```

Result:
```
$x=2
$y=3

MUL($x,$y)
```

### 4. Line compression

#### Description

Removing empty and white-space lines.

#### Example

Initial formula:
```
$x=5
$y=8

MUL($x,$y)
```

Result:
```
$x=5
$y=8
MUL($x,$y)
```

## Reference

- [Execution](./execution.md)