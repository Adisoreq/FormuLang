<div align="center">

<picture>
  <source media="(prefers-color-scheme: dark)" srcset="./raw/images/icons/logotype-dark.svg" />
  <source media="(prefers-color-scheme: light)" srcset="./raw/images/icons/logotype-light.svg" />
  <img src="./raw/images/icons/logotype-light.svg" alt="FormuLang logo" width="500" alt="FormuLang logo" />
</picture>

<p>
    Mathematical, formula-based scripting language for managed, real-time mathematical operations.
</p>

[![Version](https://img.shields.io/badge/version-1.1-green)](#project-status)
[![License](https://img.shields.io/badge/license-CC%20BY%204.0-blue.svg)](LICENSE.txt)

[**Documentation**](docs/README.md) · [**Examples**](docs/standards/core/examples/common_formulas.md) · [**Implementations**](#implementations) · [**Conformance tests**](tests/README.md) · [**Changelog**](CHANGELOG.md)

</div>


## Overview

FormuLang is a language standard for parsers and interpreters that calculate the results of text formulas. A host application embeds an implementation of the standard and lets its users write formulas.

### Main features

- **Expressions** - every formula returns a result. Operators are a short form of built-in functions, e.g. `$a + $b` is `ADD($a, $b)`.
- **Pure functions** - a function returns the same result for the same arguments and does not change anything else. Only procedures (e.g. `SET`) change variables.
- **Types** - `Null`, `Boolean`, `Number`, `Text`, `Array`, `Object`, `Delegate` (functions and lambdas) and `Error`.
- **Two variable scopes** - `$` marks context variables of the formula, `@` marks environment variables of the host application.
- **Errors as values** - an error is a value that a formula can check, e.g. with `ISERR`. An error that is not handled stops the execution and becomes the result.
- **Context types** - the host application runs a formula once, once per element of a collection (**Iteration Context**), or once per frame as time passes (**Time Context**).
- **Standards** - the **Core** standard is the basis; extensions such as **Stock** (candles, indicators, patterns, strategies) add their own types, functions and contexts.

### Execution pipeline

A formula goes through these stages: **validation** → **clean-up** → **tokenization** → **parsing** → **evaluation** → **finalization**. The result is a single value.

The technical documentation is in the [docs](docs) directory.


## Implementations

FormuLang is ready to use: two libraries implement the standard and pass all of its [conformance tests](tests/README.md). Both give identical results for the same formula.

<table>
  <tr>
    <th width="50%"><a href="https://github.com/Adisoreq/formulang-dotnet">FormuLang.NET</a></th>
    <th width="50%"><a href="https://github.com/Adisoreq/formulang-ts">FormuLang-TS</a></th>
  </tr>
  <tr>
    <td>C# library for .NET 8.0 or newer. The reference implementation of the standard.</td>
    <td>TypeScript and JavaScript library for Node.js 20 or newer and the browser.</td>
  </tr>
  <tr>
    <td><pre lang="bash">dotnet add package FormuLang.NET.Core</pre></td>
    <td><pre lang="bash">npm install formulang-ts</pre></td>
  </tr>
  <tr>
    <td align="center"><a href="https://adisoreq.github.io/formulang-dotnet/"><img src="https://img.shields.io/badge/%E2%96%B6-Web%20Preview-512BD4?style=for-the-badge&labelColor=2E1A87" alt="FormuLang.NET Web Preview" /></a></td>
    <td align="center"><a href="https://adisoreq.github.io/formulang-ts/"><img src="https://img.shields.io/badge/%E2%96%B6-Web%20Preview-3178c6?style=for-the-badge&labelColor=1e4f8a" alt="FormuLang-TS Web Preview" /></a></td>
  </tr>
</table>

Both libraries support the **Core** and **Stock** standards. To write an implementation for another language, follow the [documentation](docs/README.md) and run the [conformance tests](tests/README.md): an implementation **conforms** to a standard if it passes every test case that requires only the standards it supports.


## Syntax

### Example formula:

```php
# Comment
# Comments are ignored by parser
<#
  Scoped comment:
  it can span multiple lines
#>

# Variables
$a = 1
$b = 2
$c = $a + $b # 3

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
$special_text = "This text includes:\n- new line\n-\ttabulator\n- special characters: \\, \", #"
$unicode_text = "Zażółć gęślą jaźń" # Unicode characters are allowed inside text
$formatted = FORMAT("{} has {:.1} points", [ "Ann", 9.25 ]) # "Ann has 9.3 points"

# Arithmetic
$sum = ADD(4, 5) # 9
$fraction = DIV(1, 5) # 0.2

# Logic
$l1 = EQU($b1, $b2) # false
$l2 = 25 > 10 # true
$l3 = IF(MOD(4, 2) == 0, "Even", "Odd") # "Even"

# Arrays
$arr = [5, 6, 7, 8, 9] # ARRAY(5, 6, 7, 8, 9)
$element = $arr[2] # 7 (depending on environment)
$left = [ "a", "b", "c" ]
$right = [ "x", "y", "z" ]
$both = CONCAT($left, $right) # [ "a", "b", "c", "x", "y", "z" ]
$nested = [ [ 10, 20, 30 ], [ "a", "aa", "aaa" ], [ true, false ] ]

# Objects
$obj = { name: "John", age: 24 }
$name = $obj.name # "John"
$age = $obj.age # 24

# Lambda functions
$square = (x) => POW(x, 2) # Raises argument to the power of 2
$squared = $square(5) # 25
$div_by_3 = (n) => EQU(MOD(n, 3), 0) # Checks if number is divisible by 3
$filtered = FILTER($arr, $div_by_3) # [ 6, 9 ]

# Time (Unix time in milliseconds, UTC)
$year = YEAR(NOW) # e.g. 2026
$date = FORMAT_TIME(NOW, "DD.MM.YYYY hh:mm") # e.g. "23.11.2026 10:51"

# Errors
$is_err = ISERR(ERROR("Division by zero (0) is not permitted!")) # true; an unhandled error would abort the execution

# Returning the value
# The result is the value of the last evaluated statement - either a direct literal, variable, or function call
$result = $message + "!!" # "Hello, world!!!"
$result
```


## Project Status

Current version: **1.1** - Core standard `core-1.1`, Stock standard `stock-1.1`. Version **1.2** (`core-1.2`, `stock-1.2`) is specified, and its implementations are in progress; see the [proposals](./docs/misc/proposals.md).

The specification is stable: changes within the `1.x` versions are backward compatible.

- [x] **Core syntax specification**
- [x] **Core semantic specification**
- [x] **Extension standards specification** (Stock)
- [x] **Conformance tests**
- [x] **Implementations** ([FormuLang.NET](https://github.com/Adisoreq/formulang-dotnet), [FormuLang-TS](https://github.com/Adisoreq/formulang-ts))


## Trivia

- The project started as a way for users to define stock indicator functions. Stock indicators are now planned as an extension standard, so the core language stays general.


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

<div align="center">
<img src="./raw/images/icons/monogram.svg" height="50" alt="FormuLang monogram" />
</div>
