# Argument template

Helper structure used to verify the arguments passed into called function.

## Structure

### Overview

| Property | Description |
| :------- | :---------- |
| Base type | Base type of the argument primitive |
| Extended type | Extended type of the argument primitive |
| Any type | Determines whether matching the types should be ignored |
| Multiple | Determines whether the template is applied to multiple arguments |
| Optional | Determines whether the argument may be omitted |

### Properties

Base type

| Name | Base type |
| ---- | ------------ |
| Description | Checks if examined primitive's base type matches the template one |
| Expected value | Base type identifier (character string) |
| Requirement | Mandatory if `Any type` is **false**, optional if **true** |
| Constraints | Cannot be **Undefined**, if `Any type` is **false** |

Extended type

| Name | Extended type |
| ---- | ------------ |
| Description | Checks if examined primitive's extended type matches the template one, or it's [predecessor](../semantics/inheritance.md) |
| Expected value | Extended type identifier (character string) |
| Requirement | Optional |
| Constraints | `Base type` must be **Object** |

Any type

| Name | Any type |
| ---- | ------------ |
| Description | Disables the `Base type` and `Extended type` checking |
| Expected value | **True** of **false** (boolean) |
| Requirement | Optional |
| Constraints | None |

Multiple

| Name | Multiple |
| ---- | -------- |
| Description | Specifies whether template matches multiple arguments |
| Expected value | **True** of **false** (boolean) |
| Requirement | Optional |
| Constraints | Only the single last argument in a collection may be *multiple* |

Optional

| Name | Optional |
| ---- | -------- |
| Description | Specifies whether argument may be omitted |
| Expected value | **True** of **false** (boolean) |
| Requirement | Optional |
| Constraints | *Optional* argument cannot stand before *non-optional* argument |

## Signature

Descriptive notation of argument template. Readable for humans, ignored by parser.

### Elements

1. **Name** - argument's identifier in collection
2. **Type** - argument's **base type**, or **extended type**, if specified

### Principles

- **Name** and **Type** are separated with space.
- **Type** is enclosed within angle brackets (`< >`).
- Value of **Type** is set to argument's **extended type**, if it's defined. If not, it's set to argument's **base type**.
- If **Any type** property is **true**, value of **Type** is replaced with `Any`
- If **Optional** property is **true**, value of **Name** is followed with a question mark (`?`) character after it.
- If **Multiple** property is **true**, value of **Name** is followed with three dot (`...`) characters before it.
- Multiple template signatures within collection are separated with coma (`,`) symbol.

### Signature table

| Any type | Multiple | Optional |   | Signature |
| :------: | :------: | :------: | - | :-------: |
| ❌ | ❌ | ❌ | | `Name <Type>` |
| ✅ | ❌ | ❌ | | `Name <Any>` |
| ❌ | ✅ | ❌ | | `...Name <Type>` |
| ❌ | ❌ | ✅ | | `Name? <Type>` |
| ✅ | ✅ | ❌ | | `...Name <Any>` |
| ✅ | ❌ | ✅ | | `Name? <Any>` |
| ❌ | ✅ | ✅ | | `...Name? <Type>` |
| ✅ | ✅ | ✅ | | `...Name? <Any>` |

## Examples

### Strict template (Number)

**Signature**: `arg <Number>`

**Template**:

| Base type | Extended type | Any type | Multiple | Optional |
| :--: | :--: | :--: | :--: | :--: |
| Number | - | false | false | false |

**Accepted types**:

Only valid `Number` value

### Strict template (Extended type)

**Signature**: `arg <Geometry.Object2D>`

**Template**:

| Base type | Extended type | Any type | Multiple | Optional |
| :--: | :--: | :--: | :--: | :--: |
| Object | Geometry.Object2D | false | false | false |

**Accepted types**:

`Geometry.Object2D` and all its descendants (`Geometry.Figure2D`, `Geometry.Curve2D`, etc.)

### Any type template

**Signature**: `arg <Any>`

**Template**:

| Base type | Extended type | Any type | Multiple | Optional |
| :--: | :--: | :--: | :--: | :--: |
| - | - | true | false | false |

**Accepted types**:

Any valid value is accepted (`Null`, `Boolean`, `Number`, `Object`, etc.)

### Multiple template

**Signature**: `args... <Any>`

**Template**:

| Base type | Extended type | Any type | Multiple | Optional |
| :--: | :--: | :--: | :--: | :--: |
| - | - | true | true | false |

**Accepted arguments**:

Multiple arguments accepted (at least one).

Explained further in [argument collection template](./argument_collection_template.md#variadic-collection) documentation.

### Optional template

**Signature**: `arg? <Any>`

**Template**:

| Base type | Extended type | Any type | Multiple | Optional |
| :--: | :--: | :--: | :--: | :--: |
| - | - | true | false | true |

**Accepted arguments**:

Template is accepted whether the argument is either present or omitted.

Explained further in [argument collection template](./argument_collection_template.md#optional-argument) documentation.

## Reference

- [Functions](../core/functions.md)
- [Primitives](../core/primitives.md)
- [Base type](../core/types.md#base-types)
- [Extended type](../core/types.md#extended-types)
