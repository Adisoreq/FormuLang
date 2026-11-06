# Future plans

Plans for enhancements in the future

## Future Extensions

### 1. Stock Extension

#### Description

Stock-oriented data types and indicator functions.

#### Indicator context structure:

| Container | Primitive type | Base type | Description |
| --- | --- | --- | --- |
| I | `Container` / `Constant` | `Number` | Current loop iteration |
| N | `Container` / `Constant` | `Number` | Number of candles in array |
| CANDLES | `Container` / `Constant` | `Array` | Array of candles to compute indicators |
| OPEN | `Container` / `Constant` | `Array` | Extracted array of open values from candles |
| CLOSE | `Container` / `Constant` | `Array` | Extracted array of close values from candles |
| HIGH | `Container` / `Constant` | `Array` | Extracted array of high values from candles |
| LOW | `Container` / `Constant` | `Array` | Extracted array of low values from candles |
| VOLUME | `Container` / `Constant` | `Array` | Amount of volume per candle |

#### Example 1

Operating on candle data type.

Formula:
```php
CANDLE(5_000, 4_000, 5_500, 4_500)
```

Result:
```js
[Stock.Candle] { open: 5000, close: 4000, high: 5500, low: 4500 }
```

#### Example 2 

Defining Simple Moving Average (SMA) indicator

Formula:
```php
$period = ARGS[0] # Period is the first parameter
$diff = I - $period
$skip = $diff < 0 # Returns no value if didn't reach period

$arr = RANGE(CLOSE, MAX([0, $diff]), I) # Get period range

IF($skip, null, AVG($arr)) # Return average (or null if before period)
```

### 2. Geometry Extension

#### Description

Allows geometrical operations

#### Example 1

2D points

Formula:
```php
$a = POINT_2D(10, 4)
$b = POINT_2D(2.5, -2)
DISTANCE($a, $b)
```

Result:
```
9.6046863561493
```

#### Example 2

2D figures

Formula:
```php
$a = POINT_2D(0, 0); $b = POINT_2D(0, 4); $c = POINT_2D(4, 4); $d = POINT_2D(4, 0)
$ab = EDGE_2D($a, $b); $bc = EDGE_2D($b, $c); $cd = EDGE_2D($c, $d); $da = EDGE_2D($d, $a)

FIGURE_2D($ab, $bc, $cd, $da)
```

Result:
```js
[Geometry.Figure2D] {
    vertices: [
        [Geometry.Point2D] { x: 0; y: 0 },
        [Geometry.Point2D] { x: 0; y: 4 },
        [Geometry.Point2D] { x: 4; y: 4 },
        [Geometry.Point2D] { x: 4; y: 0 },
    ],
    edges: [
        [Geometry.Edge2D] {
            start: [Geometry.Point2D] { x: 0; y: 0 },
            end: [Geometry.Point2D] { x: 0; y: 4 },
            length: 4
        },
        [Geometry.Edge2D] {
            start: [Geometry.Point2D] { x: 0; y: 4 },
            end: [Geometry.Point2D] { x: 4; y: 4 },
            length: 4
        },
        [Geometry.Edge2D] {
            start: [Geometry.Point2D] { x: 4; y: 4 },
            end: [Geometry.Point2D] { x: 4; y: 0 },
            length: 4
        },
        [Geometry.Edge2D] {
            start: [Geometry.Point2D] { x: 4; y: 0 },
            end: [Geometry.Point2D] { x: 0; y: 0 },
            length: 4
        }
    ],
    perimeter: [Geometry.Perimeter2D] {
        functions: null,
        length: 16
    },
    area: 16
}
```

#### Example 3

2D circle

Formula:
```php
$center = POINT_2D(2, 2)
$radius = 4

CIRCLE_2D($center, $radius)
```

Result:
```js
[Geometry.Circle2D] {
    vertices: null,
    edges: null,
    center: [Geometry.Point2D] { x: 2, y: 2 };
    radius: 4,
    area: 50.2654824574,
    perimeter: [Geometry.Perimeter2D] {
        functions: [
            (x) => 2 + SQRT(r^2 - (x - 2)^2),
            (x) => 2 - SQRT(r^2 - (x - 2)^2)
        ],
        length: 25.1327412287
    }
}
```

### 3. Algebra Extension

#### Descriptions

Provides calculations with new types: Vector, Matrix.

## Future Implementations

### 1. FormuLang.NET

NuGet library for C# .NET 8.0+

### 2. formulang

npm library for JavaScript and TypeScript solutions