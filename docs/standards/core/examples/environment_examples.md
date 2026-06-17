# Environment examples

List of examples of the use of environment constants, variables and procedures.

## Examples

### Example 1

#### Formula:

```
$SET x 4.25
RETURN x
```

#### Result:

```
4.25
```

#### Explanation:

`SET` procedure is equivalent to variable assingment, while `RETURN` procedure is responsible for returning the formula result.

### Example 2

#### Formula:

```
$standards = ARRTOSTR(SUPPORTED_STANDARDS)
CONCAT("Supported standards: ", standards)
```

#### Result:

```
Supported standards: ["core-1.1.3", "stock-5.2.11"]
```

#### Explanation:

`SUPPORTED_STANDARDS` is the environment constant that contains information about **FormuLang** version and extensions supported by the specified implementation.

### Example 3

#### Formula:

```
@REQUIRE "core-1.3.2"
@REQUIRE "stock-5.2+.x"

$diff = CLOSE[I] - OPEN[I]
$result = IF(diff > 0, 1, -1)

result
```

#### Result:

```
NOT_SUPPORTED_ERROR: "stock-5.2+.x" is not supported.
```

#### Explanation:

The `REQUIRE` procedure throws an error if the environment doesn't support specified standard.

Required standards in example are:
- `core`
  - Exact version: **1.3.2**
- `stock`
  - Major version: **5** (exact)
  - Minor version: **2** (or higher)
  - Patch version: **any**

### Example 4

#### Formula:

```
@REQUIRE "math-1.x.x"
$radius = 2
# Field = pi * r^2
MUL(PI, POW(radius, 2))
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
elements[1]
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
ENVIRONMENT_ERROR: "x" is not defined.
```

#### Explanation:

Unlike **context**, **environment** doesn't allow referring to non-existing variables.

## Reference
- [Environment](../core/environment.md)