# Types

Base types implemented by the **Core** standard, divided into **Basic** and **Complex** categories.

---

## Basic types

Basic types represent the fundamental, atomic units of data, and scalar, indivisible piece of information.
Operations performed on basic types generally follow **pass-by-value** semantics, ensuring that data is copied during assignment or function calls.

---

### 1. Null

#### Description

Null is a type defining empty, non-existing value.

---

### 2. Boolean

#### Description

Boolean is a type of a logic value which oscilates between two states: **positive** (`true`) and **negative** (`false`).

---

### 3. Number

#### Description

Number is a type defining a real number in decimal format.

---

### 4. Text

#### Description

Text is a type defining a set of characters, used to process and display text.

---

### 5. Undefined

#### Description

Undefined represents a variable that has been declared but not yet assigned a value (not to mistake with **Null**, where the value data is strictly non-existent).

**Undefined** is the only type where value is allowed to be overrode by other type without invoking error.

---

### 6. Error

#### Description

**Error** consists of **Number**-based error code, and **Text**-based details field. Evaluating an **Error** value by default aborts the process of parsing formula.
Errors are used to inform about incorrect syntax, evaluation fails, hardware limitations, and prevent parser from working until formula gets corrected.

> [!IMPORTANT]
> Invoking error isn't meant to cause throwing an error or exception by the compiler or debugger. It's supposed to return a feedback about errors, and stop the parsing process to let user or programmer apply changes.

---

## Complex types

Complex types are composite data structures designed to organize and aggregate multiple values.
They differ from basic types in that they can contain collections of data-including other complex types (nesting), allowing for the modeling of sophisticated data hierarchies.
In most cases, these types follow **pass-by-reference** semantics to optimize memory usage when processing large datasets.

---

### Array

#### Description

Array is a type defining an ordered collection of values, accessed via unique index.

---

### Object

#### Description

Object is a complex type defining a structure consisting of multiple variables with arbitrary types, accessed via unique name.

### Delegate

#### Description

Delegate is a type storing a reference to a function — either a **named native function** or an **anonymous lambda** — instead of its returned value. Used to pass functions as arguments to higher-order functions.

## Reference
- [Symbols](../syntax/symbols.md)
- [Functions](./functions.md)
