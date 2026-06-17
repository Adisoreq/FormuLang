# Text examples

Examples of using text values.

## Examples

### Example 1

Simple text declaration

#### Formula:
```
"Hello, world!"
```

#### Result:

```
Hello, world!
```

### Example 2

White spaces and new lines

#### Formula:

```
"A1\tB1\nA2\tB2"
```

#### Result:

```
A1    B1
A2    B2
```

### Example 3

Special characters

#### Formula:

```
"Backslash: \\\nHashtag: \#\nQuotation: \""
```

#### Result:

```
Backslash: \
Hashtag: #
Quotation: "
```

### Example 4

Joining texts

#### Formula:

```
$ text1 = "Hello"
$ text2 = "world!"

JOIN([text1, text2], ", ")
```

#### Result:

```
Hello, world!
```

### Example 5

Splitting texts

#### Formula:

```
$ text = "apples | bananas | lemons"

SPLIT(text, " | ")
```

#### Result:

```
[ apples, bananas, lemons ]
```

## Reference

- [Values](../core/values.md)
- [Variables](../core/containers.md#variables)