# Naming

General principles and restrictions of [named primitives](../core/primitives.md#identity) identifiers.

## Naming restrictions

### 1. Allowed Characters

Identifiers can only consist of the following symbols:
- **Letters**: 
  - **Uppercase**: `[A-Z]`
  - **Lowercase**: `[a-z]` 
- **Digits**: `[0-9]`
- **Underline**: `_`

### 2. Composition Rules

- **Must start with**: A letter or an underline (`_`).
- **Cannot start with**: A digit (`0-9`), to avoid ambiguity with [Number literals](literals.md#3-number).

#### Regex: 
```regexp
^[a-zA-Z_]\w*$
```

### 3. Uniqueness

Every identifier must be unique within its scope to avoid access ambiguity.
Defining more than one named primitive with the same identifier is not allowed.

## Naming conventions

### 1. Snake case

#### Description:

Lowercase words separated by underlines.

#### Regex: 
```regexp
^[a-z][a-z0-9]*(_[a-z0-9]+)*$
```

#### Use:
- Variables (e.g. `my_variable`, written with a `$` or `@` sigil: `$my_variable`; the sigil is not part of the identifier)

### 2. Screaming snake case

#### Description:

Uppercase words separated by underlines.

#### Regex: 
```regexp
^[A-Z][A-Z0-9]*(_[A-Z0-9]+)*$
```

#### Use:
- Procedures (e.g. `SET`, `REQUIRE`)
- Constants (e.g. `PI`, `MAX_VALUE`)
- Native functions (e.g. `SUM`, `EQU`)

## Reference
- [Primitives](../core/primitives.md)
- [Literals](./literals.md)