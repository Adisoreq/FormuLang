# Time examples

Examples of the [time functions](../functions/README.md#10-time-functions) and of the [Time Context](../../../core/context.md#3-time-context). A point in time is a **Number**: Unix time in milliseconds, UTC.

## Example 1: Current date as text

**Context**: Default Context, `NOW` = `1795431080123` (2026-11-23 10:51:20.123 UTC)

#### Formula:

```php
$iso = FORMAT_TIME(NOW, "YYYY-MM-DDThh:mm:ss.iii")   # "2026-11-23T10:51:20.123"
$short = FORMAT_TIME(NOW, "DD/MM/YYYY, hh:mm")       # "23/11/2026, 10:51"

@time_offset = 60                                    # UTC+1, only for this execution
$local = FORMAT_TIME(NOW, "hh:mm")                   # "11:51"

FORMAT("{} | {} | {}", [$iso, $short, $local])
```

#### Result:

```
2026-11-23T10:51:20.123 | 23/11/2026, 10:51 | 11:51
```

## Example 2: Parts of a date

**Context**: Default Context, `NOW` = `1795431080123`

#### Formula:

```php
$days = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]

# WEEKDAY is 1 for Monday; the array index starts at @array_indexing (0)
$name = $days[WEEKDAY(NOW) - 1]

FORMAT("{} {}.{}.{}", [$name, DAY(NOW), MONTH(NOW), YEAR(NOW)])
```

#### Result:

```
Monday 23.11.2026
```

## Example 3: Days until a date

**Context**: Default Context, `NOW` = `1795431080123`

#### Formula:

```php
$day_ms = 24 * 60 * 60 * 1000
$today = DATE(YEAR(NOW), MONTH(NOW), DAY(NOW))   # midnight of the current day
$new_year = DATE(YEAR(NOW) + 1, 1, 1)

($new_year - $today) / $day_ms
```

#### Result:

```
39
```

## Example 4: Animation in the Time Context

**Context**: Time Context, executed for every frame

**Result**: the angle of a hand that turns once every 4 seconds, in degrees.

#### Formula:

```php
$period_s = 4
MOD(TIME_S / $period_s * 360, 360)
```

| Frame | `TIME_S` | Result |
| :---: | :------: | :----: |
| 0 | `0` | `0` |
| 1 | `0.5` | `45` |
| 2 | `1` | `90` |
| 3 | `4.25` | `22.5` |

## Example 5: Accumulation with delta time

**Context**: Time Context, executed for every frame

**Result**: the distance covered by an object that accelerates by `2` units per second², starting from rest. The state is kept in `PREV`.

#### Formula:

```php
$acceleration = 2
$state = IF(ISNULL(PREV), { speed: 0, distance: 0 }, PREV)

$speed = $state.speed + $acceleration * DTIME_S
{ speed: $speed, distance: $state.distance + $speed * DTIME_S }
```

| Frame | `DTIME_S` | Result |
| :---: | :-------: | :----- |
| 0 | `0` | `{ speed: 0, distance: 0 }` |
| 1 | `0.5` | `{ speed: 1, distance: 0.5 }` |
| 2 | `0.5` | `{ speed: 2, distance: 1.5 }` |

## Reference

- [Time functions](../functions/README.md#10-time-functions)
- [Context](../../../core/context.md#3-time-context)
- [`FORMAT`](../functions/FORMAT.md)
