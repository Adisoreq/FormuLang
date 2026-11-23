# DATE

Time [**Core**](../README.md) standard function. Creates a point in time from its date and time parts.

A point in time is a **Number**: Unix time in milliseconds, UTC (see [Time functions](README.md#10-time-functions)). The parts are read as local time defined by the `@time_offset` environment variable.

## Overloads

### Overload 1

Signature: `DATE(year <Number>, month <Number>, day <Number>, hour? <Number>, minute? <Number>, second? <Number>, millisecond? <Number>)`

Collection template:

| # | Name |   | Base type | Extended type | Any type | Multiple | Optional |
| - | :--: | - | :-------: | :-----------: | :------: | :------: | :------: |
| 1 | year | | Number | - | false | false | false |
| 2 | month | | Number | - | false | false | false |
| 3 | day | | Number | - | false | false | false |
| 4 | hour | | Number | - | false | false | true |
| 5 | minute | | Number | - | false | false | true |
| 6 | second | | Number | - | false | false | true |
| 7 | millisecond | | Number | - | false | false | true |

Algorithm:

1. An omitted optional argument is `0`.
2. If an argument is not a whole number, returns an `OPERATION_ERROR`.
3. If a part is outside of its range, returns an `OPERATION_ERROR`. The parts are not carried over to the next unit: `DATE(2026, 13, 1)` and `DATE(2026, 2, 30)` are errors, not dates in the next year or month.

   | Part | Range |
   | :--- | :---- |
   | `year` | `1` - `9999` |
   | `month` | `1` - `12` |
   | `day` | `1` - number of days of the month (February has `29` days in a leap year) |
   | `hour` | `0` - `23` |
   | `minute` | `0` - `59` |
   | `second` | `0` - `59` |
   | `millisecond` | `0` - `999` |

4. Computes the number of milliseconds from `1970-01-01 00:00:00.000` to the given local time, in the proleptic Gregorian calendar.
5. Returns that number minus `@time_offset * 60000` (the UTC point in time).

Examples (`@time_offset` = `0`, unless stated otherwise):

| Formula | Result |
| :------ | :----- |
| `DATE(1970, 1, 1)` | `0` |
| `DATE(2026, 11, 23)` | `1795392000000` |
| `DATE(2026, 11, 23, 10, 51, 20, 123)` | `1795431080123` |
| `DATE(2026, 11, 23, 10, 51, 20, 123)` with `@time_offset` = `60` | `1795427480123` |
| `DATE(2024, 2, 29)` | `1709164800000` |
| `DATE(2023, 2, 29)` | `[OPERATION_ERROR (3)] ...` |
| `DATE(2026, 13, 1)` | `[OPERATION_ERROR (3)] ...` |
| `DATE(2026, 1, 1.5)` | `[OPERATION_ERROR (3)] ...` |

`DATE` is the inverse of the [part functions](README.md#10-time-functions): `DATE(YEAR($t), MONTH($t), DAY($t), HOUR($t), MINUTE($t), SECOND($t), MILLISECOND($t))` is `$t`.

## Errors

- [`OPERATION_ERROR`](../errors/OPERATION_ERROR.md) - an argument is not a whole number, or a part is outside of its range.
- [`ARGUMENT_ERROR`](../errors/ARGUMENT_ERROR.md) - the arguments match no overload. If one of the arguments is an **Error**, that **Error** is returned instead (see [Evaluation](../../../semantics/evaluation.md#3-function-call)).

## Reference

- [Core standard](../README.md)
- [Time functions](README.md#10-time-functions)
- [`FORMAT_TIME`](FORMAT_TIME.md)
