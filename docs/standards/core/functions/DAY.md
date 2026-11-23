# DAY

Time [**Core**](../README.md) standard function. Returns the day of the month of a point in time, from `1` to `31`.

A point in time is a **Number**: Unix time in milliseconds, UTC (see [Time functions](README.md#10-time-functions)). The result uses the local time defined by the `@time_offset` environment variable.

## Overloads

### Overload 1

Signature: `DAY(time <Number>)`

Collection template:

| # | Name |   | Base type | Extended type | Any type | Multiple | Optional |
| - | :--: | - | :-------: | :-----------: | :------: | :------: | :------: |
| 1 | time | | Number | - | false | false | false |

Algorithm:

1. If `time` is not a whole number, returns an `OPERATION_ERROR`.
2. Computes the local time: `time + @time_offset * 60000`.
3. If the local time is outside of the supported range (years `1` - `9999`), returns an `OPERATION_ERROR`.
4. Returns the day of the month (`1` - `31`) of the local time, in the proleptic Gregorian calendar.

Examples (`@time_offset` = `0`, unless stated otherwise):

| time | Moment (local time) | DAY(time) |
| :--- | :------------------ | :----------: |
| `1795431080123` | 2026-11-23 10:51:20.123 (Monday) | 23 |
| `1709249400000` | 2024-02-29 23:30:00.000 (Thursday) | 29 |
| `1709249400000`, `@time_offset` = `60` | 2024-03-01 00:30:00.000 (Friday) | 1 |
| `0` | 1970-01-01 00:00:00.000 (Thursday) | 1 |
| `-1` | 1969-12-31 23:59:59.999 (Wednesday) | 31 |
| `1.5` | - | `[OPERATION_ERROR (3)] ...` |

## Errors

- [`OPERATION_ERROR`](../errors/OPERATION_ERROR.md) - `time` is not a whole number, or is outside of the supported range.
- [`ARGUMENT_ERROR`](../errors/ARGUMENT_ERROR.md) - the arguments match no overload. If one of the arguments is an **Error**, that **Error** is returned instead (see [Evaluation](../../../semantics/evaluation.md#3-function-call)).

## Reference

- [Core standard](../README.md)
- [Time functions](README.md#10-time-functions)
- [`DATE`](DATE.md)
- [`FORMAT_TIME`](FORMAT_TIME.md)