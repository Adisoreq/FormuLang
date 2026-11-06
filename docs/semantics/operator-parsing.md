# Operator Parsing

This document defines how the parser interprets operator tokens. The list of supported operator spellings is defined in [Operators](../syntax/operators.md). The algorithm that applies these rules in the **Core** standard is defined in [Core Parsing](../standards/core/semantics/parsing.md).


## Terms

| Term | Meaning |
| :--- | :------ |
| Operator token | A token whose content is a supported operator spelling. |
| Operand | An expression consumed by an operator. |
| Arity | The number of operands an operator consumes. |
| Fixity | The position of an operator relative to its operands: prefix, infix, or postfix. |
| Binding power | The priority that determines which operator forms a nested expression first. Higher binding power binds more tightly. |
| Operand position | A place in a sequence where the parser expects the start of an operand: at the beginning of a sequence and after a prefix or infix operator, an opening delimiter, `,`, or `:`. |
| Operator position | A place in a sequence where the parser expects an infix or postfix operator, or the end of the expression: directly after a complete operand. |
| Assignable expression | An expression that can be the left operand of an assignment. In **Core**, only a variable with a scope sigil (`$name` or `@name`). |
| Parameter list | A parenthesized, comma-separated list of identifiers without sigils that precedes `=>`. |
| Delimiter | A structural token that opens or closes a grouped expression or literal. Delimiters are not unary operators. |


## Parser roles

The parser determines an operator's role from its spelling and its position in the token stream. The same spelling can have more than one role; for example, `-` is prefix negation in an operand position and infix subtraction in an operator position.

| Role | Operators | Arity | Fixity | Left operand | Right operand | Parser rule |
| :--- | :-------- | :---: | :----: | :----------: | :-----------: | :---------- |
| Variable scope sigil | `$` `@` | 1 | Prefix | No | Yes | Marks the identifier that directly follows as a user-defined (`$`) or [environment](../core/environment.md) variable. Valid only immediately before an identifier; standard-defined functions, procedures, and constants never carry a sigil. |
| Sequence boundary | `;` `[New line]` | - | Boundary | No | No | Ends the current sequence and starts the next one. It is not part of an expression. |
| Assignment | `=` `:=` `?=` | 2 | Infix | Yes | Yes | Left operand must be an assignable expression. |
| Lambda separator | `=>` | 2 | Infix | Yes | Yes | Left operand is a parameter list; right operand is the lambda body. |
| Prefix unary | `!` `-` | 1 | Prefix | No | Yes | `-` means negation in an operand position. |
| Infix binary | `+` `-` `*` `/` `%` `^` `>` `<` `>=` `<=` `==` `<>` `!=` `&&` `\|\|` | 2 | Infix | Yes | Yes | `-` means subtraction in an operator position. |
| Member access | `.` | 2 | Infix | Yes | Yes | The right operand must be an identifier, which is used as a text key. In Core, normalizes to `GET(object, "key")`, as does `object["key"]`. |
| Indexing | `[` `]` | 2 | Postfix | Yes | Yes | `[` in an operator position opens an index expression. In Core, normalizes to `GET(value, index)`. |
| Function call | `(` `)` | n | Postfix | Yes | Yes | `(` directly after an identifier opens the argument list of a function or procedure call. |
| Item separator | `,` | - | Separator | - | - | Separates arguments, parameters, or collection items within an open delimiter. |
| Key-value separator | `:` | - | Separator | - | - | Separates an object key from its value within braces. |
| Opening delimiter | `(` `[` `{` `"` | - | - | No | No | Opens a parser context and requires a matching closing delimiter. |
| Closing delimiter | `)` `]` `}` `"` | - | - | No | No | Closes the matching parser context. |
| Postfix unary | - | 1 | Postfix | Yes | No | Not currently defined. |

