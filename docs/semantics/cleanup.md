# Clean-up

**Clean-up** is the third stage of the [execution](./execution.md) process, after the [metadata reading](../core/metadata.md#metadata-reading), where the formula string is compressed by removing comments and unnecessary white spaces.

## Clean-up phases

### 1. Normalization

#### Description

Replaces every `[Tab]` (`\t`) with `[Space]`, and every carriage return (`\r`) character with new line (`\n`).

### 2. Removing comments

#### Description

The formula is scanned from the start to the end, and comments located outside a [text literal](../syntax/literals.md#4-text) are removed:

1. **Scoped comment** - the sequence `<#` opens a scoped comment, which ends with the first following `#>`. The whole comment, including both markers, is replaced with:
   - one `[New line]` if the comment contains a line break, so the lines around it stay separate sequences;
   - one `[Space]` otherwise, so the tokens around it stay separate (`1<#x#>2` becomes `1 2`, not `12`).
2. **Line comment** - any other **comment sigil** (`#`) is removed together with the remaining characters on that line. The newline is retained as a line boundary. Thus, a semicolon to the left of `#` can separate sequences, but a semicolon to its right is part of the comment and is ignored.

Inside a line comment, `<#` and `#>` are ordinary characters. Inside a scoped comment, `#` and `"` are ordinary characters. Scoped comments cannot be nested: the first `#>` closes the comment. A scoped comment that is not closed is reported by the [validation](./validation.md), so it never reaches the clean-up.

> **Note:** A text literal begins with a quotation mark (`"`) and ends with the next quotation mark that is not preceded by an escaping backslash (`\`), or at the end of the line. A `#` inside a text literal is an ordinary character, e.g. `"Item #1"`, and so are `"<#"` and `"#>"`.

#### Example

Initial formula:
```
# First comment

$x = 4 # Second comment
$y = <# Scoped comment #> 2

<#
Multi-line
comment
#>
$x ^ $y # Third comment
```

Result:
```


$x = 4 
$y =   2



$x ^ $y 
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