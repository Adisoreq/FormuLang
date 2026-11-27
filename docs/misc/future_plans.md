# Future plans

Plans for enhancements in the future

Concrete proposals for the next versions of the standards (Core 1.2, Stock 1.2), with drafts of the specification, and the changes kept for 2.0, are in [Proposals for the 1.2 standards](proposals.md).

## Future Extensions

### 1. Stock Extension

Specified as the [**Stock**](../standards/stock/README.md) standard (`stock-1.1`).

### 2. Time (Core)

Specified in the **Core** standard: points in time are **Number** values (Unix time in milliseconds, UTC), with the [time functions](../standards/core/functions/README.md#10-time-functions) (`YEAR`, `MONTH`, `DAY`, `WEEKDAY`, `HOUR`, `MINUTE`, `SECOND`, `MILLISECOND`, `DATE`, `FORMAT_TIME`), the `NOW` constant, the `@time_offset` variable and the [Time Context](../core/context.md#3-time-context).

Possible future additions: time zone names with daylight saving time (e.g. `"Europe/Warsaw"`), parsing text into a point in time, and the names of months and days in `FORMAT_TIME`.

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

## Implementations

Done: the standard is implemented by [FormuLang.NET](https://github.com/Adisoreq/formulang-dotnet) (NuGet, C# .NET 8.0+) and [FormuLang-TS](https://github.com/Adisoreq/formulang-ts) (npm `formulang-ts`, TypeScript and JavaScript). See [Implementations](../../README.md#implementations).
