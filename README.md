# FormuLang

Mathematical, formula-based scripting language for custom, real-time mathematical operations.

![License](https://img.shields.io/badge/license-CC%20BY%204.0-blue.svg)

## Table of Contents
- [FormuLang](#formulang)
  - [Table of Contents](#table-of-contents)
  - [Overview](#overview)
  - [Project Status](#project-status)
  - [Syntax and examples](#syntax-and-examples)
    - [Dialects](#dialects)
      - [Simple dialect](#simple-dialect)
      - [Extended dialect](#extended-dialect)
    - [Basic operations](#basic-operations)
    - [Complex expressions](#complex-expressions)
    - [Logic](#logic)
    - [Arrays](#arrays)
  - [References](#references)
  - [Authors](#authors)
  - [License](#license)

## Overview

FormuLang is a language standard for parsers / interpreters to perform mathematical calculations based on text formulas.

For detailed technical documentation, please refer to the [docs](docs) directory.

## Project Status

![Status](https://img.shields.io/badge/status-work%20in%20progress-orange)
![Version](https://img.shields.io/badge/version-0.1.0--alpha-yellow)

Current stage: **Prototyping & Specification**

This project is currently under active development. The syntax specification is stabilizing, but breaking changes may still occur.

- [x] **Core Syntax Definition**
- [ ] **Full Semantic Definition**
- [x] **Dialects Specification**
- [ ] **Reference Interpreter Implementation**

## Syntax and examples

### Dialects

#### Simple dialect

Simple dialect is expressed by a single, value returning expression.

Example:

```
DIV(ADD(1, 10), 2)
```

#### Extended dialect

Extended dialect allows using variables to store calculation results.
However, it still requires a definition of returned value.

Example:

```
# Variable
x = 15

# Returning value
$ = MOD(x, 4)
```

### Basic operations

```
# Basic operations with functions
ADD(5, 4)    => 9
DIV(10, 4)   => 2.5

# Basic operations with operators
5 - 7     => -2
0.2 * 8   => 1.6
```

### Complex expressions

```
# Function trees
MUL(ADD(5, 4), 2)   => 18

# Manual hierarchy (with braces)
(5 + 4) * 2   => 9 * 2 = 18

# Automatic hierarchy (without braces)
5 + 4 * 2   => 5 + 8 = 13
```

### Logic
```
# Variables
e = 2.71828
pi = 3.14159

# Comparing values
EQU(e, pi)   => FALSE
NEQ(e, pi)   => TRUE
GRE(e, pi)   => FALSE
LES(e, pi)   => TRUE

# IF-THEN-ELSE expressions
$ = IF(GRE(e, pi), e, pi)
```

### Arrays
```
# Array definition
arr = [3, 7, 4, 8]

# Array to number operations
$ = MAX(arr)   => 8

# Array to array operations
$ = SORT(arr)   => [3, 4, 7, 8]
```

## References

Project is strongly inspired by :

- [Microsoft Office Script Language](https://github.com/OfficeDev/office-scripts-docs)

- [EspoCRM Formula script](https://docs.espocrm.com/administration/formula/)

- [TradingView Pine Script](https://www.tradingview.com/pine-script-docs/)

## Authors

Adrian Piznal

## License

This project is licensed under the Creative Commons Attribution 4.0 International Public License.