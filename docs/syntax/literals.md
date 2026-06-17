# Literals

Literals are directly defined values in a way that allows to unambiguously identify it's type.


## Definining literals

Literals are defined by a specific sequence of symbols, unique for every type.


### 1. Null

#### Literal definition

Literal values with **Null** type are defined using keyword:
- `null` - accessed as a compile-time literal expression
- `NULL` - accessed as a pre-initialized environment constant


### 2. Boolean

#### Literal definition

Literal values with **Boolean** type are defined using keywords:
- `true` / `false` - accessed as compile-time literal expressions
- `TRUE` / `FALSE` - accessed as pre-initialized environment constants


### 3. Number

#### Literal definition

- **Integer**:
  - Integer number is defined by a set of digits 0-9 next to each other. Leading zeros are to be ignored.
  - Example: `42`, `042`
- **Separated integer**
  - Integer number's digits can be separated by **underline** (`_`) symbol to enhance clarity. The symbol is removed during parsing.
  - Separator cannot be neither first nor last number expression's symbol.
  - Example: `1_000_000` interpreted as `1000000`
- **Fraction**:
  - Number with fraction is defined by separating number's interger part from fraction part with **dot** (`.`) symbol.
  - Only one separation symbol is allowed inside a number.
  - Example: `12.5`
- **Abbreviated fraction**
  - If the number has a fraction part, but its integer part is equal to zero, the integer part can be omitted.
  - If the number has an integer part, but its fraction part is equal to zero, the fraction part can be omitted.
  - Example: `.45` is interpreted as `0.45`, `1.` is interpreted as `1.0`
- **Scientific notation**
  - Syntax:
    - **Fraction** between `1` and `10` created by reducing the original number
    - **Separator** as letter `e` (case-insensitive)
    - **Exponent** of `10` divided from the original number, optionally with `+` operator, if positive
  - Example: `1.2E+3` interpreted as `1200` (`1.2 * 10^3`)
- **Hexadecimal integer**
  - Integer number prefixed with `0x` (case-insensitive), followed by hexadecimal digits (`0-9`, `A-F`, case-insensitive).
  - Leading zeros after the prefix are to be ignored.
  - Example: `0xFF` interpreted as `255`, `0x1A` interpreted as `26`

#### Regex:

Interger pattern:

```regexp
^\d+(?:_\d+)*$
```

Fraction pattern:

```regexp
^(?:\d+\.\d*|\d*\.\d+|\d+)$
```

Scientific notation pattern:

```regexp
^\d+(?:\.\d+)?(?:e|E)(?:\+|-)?\d+$
```

Hexadecimal pattern:

```regexp
^0[xX][0-9a-fA-F]+$
```

### 4. Text

#### Literal definition
- Text literals are defined by enclosing set of symbols inside **double quotation marks** (`"`).
- Text can consist of all [allowed symbols](symbols.md).
- Example: `"This is a 1 single-line text inside quotation marks!"`

Text literal expressions with [special characters](symbols.md#symbols-classification) might require the use of [escape sequences](symbols.md#escape-sequences).

#### Regex:

Pattern of correct **Text** literal expressions:

```regexp
^"((?:[^"\\]|\\.)*)"$
```


### 5. Undefined

#### Literal definition

- **Using keyword**
  - `undefined` - if parser views it as a compile-time literal expression
  - `UNDEFINED` - if parser views it as a pre-initialized environment constant
- **Empty declaration**
  - Automaticly set when new variable is declared without specified value
  - Example: `$x` declaration is interpreted as `$x = undefined`


### 6. Error

#### Literal definition
- **Manual**
  - Errors can be manually invoked using `ERROR` function.
  - Example: `$average = IF( LEN(arr) > 0, AVG(arr), ERROR("Array is empty!") )`
- **Automatic**
  - Parsers are obliged to have automatic mechanisms to invoke errors when parsing formulas with incorrect syntax or bugged semantics.


### 7. Array

#### Literal definition

Array type literal definition is realized by `ARRAY` function call:
- Basic Function Expression: `ARRAY(1, 2, 3, 4, 5)`
- Abbreviated Operator Expression: `[1, 2, 3, 4, 5]`


### 8. Object

#### Literal definition
- Basic Function Expression: `OBJECT( PAIR("Param1", 11), PAIR("Param2", 22) )`
- Abbreviated Operator Expression: `{ "Param1": 11, "Param2": 22 }`


### 9. Lambda function

#### Literal definition

Defined using [**lambda function expression**](./functions.md#lambda-function-expression).


## Reference
- [Symbols](symbols.md)
- [Special characters](symbols.md#symbols-classification)
- [Escape sequences](symbols.md#escape-sequences)
- [Functions](functions.md)