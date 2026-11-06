# Context examples

List of examples of the use of context constants and variables.

## Examples

### Example 1

#### Formula:

```
$elements = ARRAY(1, 2, 3, 4, 5)
$n = 5
$sum = SUM($elements)

DIV($sum, $n)
```

#### Result:

```
3
```

#### Explanation:

The formula is equivalent of `DIV(SUM(ARRAY(1,2,3,4,5)), 5)`, but it uses context variables for readability.

### Example 2

#### Formula:

```
$elements = ARRAY(10, 20, 30, 40, 50)
SUB(MAX($elements), MIN($elements))
```

#### Result:

```
40
```

#### Explanation:

Definition of variable allows to declare it once, and use in every further call.

### Example 3

#### Formula:

```
$array_indexing = 1
[10, 20, 30][1]
```

#### Result:

```
[INVALID_IDENTIFIER_ERROR (9)] "array_indexing" symbol is already defined by environment.
```

#### Explanation

Context variable cannot be initialized, if **environment** variable with the same name exists.

### Example 4

#### Formula:

```
$x
CLAMP($x, 0, 1)
```

#### Result:

```
[UNDEFINED_ERROR (12)] Variable "x" has no value.
```

#### Explanation

When a variable is declared without a value, it is **Undefined**. Reading it before an assignment results in `UNDEFINED_ERROR`, so `CLAMP` is not called.

### Example 5

#### Formula:

```
$x
$x = 1.2

CLAMP($x, 0, 1)
```

#### Result:

```
1
```

#### Explanation

**Undefined** values can be replaced with any type value.

### Example 6

#### Formula:

```
$x = TRUE
$x = 1.2

CLAMP($x, 0, 1)
```

#### Result:

```
TYPE_ERROR: Trying to override BOOLEAN value with NUMBER.
```

#### Explanation

Non-**Undefined** values cannot be overridden with other type.

## Reference
- [Context](../../../core/context.md)
- [Environment](../../../core/environment.md)