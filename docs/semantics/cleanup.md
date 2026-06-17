# Clean-up

**Clean-up** is the first stage of the [evaluation](./evaluation.md) process, where the formula string is compressed by removing comments and unnecessary white spaces.

## Clean-up phases

### 1. Normalization

#### Description

Replaces every `[Tab]` (`\t`) with `[Space]`, and every carriage return (`\r`) character with new line (`\n`).

### 2. Removing comments

#### Description

Removes **comment sigils** (`#`) and every character after them.

> **Note:** To use a literal `#` character inside a value (e.g. in a string), it must be escaped with a backslash (`\#`). An unescaped `#` is always treated as the start of a comment.

#### Example

Initial formula:
```
# First comment

$ x = 4 # Second comment

x ^ 2 # Third comment
```

Result:
```


$ x = 4 

x ^ 2 
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
$ x = 2
$ y = 3

MUL(x, y)
```

Result:
```
$x=2
$y=3

MUL(x,y)
```

### 4. Line compression

#### Description

Removing empty and white-space lines.

#### Example

Initial formula:
```
$x=5
$y=8

MUL(x,y)
```

Result:
```
$x=5
$y=8
MUL(x,y)
```

## Reference

- [Evaluation](./evaluation.md)