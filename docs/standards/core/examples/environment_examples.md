# Environment examples

List of examples showing environment constants and variables, and procedures defined by the **Core** standard.

## Examples

### Example 1

#### Formula:

```
SET $x 4.25
$x
```

#### Result:

```
4.25
```

#### Explanation:

`SET` procedure is equivalent to variable assignment (`$x = 4.25`). The formula's result is the value of the last statement, here `$x`.

### Example 2

#### Formula:

```
$standards = JOIN(STANDARDS, ", ")
CONCAT("Supported standards: ", $standards)
```

#### Result:

```
Supported standards: core-0.2, stock-5.2
```

#### Explanation:

`STANDARDS` is the environment constant that contains the identifiers of the standards supported by the specified implementation.

### Example 3

#### Formula:

```
REQUIRE "core-0.2"
REQUIRE "stock-5.2+"

$diff = CLOSE[I] - OPEN[I]
$result = IF($diff > 0, 1, -1)

$result
```

#### Result:

```
[NOT_SUPPORTED_ERROR (11)] Standard "stock-5.2+" is not supported.
```

#### Explanation:

The [`REQUIRE`](../procedures/REQUIRE.md) procedure returns an error if the environment doesn't support the specified standard.

Required standards in example are:
- `core`
  - Exact version: **0.2**
- `stock`
  - Major version: **5** (exact)
  - Minor version: **2** (or higher)

### Example 4

#### Formula:

```
REQUIRE "math-1.x"
$radius = 2
# Field = pi * r^2
MUL(PI, POW($radius, 2))
```

#### Result:

```
12.5663706144
```

#### Explanation:

Some constants (like `PI`, `E`, etc.) are defined by a standard.

### Example 5

#### Formula:

```
@array_indexing = 1

$elements = ARRAY(10, 20, 30, 40)
$elements[1]
```

#### Result:

```
10
```

#### Explanation:

The `array_indexing` environment variable informs the parser whether arrays within the formula are being indexed from **0** (default), **1**, or any other number.

### Example 6

#### Formula:

```
@x = 1
```

#### Result:

```
[ENVIRONMENT_ERROR (10)] Environment variable "x" is not defined.
```

#### Explanation:

Unlike **context**, **environment** doesn't allow referring to non-existing variables.

## Reference
- [Environment](../../../core/environment.md)