`,` and `:` are structural: they never form an expression with their neighbours and are valid only inside the delimiter context described in [Matching delimiters](#matching-delimiters).


## Matching delimiters

| Opening delimiter | Closing delimiter | Context in an operand position | Context in an operator position |
| :---------------- | :---------------- | :----------------------------- | :------------------------------ |
| `(` | `)` | Grouped expression or lambda parameter list | Function call arguments (only directly after an identifier) |
| `[` | `]` | Array literal | Index expression |
| `{` | `}` | Object literal | Not allowed |
| `"` | `"` | Text literal | Not allowed |

The tokenizer emits a text literal as three tokens: an opening `"` operator, a **Text** token with the enclosed content, and a closing `"` operator. The parser requires all three of them; a missing **Text** token or closing `"` is a syntax error.

A `(` in an operand position is a lambda parameter list when its matching `)` is directly followed by `=>`; otherwise it is a grouped expression.

In **Core**, postfix indexing and member access are normalized to `GET(value, index)` and `GET(value, "key")`, respectively; `value["key"]` is an index expression, so it is normalized to the same `GET(value, "key")` as `value.key`.


## Sequence boundaries

A new line establishes a line boundary and `;` separates sequences within a line. A line comment beginning with `#` is removed during [clean-up](cleanup.md) together with the rest of that line, so a `;` after `#` is never a separator. Neither boundary is an expression operator.

The parser splits the token stream into sequences at the boundary tokens that appear **outside** any open delimiter. Inside an open delimiter, a new line is ignored (so arguments and collection items may be written on separate lines), while `;` is a syntax error. Scope sigils (`$`, `@`) are interpreted only within the resulting sequences.


## Binding power

Binding power is listed from lowest (outermost expression) to highest (innermost expression). Line boundaries, sequence separators, comments, and delimiters establish formula or parser boundaries rather than competing for binding power with expression operators.

| Priority | Group | Operators | Associativity |
| :------: | :---- | :-------- | :------------ |
| 1 | Assignment | `=`, `:=`, `?=` | Right |
| 2 | Lambda separator | `=>` | Right |
| 3 | Logical OR | `\|\|` | Left |
| 4 | Logical AND | `&&` | Left |
| 5 | Comparison | `>`, `<`, `>=`, `<=`, `==`, `<>`, `!=` | Non-associative |
| 6 | Additive | `+`, `-` (subtraction) | Left |
| 7 | Multiplicative | `*`, `/`, `%` | Left |
| 8 | Exponential | `^` | Right |
| 9 | Prefix unary | `!`, `-` (negation) | Prefix |
| 10 | Member access, indexing, function call | `.`, `[ ]`, `( )` | Left |
| 11 | Variable scope sigil | `$`, `@` | Prefix |

Consequences of the table:

- `a < b < c` is rejected, because comparison operators are non-associative.
- `-$x^2` and `-2^2` are parsed as `(-$x)^2` and `(-2)^2`, because prefix unary operators bind more tightly than `^`. The tokenizer never includes the sign in a **Number** token (see [Tokenization](tokenization.md)), so `-` is always an operator and its role (negation or subtraction) is decided only by the parser's position.
- `2^3^2` is parsed as `2^(3^2)`, and `$a = $b = 1` as `$a = ($b = 1)`.
- `$a.key` and `$a[0]` apply to the variable `$a`, because the sigil binds more tightly than member access and indexing.


## Parse validation

The parser must reject an expression when any of the following conditions applies:

- an operator has a missing required operand;
- an infix operator, `,`, `:`, `=>`, or a closing delimiter appears in an operand position;
- a prefix operator appears in an operator position, or an operand directly follows a complete operand (except between the arguments of a procedure call written without parentheses, e.g. `SET $x 100`);
- a delimiter is unmatched, crossed, or closed in the wrong context;
- `,` or `:` appears outside its permitted delimiter context;
- `;` appears inside an open delimiter;
- an assignment left operand is not assignable;
- a lambda left operand is not a valid parameter list (it is empty, contains anything other than identifiers, or repeats a name);
- two comparison operators are chained;
- `.` is not followed by an identifier;
- a scope sigil is not directly followed by an identifier;
- an object key is neither an identifier nor a text literal, or its text is not a valid identifier;
- an object literal contains the same key more than once.

The number and types of function arguments are not checked by the parser. They are validated during [evaluation](evaluation.md).


## References

- [Operators](../syntax/operators.md)
- [Functions syntax](../syntax/functions.md)
- [Literals](../syntax/literals.md)
- [Formula](../core/formula.md)
- [Tokens](token.md)
- [Tokenization](tokenization.md)
- [Clean-up](cleanup.md)
- [Parsing](parsing.md)
- [Evaluation](evaluation.md)
- [Core Parsing](../standards/core/semantics/parsing.md)
