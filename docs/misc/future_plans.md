# Future plans

Plans for enhancements in the future

## Future Extensions

### 1. Stock Extension

Specified as the [**Stock**](../standards/stock/README.md) standard (`stock-0.1`).

### 2. Time types (Core)

#### Description

Extended types for dates and durations (year, month, day, hour, minute, second), shared by every standard. Until then, points in time are **Number** values: Unix time in milliseconds, UTC (see the `TIME` constant of the [Stock](../standards/stock/README.md) standard).

### 3. Geometry Extension

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

### 4. Algebra Extension

#### Descriptions

Provides calculations with new types: Vector, Matrix.

## Future Implementations

### 1. FormuLang.NET

NuGet library for C# .NET 8.0+

### 2. formulang

npm library for JavaScript and TypeScript solutions