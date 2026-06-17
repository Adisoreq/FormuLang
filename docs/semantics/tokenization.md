# Tokenization

**Tokenization** is the second stage of the [evaluation](./evaluation.md) process, where the formula string is being split into sequences, and sequences are being split into expressions.

## Tokenization phases

### 1. Sequence tokenization

#### Description

Process of splitting the processed formula into single sequences with specified type.

#### Sequence types

1. **Environment sequence** - used for invoking environment procedures.
2. **Context sequence** - used for declaring and assigning context variables.
3. **Return sequence** - used to return a final value.

#### Example

Formula:
```
# Environment section
@ REQUIRE [ "core-^1.0.0" ]
@ ALIAS r_2 POW(r,2)

# Context section
$ r = 4; deg = 90

# Return section
PI * r_2 * (deg / 360)
```

Environment sequences:
```
REQUIRE ["core-^1.0.0"]
```
```
ALIAS r_2 POW(r,2)
```

Context sequences:
```
r=4
```
```
deg=90
```

Return sequence:
```
PI*r_2*(deg/360)
```

### 2. Expression tokenization

#### Description

Process of splitting the translated sequence into a flat list of typed expressions. The hierarchical structure (expression tree) is built in the next evaluation step - [parsing](./parsing.md).

#### Expression types:

1. **Literal expression** - for accessing literal values
2. **Reference expression** - for accessing variables and constants
3. **Function expression** - for calling functions
4. **Procedure expression** - for calling procedures

#### Example

Translated sequence:
```
SET variable DIV(MUL(25,180),PI)
```

Sequence information:
| Parameter | Info |
| ---- | ---------------- |
| Type | Context sequence |
| Literal expressions | `25` `180` |
| Reference expressions | `variable` `PI` |
| Function expressions | `DIV` `MUL` |
| Total elements | 7 |

## Reference

- [Evaluation](./evaluation.md)
- [Clean-up](./cleanup.md)
- [Parsing](./parsing.md)
- [Functions](../core/functions.md)
- [Containers](../core/containers.md)
- [Primitives](../core/primitives.md)
- [Literals](../syntax/literals.md)