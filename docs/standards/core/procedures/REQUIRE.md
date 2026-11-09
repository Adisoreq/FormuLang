# REQUIRE

Environment [**Core**](../README.md) standard procedure. Ensures that the environment supports the requested standard (or standards).

## Overloads

### Overload 1

Signature: `REQUIRE(standard <Text>)`

Collection template:

| # | Name |   | Base type | Extended type | Any type | Multiple | Optional |
| - | :--: | - | :-------: | :-----------: | :------: | :------: | :------: |
| 1 | standard | | Text | - | false | false | false |

### Overload 2

Signature: `REQUIRE(standards <Array>)`

Collection template:

| # | Name |   | Base type | Extended type | Any type | Multiple | Optional |
| - | :--: | - | :-------: | :-----------: | :------: | :------: | :------: |
| 1 | standards | | Array | - | false | false | false |

Every element of the array must be a **Text** with a requirement, and every requirement must be satisfied. The requirements are checked in order; the first one that is not satisfied is reported.

## Requirement format

A requirement is a **Text** consisting of the name of the standard, a hyphen (`-`) and a version pattern:

```regexp
^[a-zA-Z_]\w*-(?:\d+\+?|x)(?:\.(?:\d+\+?|x))*$
```

The version pattern consists of segments separated by dots (`.`), in the same order as the segments of the standard's version (e.g. major and minor). Every segment is one of:

| Segment | Meaning |
| :------ | :------ |
| `n` | exactly the number `n` |
| `n+` | the number `n` or higher; the segments before it must still match exactly |
| `x` | any number |

A requirement may have fewer segments than the version of the standard; the missing segments are treated as `x`.

Every segment is checked on its own. A `+` raises the lower limit of its own segment only, so it never allows a higher value of a segment before it. For example, `core-0.2+` allows `core-0.3` and `core-0.5`, but not `core-1.0`, because the major segment `0` must match exactly. To allow higher major versions, put the `+` on the major segment: `core-1+`.

| Requirement | Satisfied by | Not satisfied by |
| :---------- | :----------- | :--------------- |
| `core-0.2` | `core-0.2` | `core-0.1`, `core-1.0` |
| `core-0.2+` | `core-0.2`, `core-0.3`, `core-0.5` | `core-0.1`, `core-1.0` |
| `core-0.x` | `core-0.1`, `core-0.2` | `core-1.0` |
| `core-1` | `core-1.0`, `core-1.4` | `core-0.2`, `core-2.0` |
| `core-1+` | `core-1.0`, `core-1.4`, `core-2.3` | `core-0.2` |
| `stock-5.2+` | `stock-5.2`, `stock-5.7` | `stock-5.1`, `stock-6.0` |

## Behavior

1. The requirement is matched against the elements of the environment constant `STANDARDS` (each of them is an identifier in the form `<name>-<version>`).
2. The requirement is satisfied if at least one element has the same name and a version that matches every segment of the version pattern.
3. If it is satisfied, the procedure does nothing else.

## Errors

- [`NOT_SUPPORTED_ERROR`](../errors/NOT_SUPPORTED_ERROR.md) - none of the elements of `STANDARDS` satisfies the requirement.
- [`OPERATION_ERROR`](../errors/OPERATION_ERROR.md) - the requirement doesn't follow the format described above.
- [`ARGUMENT_ERROR`](../errors/ARGUMENT_ERROR.md) - the argument is neither a **Text** nor an **Array** of **Text**.

## Result

[`SUCCESS`](../errors/SUCCESS.md) **Error** if every requirement is satisfied.

## Examples

Assuming `STANDARDS` is `[ "core-0.3" ]`:

| Formula | Result |
| :------ | :----- |
| `REQUIRE "core-0.2+"` | `SUCCESS` |
| `REQUIRE(["core-0.x", "core-0.3"])` | `SUCCESS` |
| `REQUIRE "stock-5.2+"` | `[NOT_SUPPORTED_ERROR (11)] Standard "stock-5.2+" is not supported.` |
| `REQUIRE "core-1.0+"` | `[NOT_SUPPORTED_ERROR (11)] Standard "core-1.0+" is not supported.` |
| `REQUIRE "core"` | `[OPERATION_ERROR (3)] "core" is not a valid standard requirement.` |

> **Note:** `REQUIRE` is meant to be placed at the beginning of a formula. If the requirement is not satisfied, its error reaches the root of the sequence and aborts the execution, so none of the following sequences is evaluated.

## Reference

- [Core procedures](README.md)
- [Core standard](../README.md#environment-structure)
- [Environment examples](../examples/environment_examples.md)
- [Environment](../../../core/environment.md)
