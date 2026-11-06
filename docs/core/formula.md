# Formula

Formula is a custom, editable, independently evaluated chunk of text on input of the [execution](../semantics/execution.md) process (alongside with [context](./context.md) and [environment](./environment.md)).

While context and environment are application-restricted elements, editing the formula is the only way to manipulate the [execution](../semantics/execution.md) result by user.

Single formula may be split into sequences using `[New line]` and `;` symbols.


## Formula sequences

A **sequence** is one top-level expression in a formula. A new line (`\n`) or semicolon (`;`) ends the current sequence and starts the next one. These separators divide the formula; they are not operators within an expression. A separator inside a nested expression or literal does not end the surrounding sequence.

Each sequence is parsed into its own expression tree and computed in formula order. A sequence's result is the result of its expression; the formula's result is the result of its last sequence, unless execution stops earlier because of an error.


## Result

The formula's result is the value of the **last evaluated statement**. There is no dedicated "return" marker — any statement, sigiled or not, can be the last one and its value becomes the result.

```
$x = 4
$x
```

The first statement performs an assignment and evaluates to `ERROR 0` (Success). The second statement evaluates the variable `$x` and returns `4`. Since it's the last evaluated statement, the formula's result is `4`.


## Formula types

### 1. Simple formula

Consists of a single statement.

### 2. Complex formula

Consists of multiple statements.


## Example

Calculating the diameter of the circle with radius of 2.5

Simple formula:

```php
MUL(MUL(2, PI), 2.5)
```

Complex formula:

```php
REQUIRE "core-0.2+"
@array_indexing = 0

$r = 2.5
$two_pi = MUL(PI, 2)

MUL($r, $two_pi)
```


## Reference

- [Context](./context.md)
- [Environment](./environment.md)
- [Execution](../semantics/execution.md)