# FORMAT_TIME

Time [**Core**](../README.md) standard function. Converts a point in time to **Text**, following a format.

A point in time is a **Number**: Unix time in milliseconds, UTC (see [Time functions](README.md#10-time-functions)). The result uses the local time defined by the `@time_offset` environment variable.

## Format syntax

The format is a **Text**. The following **format tokens** are replaced with the parts of the local time; every other character is copied unchanged. Tokens are case-sensitive (`MM` is the month, `mm` is the minute).

| Token | Part | Example (`2026-11-23 10:51:20.123`) |
| :---- | :--- | :---------------------------------- |
| `YYYY` | Year, 4 digits | `2026` |
| `MM` | Month, 2 digits | `11` |
| `DD` | Day of the month, 2 digits | `23` |
| `hh` | Hour (`00` - `23`), 2 digits | `10` |
| `mm` | Minute, 2 digits | `51` |
| `ss` | Second, 2 digits | `20` |
| `iii` | Millisecond, 3 digits | `123` |

Rules:

- The format is read from left to right. At every position, the longest token that starts there is replaced; otherwise the character is copied.
- Only the tokens from the table are recognized: a single `Y`, `M`, `D`, `h`, `m`, `s` or `i` is copied unchanged. For example, `YY` is copied as `YY`.
- To write the letters of a token as text, enclose them in square brackets: `[` and `]` are removed and the characters between them are copied unchanged, e.g. `"[Today:] DD.MM"` → `"Today: 23.11"`. `[[` writes a literal `[`, and `]]` a literal `]`.

## Overloads

### Overload 1

Signature: `FORMAT_TIME(time <Number>, format <Text>)`

Collection template:

| # | Name |   | Base type | Extended type | Any type | Multiple | Optional |
| - | :--: | - | :-------: | :-----------: | :------: | :------: | :------: |
| 1 | time | | Number | - | false | false | false |
| 2 | format | | Text | - | false | false | false |

Algorithm:

1. If `time` is not a whole number, returns an `OPERATION_ERROR`.
2. Computes the local time: `time + @time_offset * 60000`. If it is outside of the supported range (years `1` - `9999`), returns an `OPERATION_ERROR`.
3. If `format` has a `[` without a closing `]`, returns an `OPERATION_ERROR`.
4. Returns `format` with every format token replaced (see [Format syntax](#format-syntax)).

Examples (`@time_offset` = `0`, unless stated otherwise):

| time | format | FORMAT_TIME(time, format) |
| :--- | :----- | :------------------------ |
| `1795431080123` | `"YYYY-MM-DD[T]hh:mm:ss.iii"` | `"2026-11-23T10:51:20.123"` |
| `1795431080123` | `"DD/MM/YYYY, hh:mm"` | `"23/11/2026, 10:51"` |
| `1795431080123`, `@time_offset` = `60` | `"hh:mm"` | `"11:51"` |
| `0` | `"YYYY-MM-DD"` | `"1970-01-01"` |
| `0` | `"[Year] YYYY"` | `"Year 1970"` |
| `0` | `"Y-M-D"` | `"Y-M-D"` |
| `0` | `"[YYYY"` | `[OPERATION_ERROR (3)] ...` |

> **Note:** In `"YYYY-MM-DDThh:mm"` the `T` is not a token, so it is copied without brackets. The brackets are only needed for the letters of a token, e.g. `[hh]`.

## Errors

- [`OPERATION_ERROR`](../errors/OPERATION_ERROR.md) - `time` is not a whole number or is outside of the supported range, or `format` has an unclosed `[`.
- [`ARGUMENT_ERROR`](../errors/ARGUMENT_ERROR.md) - the arguments match no overload. If one of the arguments is an **Error**, that **Error** is returned instead (see [Evaluation](../../../semantics/evaluation.md#3-function-call)).

## Reference

- [Core standard](../README.md)
- [Time functions](README.md#10-time-functions)
- [`DATE`](DATE.md)
- [`FORMAT`](FORMAT.md)
