# FormuLang

Mathematical, formula-based scripting language for managed, real-time mathematical operations.

![License](https://img.shields.io/badge/license-CC%20BY%204.0-blue.svg)

## Overview

FormuLang is a language standard for parsers / interpreters to perform mathematical calculations based on text formulas. It is designed to be embedded in host applications as a lightweight, formula-based scripting layer.

### Key characteristics

- **Expression-oriented** — every formula evaluates to a result; operators are syntactic sugar for built-in functions (e.g. `a + b` → `ADD(a, b)`)
- **Deterministic & side-effect-free** — functions are pure and stateless, ensuring predictable and reproducible results
- **Rich type system** — supports `Null`, `Boolean`, `Number`, `Text`, `Array`, `Object`, lambda functions, and dedicated `Error` / `Undefined` types
- **Scoped variables** — `$` for local (context) variables, `@` for global (environment) variables provided by the host application
- **Error-as-value** — errors are informational values, not exceptions, allowing graceful handling within formulas

### Evaluation pipeline

Formulas go through a multi-stage pipeline: **cleanup** → **tokenization** → **parsing** → **validation** → **computation** → **finalization**, producing a single return value.

For detailed technical documentation, please refer to the [docs](docs) directory.

## Syntax

### Example formula:

```php
# Comment
# Comments are ignored by parser

# Variables
$a = 1
$b = 2
$c = a + b # 3

# Booleans
$b1 = true
$b2 = false

# Numbers
$integer_number = 42
$negative_number = -28
$real_number = 12.45
$scientific_notation = 5.2e-3 # 0,0052
$hexadecimal_integer = 0x40C # 1036

# Text
$message = "Hello, world!"
$special_text = "This text includes:\n- new line\n-\ttabulator\n- special characters: \\, \", \#"

# Arithmetic
$sum = ADD(4, 5) # 9
$fracture = DIV(1, 5) # 0.2

# Logic
$l1 = EQU(b1, b2) # false
$l2 = 25 > 10 # true
$l3 = IF(PRIME(4), "This number is prime", "This number is not prime") # "This number is not prime"

# Arrays
$arr = [5, 6, 7, 8, 9] # ARRAY(5, 6, 7, 8, 9)
$element = arr[2] # 7 (depending on environment)
$left = [ "a", "b", "c" ]
$right = [ "x", "y", "z" ]
$both = CONCAT(left, right) # [ "a", "b", "c", "x", "y", "z" ]
$nested = [ [ 10, 20, 30 ], [ "a", "aa", "aaa" ], [ true, false ] ]

# Objects
$obj = { name: "John", age: 24 }
$name = obj.name # "John"
$age = obj.age # 24

# Lambda functions
$square = (x) => POW(x, 2) # Raises argument to the power of 2
$squared = square(5) # 25
$div_by_3 = (n) => EQU(MOD(n, 3), 0) # Checks if number is dividable by 3
$filtered = FILTER(arr, div_by_3) # [ 6, 9 ]

# Errors
$err = ERROR("Division by zero (0) is not permitted!")

# Returning the value
# Returned value may be either a direct literal, variable, or function call
$result = message + "!!" # "Hello, world!!!"
result
```

## Project Status

![Status](https://img.shields.io/badge/status-work%20in%20progress-orange)
![Version](https://img.shields.io/badge/version-0.1.0--alpha-yellow)

Current stage: **Prototyping & Specification**

This project is currently under active development. The syntax specification is stabilizing, but breaking changes may still occur.

- [x] **Core syntax specification**
- [ ] **Core semantic specification**
- [ ] **Extension standards specification**

## Trivia

- Project's initial purpose was to define stock indicator functions. Now this functionality is realised as an extension, to ensure language's universality.

## Reference

Project is inspired by:

- [Microsoft Excel Formulas](https://support.microsoft.com/en-us/office/formulas-and-functions-294d9486-b332-48ed-b489-abe7d0f9eda9)

- [EspoCRM Formula script](https://docs.espocrm.com/administration/formula/)

- [TradingView Pine Script](https://www.tradingview.com/pine-script-docs/)

- [Math.js Expressions](https://mathjs.org/docs/expressions/)

- [Coda Formulas](https://coda.io/formulas)

## Authors

Adrian Piznal

## License

This project is licensed under the Creative Commons Attribution 4.0 International Public License.