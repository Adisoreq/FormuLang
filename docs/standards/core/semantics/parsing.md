# Core/Parsing

This document defines the parsing algorithm required by the **Core** standard. It implements the [parsing](../../../semantics/parsing.md) stage of the execution process and uses the operator roles, binding power, and validation rules from [Operator Parsing](../../../semantics/operator-parsing.md).

The algorithm is based on **Pratt parsing** (top-down operator precedence): every token has a *prefix* behaviour, used when an operand is expected, and optionally an *infix* or *postfix* behaviour with a binding power, used when an operator is expected. Operator roles that share a spelling (for example, `-`) are therefore resolved by the parser's position, not by lookahead.


## Input and output

| | Description |
| :-- | :---------- |
| **Input** | Array of [tokens](../../../semantics/token.md) produced by [tokenization](../../../semantics/tokenization.md). |
| **Output** | One expression tree per [sequence](../../../core/formula.md#formula-sequences), the [parsing queue](../../../semantics/parsing.md#1-parsing-queue) of every sequence, and the [primitive map](../../../semantics/parsing.md#3-primitive-map) shared by the whole formula. Every lambda body is parsed into a separate [lambda tree](../../../semantics/parsing.md#lambda-trees) with its own queue and primitive map. |

If any step reports a syntax error, parsing stops and the error is returned as the result of the execution.


## Parser state

| Property | Description | Default value |
| :------- | :---------- | :-----------: |
| Tokens | Token array of the sequence currently being parsed. | [ ] <br/> (empty array) |
| Position | Index of the next token to consume. | 0 |
| Lambda scopes | Stack of parameter-name lists of the lambda expressions currently being parsed. Used to tell parameter references from constants. | [ ] <br/> (empty stack) |
| Sequence trees | Array of expression trees; one entry per parsed sequence. | [ ] <br/> (empty array) |


## Binding power

Binding power of a token is the number from the **Priority** column of the [binding power table](../../../semantics/operator-parsing.md#binding-power). Higher numbers bind more tightly.

| Operator group | Priority | Right binding power | Note |
| :------------- | :------: | :-----------------: | :--- |
| Assignment `=` `:=` `?=` | 1 | 0 | Right-associative. |
| Lambda separator `=>` | 2 | 1 | Right-associative. |
| Logical OR `\|\|` | 3 | 3 | Left-associative. |
| Logical AND `&&` | 4 | 4 | Left-associative. |
| Comparison `>` `<` `>=` `<=` `==` `<>` `!=` | 5 | 5 | Non-associative. |
| Additive `+` `-` | 6 | 6 | Left-associative. |
| Multiplicative `*` `/` `%` | 7 | 7 | Left-associative. |
| Exponential `^` | 8 | 7 | Right-associative. |
| Prefix unary `!` `-` | 9 | 9 | Prefix operand is parsed with this value. |
| Member access, indexing `.` `[` | 10 | 10 | Left-associative. |

The right binding power is the value passed to `ParseExpression` when the right operand is parsed. It equals the priority for left-associative and non-associative operators, and the priority decreased by 1 for right-associative operators. Variable scope sigils (priority 11) have no infix behaviour; they are consumed by the prefix step.

Because the prefix unary priority (9) is higher than the exponential priority (8), `-$x^2` is parsed as `(-$x)^2` and `-2^2` as `(-2)^2`. Number tokens never carry a sign, so `-2` is the prefix operator `-` applied to the number `2`, translated to `NEG(2)`.


## Parsing algorithm

1. Load the [tokenization](../../../semantics/tokenization.md) result, initialize the [parser state](#parser-state) and an empty **sequence trees** array.
2. [Split the token array into sequences](#splitting-into-sequences).
3. For every sequence, in formula order:
   1. Set **Tokens** to the sequence's tokens, **Position** to 0 and clear **Lambda scopes**.
   2. Call [`ParseExpression(0)`](#parseexpression) and append the returned tree to **Sequence trees**.
   3. If **Position** does not point past the last token, stop the process and return a **syntax error** (unexpected token).
4. Build the [parsing queue](../../../semantics/parsing.md#1-parsing-queue) of every tree.
5. Replace every operator node in the queues with its [function call](#operator-translation).
6. Build the [primitive map](../../../semantics/parsing.md#3-primitive-map) from the queues.
7. Build the [reference tree](../../../semantics/parsing.md#4-reference-tree) of every sequence.
8. Return the reference trees together with the primitive map.


### Splitting into sequences

1. Initialize an empty **current sequence** and an empty **delimiter stack**.
2. Iterate through every token:
   1. If the token is a `"` operator, then the next two tokens must be a **Text** token and a closing `"` operator. Append all three tokens to the **current sequence** as one unit. Otherwise, stop the process and return a **syntax error**.
   2. Else, if the token is `(`, `[` or `{`, push it on the **delimiter stack** and append it.
   3. Else, if the token is `)`, `]` or `}`, then the **delimiter stack** must not be empty and its top must be the matching opening delimiter. Pop it and append the token. Otherwise, stop the process and return a **syntax error**.
   4. Else, if the **delimiter stack** is empty and the token is `[New line]` or `;`, close the **current sequence** and start a new one. Empty sequences are discarded.
   5. Else, if the **delimiter stack** is not empty and the token is `[New line]`, ignore it.
   6. Else, if the **delimiter stack** is not empty and the token is `;`, stop the process and return a **syntax error**.
   7. Else, append the token to the **current sequence**.
3. If the **delimiter stack** is not empty, stop the process and return a **syntax error** (unclosed delimiter).
4. Close the **current sequence**, unless it is empty.


### ParseExpression

`ParseExpression(rbp)` parses the longest expression whose operators all bind more tightly than `rbp` and returns its tree.

1. [Parse the prefix](#prefix-step) at the current **Position** and store the result as **left**.
2. While the next token has an [infix or postfix behaviour](#infix-and-postfix-step) and its priority is **greater** than `rbp`:
   1. Replace **left** with the result of that behaviour, applied to the previous **left**.
3. Return **left**.

The loop ends, without an error, at any token that has no infix or postfix behaviour (for example `,`, `:`, `)`, `]`, `}`), or whose priority is not greater than `rbp`. The caller decides whether that token is allowed.


### Prefix step

The prefix step consumes the next token as the start of an operand. If there is no next token, stop the process and return a **syntax error** (missing operand).

| Token | Behaviour |
| :---- | :-------- |
| **Number** | Create a **Value** node. The token content must match a [number literal](../../../syntax/literals.md#3-number) pattern; otherwise return a **syntax error**. |
| `"` | Consume the following **Text** token and the closing `"` operator. Create a **Value** node of type `Text`. |
| **Identifier** `null` `true` `false` | Create the **Value** node of the corresponding [literal](../../../syntax/literals.md). |
| **Identifier** followed by `(` | Parse a [function call](#function-call). |
| **Identifier** naming a procedure of the active standard, not followed by `(` | Parse a [procedure call](#procedure-call-without-parentheses). |
| **Identifier** (any other) | If any entry of **Lambda scopes** contains the name, create a **Parameter** reference node. Otherwise, create a **Constant** reference node, resolved later against the context and environment. |
| `$` or `@` | The next token must be an **Identifier**; otherwise return a **syntax error**. Create a **Variable** node with the user (`$`) or environment (`@`) scope. |
| `(` | Parse a [lambda parameter list](#lambda-parameter-list) if the matching `)` is directly followed by `=>`. Otherwise, parse a **grouped expression**: call `ParseExpression(0)`, then consume `)`. |
| `[` | Parse an **array literal**: zero or more items, each parsed with `ParseExpression(0)` and separated by `,`, followed by `]`. Create an operator node `[ ]` with the items as children. |
| `{` | Parse an **object literal**: zero or more `key : value` pairs separated by `,`, followed by `}`. A key is either an **Identifier** token or a `"` **Text** `"` literal, and its text must match the [identifier pattern](../../../syntax/naming.md#2-composition-rules); otherwise return a **syntax error**. An **Identifier** in the key position is always a key (it is not resolved as a literal, constant or function). Both notations produce the same key: `"key"` and `key` are equivalent. A key that repeats an earlier key of the same literal (in either notation) returns a **syntax error**. Every value is parsed with `ParseExpression(0)`. Create an operator node `{ }` with the keys and values as children. |
| `!` or `-` | Consume the token, parse the operand with `ParseExpression(9)` and create a prefix operator node. |
| Any other token | Stop the process and return a **syntax error** (an operator, separator or closing delimiter appears where an operand is expected). |


### Infix and postfix step

The step is selected by the next token and is applied to the already parsed **left** operand.

| Token | Behaviour |
| :---- | :-------- |
| `=` `:=` `?=` | **Left** must be a **Variable** node; otherwise return a **syntax error**. Consume the token, parse the right operand with `ParseExpression(0)` and create an assignment node. |
| `=>` | **Left** must be a [lambda parameter list](#lambda-parameter-list); otherwise return a **syntax error**. Consume the token, push the parameter names on **Lambda scopes**, parse the body with `ParseExpression(1)`, pop **Lambda scopes** and create a **Lambda** node. The body tree is self-contained: it is [queued, translated and classified separately](../../../semantics/parsing.md#lambda-trees) from the enclosing sequence, and its **Parameter** nodes stay unresolved leaves. |
| `\|\|` `&&` `+` `-` `*` `/` `%` `^` | Consume the token, parse the right operand with `ParseExpression(rbp)` using the value from the [binding power table](#binding-power) and create an infix operator node. |
| `>` `<` `>=` `<=` `==` `<>` `!=` | Like the previous row. After the right operand is parsed, if the next token is also a comparison operator, stop the process and return a **syntax error** (comparison operators are non-associative). |
| `.` | The next token must be an **Identifier**; otherwise return a **syntax error**. Consume both tokens and create a member access node whose key is the identifier's text. |
| `[` | Consume the token, parse the index with `ParseExpression(0)`, then consume `]`. Create an index node. |

The `,`, `:`, `;` tokens and closing delimiters have no infix or postfix behaviour. Any other token that is not listed in the table (for example **Number** or **Identifier**) also ends the expression.


### Function call

1. Consume the **Identifier** and the `(` token.
2. If the next token is `)`, consume it. The call has no arguments.
3. Else, repeat:
   1. Parse an argument with `ParseExpression(0)`.
   2. If the next token is `,`, consume it and continue. If it is `)`, consume it and stop. Otherwise, return a **syntax error**.
4. Create a **Function** node with the identifier as its name and the arguments as its children.

The parser does not check the number or types of the arguments. They are matched against the function's [argument collection template](../../../implementation/argument_collection_template.md) during [evaluation](../../../semantics/evaluation.md).


### Procedure call without parentheses

Procedures of the active standard (in Core: `SET`, `INIT`, `COND_SET`, `REQUIRE`) may be written without parentheses, with their arguments separated by white space instead of commas, e.g. `REQUIRE "core-0.2+"` or `SET $x 100`.

1. Consume the **Identifier**. Let **n** be the number of parameters of the procedure.
2. Parse the first **n − 1** arguments with `ParseExpression(10)`. Only a single operand (literal, variable, grouped expression, array or object literal) is consumed, so the next argument can start right after it.
3. Parse the last argument with `ParseExpression(0)`.
4. Create a **Function** node with the identifier as its name and the arguments as its children. The node is identical to the one created from `NAME(arg1, arg2)`.


### Lambda parameter list

1. Consume the `(` token.
2. Repeat: consume an **Identifier** (parameter names have no sigil) and then either `,` or `)`. Any other token results in a **syntax error**.
3. Parameter names must be unique; otherwise return a **syntax error**.
4. Create a parameter list node.

A parameter list is valid only as the left operand of `=>`.


## Operator translation

After the trees are built and queued, every operator node is replaced with the call of its equivalent function or procedure. The translation uses the equivalents defined in [Operators](../../../syntax/operators.md) and the [procedures](../README.md#built-in-procedures) of the Core standard.

In the table, `a`, `b`, `i` and `body` are placeholders for operand expressions; they are not variables (variables always carry a sigil).

| Operator node | Translation |
| :------------ | :---------- |
| `a + b` | `ADD(a,b)` |
| `a - b` | `SUB(a,b)` |
| `a * b` | `MUL(a,b)` |
| `a / b` | `DIV(a,b)` |
| `a % b` | `MOD(a,b)` |
| `a ^ b` | `POW(a,b)` |
| `-a` | `NEG(a)` |
| `a == b` | `EQU(a,b)` |
| `a != b`, `a <> b` | `NEQ(a,b)` |
| `a > b` | `GRE(a,b)` |
| `a < b` | `LES(a,b)` |
| `a >= b` | `GEQ(a,b)` |
| `a <= b` | `LEQ(a,b)` |
| `a && b` | `AND(a,b)` |
| `a \|\| b` | `OR(a,b)` |
| `!a` | `NOT(a)` |
| `$x = a`, `@x = a` | `SET($x,a)`, `SET(@x,a)` |
| `$x := a`, `@x := a` | `INIT($x,a)`, `INIT(@x,a)` |
| `$x ?= a`, `@x ?= a` | `COND_SET($x,a)`, `COND_SET(@x,a)` |
| `a[i]` | `GET(a,i)` |
| `a["key"]` | `GET(a,"key")` |
| `a.key` | `GET(a,"key")` |
| `[a, b, c]` | `ARRAY(a,b,c)` |
| `{ k1: a, "k2": b }` | `OBJECT("k1",a,"k2",b)` |
| `(p1, p2) => body` | **Lambda** primitive (not translated into a call) |

The operator `+` is always translated into `ADD`; the [ADD](../functions/ADD.md) function provides both the numeric and the text overload.


## Syntax errors

The process stops with a **syntax error** when:

- a delimiter is unmatched, crossed, or closed in the wrong context;
- a **Text** token is not enclosed by `"` operators;
- an operand is missing, or an operator, `,`, `:` or closing delimiter appears where an operand is expected;
- an unexpected token remains after a complete expression;
- `;` appears inside an open delimiter;
- an assignment's left operand is not a variable;
- the left operand of `=>` is not a valid parameter list;
- a comparison operator is chained with another comparison operator;
- `.` is not followed by an identifier;
- a scope sigil is not directly followed by an identifier;
- a number literal does not match the Core number patterns;
- an object key is neither an identifier nor a `Text` literal, or its text doesn't match the identifier pattern;
- an object literal contains the same key more than once.


## Example

Parsing the sequence `$c=$a^2+$b^2` (after clean-up):

| # | Call | Next token | Action |
| :-: | :--- | :--------- | :----- |
| 1 | `ParseExpression(0)` | `$` `c` | The prefix step creates the variable `$c`. Next token `=` has priority 1, which is greater than 0, so the infix step starts; the left operand is a variable. |
| 2 | `ParseExpression(0)` (right operand of `=`) | `$` `a` | The prefix step creates `$a`. Next token `^` has priority 8 > 0. |
| 3 | `ParseExpression(7)` (right operand of `^`) | `2` | The prefix step creates `2`. Next token `+` has priority 6, which is not greater than 7, so the call returns `2`. |
| 4 | `ParseExpression(0)` (continued) | `+` | `^` is applied: `$a^2`. Next token `+` has priority 6 > 0. |
| 5 | `ParseExpression(6)` (right operand of `+`) | `$` `b` `^` `2` | Parsed like steps 2-3; the call returns `$b^2`. |
| 6 | `ParseExpression(0)` (continued) | - | `+` is applied, no tokens are left and the call returns `$a^2+$b^2`. |
| 7 | `ParseExpression(0)` (top level) | - | `=` is applied. The tree is `=($c, +(^($a, 2), ^($b, 2)))`. |


## References

- [Parsing](../../../semantics/parsing.md)
- [Operator Parsing](../../../semantics/operator-parsing.md)
- [Tokenization](../../../semantics/tokenization.md)
- [Formula](../../../core/formula.md)
- [Core standard](../README.md)
- [Core literals](../../../syntax/literals.md)
- [Core operators](../../../syntax/operators.md)
- [Functions syntax](../../../syntax/functions.md)
- [Execution](../../../semantics/execution.md)
