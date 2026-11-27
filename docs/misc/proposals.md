# Proposals for the 1.2 standards

Changes proposed for **Core 1.2** and **Stock 1.2**, and a list of changes kept for **2.0**. They come from the first host application that uses FormuLang in production (the trading platform MontBlanc), which had to add its own functions and conventions where the 1.1 standards were not enough. A strategy written for MontBlanc therefore does not work in another implementation. The goal of 1.2 is that such a strategy can be written with the standard alone.

**Status (2026-11-27):** all the 1.2 proposals are specified in the standard documents ([Core changelog](../standards/core/CHANGELOG.md#12), [Stock changelog](../standards/stock/CHANGELOG.md#12)) and covered by conformance tests; the implementations are not done yet.

A proposal moves to the standard once it is specified in the standard documents, covered by conformance tests and implemented in [FormuLang.NET](https://github.com/Adisoreq/formulang-dotnet) and [FormuLang-TS](https://github.com/Adisoreq/formulang-ts).

Every 1.2 proposal keeps the **1.x** promise: a formula valid in `1.1` gives the same result in `1.2`. New behaviour is only possible where `1.1` gives an error, or where the host application chooses it. Changes that break the promise are listed in [Kept for 2.0](#kept-for-20).


## Overview

### Core 1.2

| # | Proposal | Level | Size |
| :-: | :------- | :---: | :--: |
| [C1](#c1-formula-metadata) | Formula metadata `<@ { ... } @>` | language + Core | medium |
| [C2](#c2-cold-and-hot-execution) | Cold and hot execution (prepared formulas) | language | small |
| [C3](#c3-and-and-or-with-many-arguments) | `AND` and `OR` with many arguments | Core | small |
| [C4](#c4-short-circuit-of-and-and-or) | Short circuit of `AND` and `OR` | Core | small |
| [C5](#c5-history-in-the-iteration-context) | `HISTORY` in the Iteration Context | Core | small |
| [C6](#c6-memory-store-recall-clear) | Memory: `STORE`, `RECALL`, `CLEAR` | Core | medium |
| [C7](#c7-resumed-iterations) | Resumed iterations | Core | small |
| [C8](#c8-validation-warnings) | Validation warnings | Core | small |

### Stock 1.2

| # | Proposal | Size | Replaces in MontBlanc |
| :-: | :------- | :--: | :-------------------- |
| [S1](#s1-parameters-in-the-strategy-context) | `PARAMETERS` in the Strategy Context | small | the constant added by the host |
| [S2](#s2-timeframe-and-instrument) | `TIMEFRAME` and `INSTRUMENT` | small | - |
| [S3](#s3-other-timeframes) | Candles and indicators of other timeframes | large | `IND_TF`, `CANDLES_TF` |
| [S4](#s4-object-result-of-a-strategy) | Object result of a strategy (`signal`, `reason`, `checks`), `SCORE` | small | `CHECK`, `NOTE`, part of the result object |
| [S5](#s5-trading-helpers) | Trading helpers (`READY`, `CROSSOVER`, `HIGHEST`, ...) | medium | hand-written conditions |
| [S6](#s6-stock-metadata-and-the-registry) | Stock metadata and the registry | small | the parameter fields of the editor |

What stays specific to the host application, and why, is listed in [What stays in the host application](#what-stays-in-the-host-application). The example strategy rewritten with the proposals is in [Example](#example-macd--ema200).


## C1. Formula metadata

**Level:** language (syntax) and Core (keys) · **Size:** medium

### Motivation

A host application needs to know things about a formula before it executes it: its identifier, its context type, its parameters with their default values, a description for the user. Today they are kept outside of the formula (in the fields of an editor, in the formula registry), or in a comment that only a human can read.

### Proposal

A formula may start with a **metadata block**: `<@`, one Object literal, `@>`.

```php
<@ {
  id: "sma-cross",
  name: "SMA cross",
  description: "Buys when the fast SMA crosses above the slow one.",
  author: "Jan Kowalski",
  version: "1.0.0",
  context: "Stock.Strategy",
  parameters: {
    fast: { type: "Number", default: 10, min: 1, description: "Period of the fast SMA" },
    slow: { type: "Number", default: 50, min: 1 }
  },
  stock: { category: "Trend" }
} @>
REQUIRE "stock-1.2+"
...
```

Rules:

1. The block is recognized only as the **first element** of the formula: only white space and comments may be before it. There is at most one block. Anywhere else, `<@` is what it is in `1.1`: the operator `<` followed by an environment variable (`$a <@array_indexing`).
2. The content is **one Object literal** made of constant values only: **Number**, **Text**, **Boolean**, `null`, **Array** and **Object** literals, and the unary `-` before a number. Variables, constants, functions and other operators are a `SYNTAX_ERROR`. The metadata can therefore be read without executing the formula.
3. The content is tokenized as code, not as a comment, so a text may contain `@>`, `#` or `<#`.
4. The block is read once, in the new **metadata reading** step of the preparation (see [C2](#c2-cold-and-hot-execution)), and then removed. It never takes part in the evaluation: a formula with a metadata block gives the same result as without it.
5. A block that does not follow the rules is a `SYNTAX_ERROR` of the formula.

Keys defined by **Core** (all optional):

| Key | Type | Description |
| :-- | :--: | :---------- |
| `id` | `Text` | Identifier of the formula, e.g. used in a registry. Follows the [identifier naming restrictions](../syntax/naming.md#naming-restrictions), or contains `-` (e.g. `"macd-ema200"`). |
| `name` | `Text` | Name for the user. |
| `description` | `Text` | Description for the user. |
| `author` | `Text` | Author. |
| `version` | `Text` | Version of the formula (not of a standard). |
| `context` | `Text` | Name of the context type the formula is written for: `"Default"`, `"Iteration"`, `"Time"`, or a type of an extension standard (`"Stock.Indicator"`). |
| `result` | `Text` or `Array<Text>` | Type (or types) of the expected result, e.g. `"Number"`, `["Number", "Object"]`. |
| `requires` | `Text` or `Array<Text>` | Standards required by the formula, with the syntax of [`REQUIRE`](../standards/core/procedures/REQUIRE.md). Informational: it does not replace `REQUIRE`. |
| `parameters` | `Object` | Parameters of the formula: key → **parameter description** (below). |

A parameter description is an Object with the keys `type` (**Text**, the type name, e.g. `"Number"`), `default` (any value), `name`, `description` (**Text**), `min`, `max` (**Number**) and `options` (**Array** of allowed values). All are optional.

**Extensibility:**

- Core keys are lowercase names at the top level of the object.
- Every extension standard owns **one** top-level key equal to its name in lowercase (`stock` for **Stock**), and specifies its content in its own documentation. A new standard never adds other top-level keys.
- Keys of a host application go under `x`, one key per application: `x: { montblanc: { ... } }`.
- Unknown keys are kept and ignored, so a formula with the metadata of a newer standard still runs.
- The validation checks the types of the known keys and reports a wrong type as a **warning** (see [C8](#c8-validation-warnings)), not as an error: wrong metadata never stops a formula.

### Compatibility

`<@` at the beginning of a formula has no left operand, so it is a `SYNTAX_ERROR` in `1.1`. No valid `1.1` formula changes. A `1.1` implementation cannot execute a formula with metadata; a host application may cut the block out before it passes the formula to an older implementation.

### Implementation

A new token of the tokenizer (recognized only at the first position), and a small constant-literal reader that reuses the literal parser. Both libraries return the metadata as an `IObject` / object next to the prepared formula.


## C2. Cold and hot execution

**Level:** language (execution semantics) · **Size:** small

### Motivation

A formula in an Iteration Context is executed once per candle, often thousands of times. Validation, clean-up, tokenization and parsing do not depend on the context, but the [execution](../semantics/execution.md) describes them as a part of every execution.

### Proposal

The [execution steps](../semantics/execution.md) are split into two phases:

| Phase | Steps | Depends on |
| :---- | :---- | :--------- |
| **Preparation** | validation of the syntax, metadata reading ([C1](#c1-formula-metadata)), clean-up, tokenization, parsing | the formula and the symbols of the environment (functions and procedures known to the parser) |
| **Evaluation** | evaluation, finalization | the prepared formula and the context |

The result of the preparation is a **prepared formula**: the expression trees of the sequences and the metadata.

- **Cold execution**: the whole pipeline, from pre-execution to post-execution. Used for a single execution.
- **Hot execution**: the evaluation of a prepared formula in a new context, or in the next iteration or frame of the same context. Used when the same formula is executed many times.

Rules:

1. A prepared formula may be evaluated any number of times as long as the symbols of the environment do not change.
2. The validation of the environment is done once for every context, not for every iteration.
3. A hot execution gives the same result as a cold execution of the same formula in the same context (the as-if rule, as for the [optimization of `IF`](../standards/core/functions/IF.md#performance) and the [stored series of `LOAD_INDICATOR`](../standards/stock/functions/LOAD_INDICATOR.md#performance)).

### Compatibility

A description of what implementations may already do; results do not change.


## C3. `AND` and `OR` with many arguments

**Level:** Core · **Size:** small

New overloads `AND(...values <Boolean>)` and `OR(...values <Boolean>)` with at least 2 arguments: `AND(a, b, c)` is `a && b && c`.

```php
AND(CLOSE[I] > $ema, $rsi < 30, $volume > $avg)
```

**Compatibility:** `AND` with 3 or more arguments is an `ARGUMENT_ERROR` in `1.1`.


## C4. Short circuit of `AND` and `OR`

**Level:** Core · **Size:** small

### Motivation

A condition often guards the next one: `READY($ema, 1) && CLOSE[I] > $ema[I]`. In `1.1` both operands are computed, and an **Error** in the second one is the result even if the first one is `false`.

### Proposal

1. `AND`: if an argument is `false`, the result is `false`, and an **Error** in a later argument is discarded. `OR`: the same with `true`. The arguments are checked from the left; an **Error** before the first deciding argument is returned as before.
2. The [Performance](../standards/core/functions/IF.md#performance) note of `IF` applies to `AND` and `OR`: an implementation **may** skip the arguments after the deciding one, as long as the result and every side effect are the same.
3. The writes to the memory ([C6](#c6-memory-store-recall-clear)) of a skipped argument are discarded, as for a branch of `IF`.

| Formula | `1.1` | `1.2` |
| :------ | :---- | :---- |
| `false && ERROR("x")` | `[CUSTOM_ERROR (1)] x` | `false` |
| `true \|\| 1 / 0` | `[OPERATION_ERROR (3)] ...` | `true` |
| `ERROR("x") && false` | `[CUSTOM_ERROR (1)] x` | `[CUSTOM_ERROR (1)] x` |

### Compatibility

Only results that were an **Error** change. Assignments in a skipped argument are still executed in `1.2`; a lazy evaluation that skips them is kept for [2.0](#kept-for-20).


## C5. `HISTORY` in the Iteration Context

**Level:** Core · **Size:** small

### Motivation

`PREV` gives the result of the previous iteration only. An indicator that needs the highest of its own last 20 values must keep them in its result.

### Proposal

A new constant of the [Iteration Context](../core/context.md#2-iteration-context):

| Constant | Type | Description |
| :------- | :--: | :---------- |
| `HISTORY` | `Array` | Results of all the previous iterations, from the first one. It has `I - @array_indexing` elements (empty in the first iteration), so `HISTORY[k]` is the result of the iteration `k`, and its last element is `PREV`. |

```php
# A strategy that gives at most 3 BUY signals.
$buys = LEN(FILTER(HISTORY, (r) => r == BUY))
IF($buys < 3 && CLOSE[I] > OPEN[I], BUY, NEUTRAL)
```

Only the Iteration Context gets `HISTORY`: the frames of a Time Context have no end, so the array would grow without a limit.

**Implementation:** one growing array shared by all the iterations; an iteration sees a read-only view of its first elements, so nothing is copied.

**Compatibility:** a new constant; constants have no sigil, and a `1.1` formula that uses `HISTORY` is an `UNKNOWN_SYMBOL_ERROR`.


## C6. Memory: `STORE`, `RECALL`, `CLEAR`

**Level:** Core · **Size:** medium

### Motivation

An indicator that keeps a state between candles (Wilder's RSI keeps the average gain and loss) can pass it only through `PREV`, so the state must be a part of its result: RSI returns `{ value, _g, _l }`. MontBlanc hides the keys that start with `_`, which is a convention of one host. The state should be kept apart from the result.

### Proposal

Every Iteration Context and Time Context has a **memory**: a map from **Text** keys to values, empty at the start. It works like the `localStorage` of a browser, with one difference: a write is visible from the **next** iteration.

| Function | Type | Description |
| :------- | :--- | :---------- |
| `STORE(key <Text>, value <Any>)` | procedure | Writes `value` under `key`. Returns `SUCCESS`. |
| `RECALL(key <Text>)` | function | The value under `key`, or `null` if there is none. |
| `RECALL(key <Text>, fallback <Any>)` | function | The value under `key`, or `fallback` if there is none. |
| `CLEAR(key <Text>)` | procedure | Removes `key`. Returns `SUCCESS`. |
| `CLEAR()` | procedure | Removes every key. Returns `SUCCESS`. |

Rules:

1. **Snapshot.** `RECALL` reads the memory as it was at the start of the current iteration (or frame). `STORE` and `CLEAR` are collected during the iteration and applied after it, in the order of the formula: the last write of a key wins.
2. **Selected paths only.** The writes of a branch of `IF` that is not selected, or of an argument of `AND` / `OR` that is not needed ([C4](#c4-short-circuit-of-and-and-or)), are discarded. So `IF($cond, STORE("x", 1), NEUTRAL)` writes only when `$cond` is `true`, although `1.1` computes both branches.
3. **Errors.** If an iteration results in an **Error**, none of its writes are applied.
4. **Values.** Any value except an **Error** and a **Delegate** (`ARGUMENT_ERROR`). Values are stored as they are (no copy is needed, values are immutable).
5. **Scope.** The memory belongs to one context. A child context (e.g. an indicator loaded with `LOAD_INDICATOR`) has its own memory. In the Default Context the three functions are an `OPERATION_ERROR`.
6. `RECALL` behaves like a constant within an iteration, so it does not disable the [optimization of `IF`](../standards/core/functions/IF.md#performance). A branch whose only side effects are memory writes may be skipped, because its writes would be discarded.

Wilder's RSI without internal keys:

```php
$change = IF(I == 0, 0, SOURCE[I] - SOURCE[I - 1])
$p = PARAMETERS.period
$gain = IF(I < $p, null, IF(I == $p, AVG(...), (RECALL("gain") * ($p - 1) + MAX($change, 0)) / $p))
$loss = ...
STORE("gain", $gain)
STORE("loss", $loss)
IF(ISNULL($gain), null, 100 - 100 / (1 + $gain / $loss))
```

### Compatibility

New names. The rule 2 applies only to the new procedures, so it changes nothing for `1.1` formulas.

### Why not `_` keys

The keys that start with `_` (the former proposal P2) would make the internal state a part of the result: a formula that loads RSI would see it, and the rule that every result has the same keys would include it. With the memory, the result of an indicator is only its outputs.


## C7. Resumed iterations

**Level:** Core · **Size:** small

### Motivation

A live strategy or a chart computes the formula again when a new candle closes. Computing all the candles again is wasteful: only the last one is new.

### Proposal

A rule of the [Iteration Context](../core/context.md#2-iteration-context): the state passed between iterations is `PREV`, `HISTORY` and the memory. A host application may keep it after the last iteration and later continue the iterations on a longer collection, from the next index, with the same environment. The results must be the same as when all the iterations are computed again.

This needs nothing from a formula, but it is the reason why the state of a formula is kept only in `PREV`, `HISTORY` and the memory: a formula cannot keep a state anywhere else.

The [stored series of `LOAD_INDICATOR`](../standards/stock/functions/LOAD_INDICATOR.md#performance) can be resumed the same way when the candles of the parent context grow (the series of a child context is the result of its own iterations).


## C8. Validation warnings

**Level:** Core · **Size:** small

### Motivation

Some mistakes are valid formulas with a surprising meaning, e.g. a long condition split into lines, where a new line ends the sequence:

```php
$buy = CLOSE[I] > $ema
       && $rsi < 30          # SYNTAX_ERROR: && has no left operand
$x = $a
     - $b                    # a new sequence: -$b; $x is $a
```

### Proposal

The [validation](../standards/core/semantics/validation.md) gets a second level, **warnings**: messages that do not change the result and do not stop the execution. A host application can show them in an editor.

| Warning | Example |
| :------ | :------ |
| A sequence that is not the last one, is not an assignment or a procedure, and whose value is not used. | `$a + 1` in the middle of a formula |
| A sequence that starts with `-` or `+` after a sequence that is a complete expression (probably a continued line). | `$x = $a` / `- $b` |
| Metadata with a key of a wrong type ([C1](#c1-formula-metadata)). | `id: 5` |

A line that starts with `&&`, `||` or another binary operator stays a `SYNTAX_ERROR`, but its message says that a new line ends the sequence and that the operator must be at the end of the previous line (or the expression in parentheses).

**Compatibility:** warnings do not change any result.


## S1. `PARAMETERS` in the Strategy Context

**Standard:** Stock 1.2 · **Size:** small

### Motivation

The Indicator and Pattern Contexts provide `PARAMETERS`, but the Strategy Context does not. A strategy is configured as much as an indicator: periods, thresholds. Without the constant, the same strategy cannot run with different settings.

### Proposal

The Strategy Context gets the constant:

| Constant | Type | Value | Description |
| :------- | :--: | :---: | :---------- |
| `PARAMETERS` | `Object` | `{ }` by default | Parameters of the strategy, provided by the host application. |

A strategy is not loaded from the [formula registry](../standards/stock/README.md#2-formula-registry), so the host application provides the complete object. If the formula has [metadata](#c1-formula-metadata) with `parameters`, the host application completes the object with their `default` values.

### Implementation

- FormuLang.NET: `StrategyContext.Create(environment, candles, executor, parameters)` with an optional `IObject? parameters`.
- FormuLang-TS: the same optional argument of `StrategyContext.create`.

### Compatibility

`PARAMETERS` in a strategy is an `UNKNOWN_SYMBOL_ERROR` in `1.1`.


## S2. `TIMEFRAME` and `INSTRUMENT`

**Standard:** Stock 1.2 · **Size:** small

Two constants of the Stock Context that describe where the candles come from:

| Constant | Type | Description |
| :------- | :--: | :---------- |
| `TIMEFRAME` | `Text` or `Null` | Timeframe of `CANDLES`, named by the host application (e.g. `"15m"`, `"1h"`). The same names are used by [S3](#s3-other-timeframes). `null` if the host application does not give it. |
| `INSTRUMENT` | `Text` or `Null` | Instrument of `CANDLES`, named by the host application (e.g. `"EURUSD"`, an IG epic). `null` if the host application does not give it. |

`INSTRUMENT` instead of `SYMBOL` (a symbol is a part of the language, as in `UNKNOWN_SYMBOL_ERROR`) or `EPIC` (a name of one broker). In a child context both are the same as in the calling context, except `TIMEFRAME` of a context created for another timeframe ([S3](#s3-other-timeframes)).


## S3. Other timeframes

**Standard:** Stock 1.2 · **Size:** large

### Motivation

Many strategies combine timeframes: entries on 15-minute candles, filtered by the trend of 1-hour candles. The Stock Context provides the candles of one chart only.

### Design: one main chart

The candles of the context (`CANDLES`, `CLOSE`, ...) stay: they are the **main chart**. The formula is executed once for every candle of the main chart, so it has one `I` and one `N`. Candles of other timeframes are **additional data** of the context. A map of all the timeframes in place of `CANDLES` (e.g. `SOURCES["1h"]`) is not proposed: the iterations need one clock, a strategy is executed when a candle of one timeframe closes anyway, and the name `SOURCE` already has another meaning in the Indicator Context.

### Data

- The host application may provide the candles of other timeframes to a Stock Context. A timeframe is a **Text** chosen by the host application, as `TIMEFRAME` ([S2](#s2-timeframe-and-instrument)).
- The libraries ask the host application for a timeframe the first time a formula uses it (a callback given when the context is created), so the host does not have to load every timeframe in advance.
- A timeframe that the host application does not provide is a `NOT_SUPPORTED_ERROR`.
- A candle of another timeframe with the time `t` and the length `L` is **closed** at the candle `k` of the main chart if `t + L` is not later than the end of `CANDLES[k]` (its time plus the length of the main timeframe). The host application gives the lengths.

### Aligned series

By default, every series of another timeframe is **aligned** with the main chart: it has `N` elements, and the element `k` is the value of the **last candle of that timeframe closed at the candle `k`**, or `null` if there is none yet.

Main chart `15m`, other timeframe `1h`:

| `I` | `CANDLES[I]` (15m) closes at | `LOAD_CANDLES("1h")[I]` |
| :-: | :--------------------------: | :---------------------- |
| 0 | 10:15 | `null` |
| 1 | 10:30 | `null` |
| 2 | 10:45 | `null` |
| 3 | 11:00 | the candle 10:00–11:00 |
| 4 | 11:15 | the candle 10:00–11:00 |
| ... | ... | ... |
| 7 | 12:00 | the candle 11:00–12:00 |

So:

- a formula never sees a candle that was not closed at the time of the current candle, also in a backtest;
- `[I]`, `[I - 1]`, `READY`, `CROSSOVER` and the other helpers work in the same way for every timeframe;
- an aligned series can be the `source` of `LOAD_INDICATOR`, which requires `N` elements.

### Functions

1. `LOAD_CANDLES(timeframe <Text>)`: an **Array** of `N` elements (`Stock.Candle` or `null`), aligned.
2. `LOAD_CANDLES(timeframe <Text>, options <Object>)`: with `options.align` = `false`, the **native** series: only the candles of that timeframe closed at the **current** candle, from the oldest. It has its own length and its own indices, e.g. for "the previous 1h candle" or a pattern on 1h candles.
3. `LOAD_INDICATOR(id <Text>, parameters <Object>, options <Object>)`: a new overload (the third argument is an Object instead of an Array):

   | Option | Type | Default | Description |
   | :----- | :--: | :-----: | :---------- |
   | `source` | `Array` | `CLOSE` | As the third argument of `1.1`. With `timeframe`, a series of that timeframe (native). |
   | `timeframe` | `Text` | `TIMEFRAME` | Computes the indicator in a child context created over the candles of that timeframe, and aligns the result. |
   | `output` | `Text` | - | For an indicator that returns Objects: the series of one key (e.g. `"hist"`), with `null` where the result is `null`. |
   | `align` | `Boolean` | `true` | `false` returns the native series of the timeframe. |

4. `LOAD_PATTERN(id, parameters, options)`: the same options except `output` and `source`.

```php
$trend = LOAD_INDICATOR("EMA", { period: 200 }, { timeframe: "1h" })
$hist = LOAD_INDICATOR("MACD", { }, { output: "histogram" })
IF(READY($trend, 1) && CLOSE[I] > $trend[I] && CROSSOVER($hist, 0), BUY, NEUTRAL)
```

### `output`

MACD returns an Object `{ macd, signal, hist }` for every candle (and `null` while warming up). In `1.1`, a formula takes one series out with `MAP($m, (v) => IF(ISNULL(v), null, v.macd))`. `output` does it in one place and gives a series of numbers, which is what the helpers of [S5](#s5-trading-helpers) take. The key of a [stored series](../standards/stock/functions/LOAD_INDICATOR.md#performance) does not include `output`, so loading two outputs of the same indicator computes it once. An `output` that is not a key of the results is an `INVALID_KEY_ERROR`.

### Compatibility

New functions and new overloads (an Object in place of an Array).

### Open questions

- Whether a candle of another timeframe that is still open may ever be visible (some platforms allow it "with repainting"). The proposal says no.
- Whether a timeframe shorter than the main one is allowed (e.g. 1m candles in a 1h strategy). The aligned rule works for it (the last closed 1m candle), but the native series is more useful there.


## S4. Object result of a strategy

**Standard:** Stock 1.2 · **Size:** small

### Motivation

A strategy returns a Number from `SELL` to `BUY`. Applications need more than the direction: an explanation for the user ("why is there no signal?"), and often their own data (a stop loss). MontBlanc adds the functions `CHECK(name, condition, value, threshold)` and `NOTE(text)`, which record conditions as a side effect.

### Proposal

The result of a strategy is a **Number**, or an **Object** with these keys:

| Key | Type | Required | Description |
| :-- | :--: | :------: | :---------- |
| `signal` | `Number` | yes | The signal, like the Number result: from `SELL` to `BUY`, clamped by the host application. |
| `reason` | `Text` | no | An explanation of the signal for the user. |
| `checks` | `Object` | no | Named conditions that led to the signal: every value is a **Boolean**, e.g. `{ aboveEma: CLOSE[I] > $ema[I] }`. The host application can show them. |
| any other | any | no | Passed to the host application unchanged (e.g. `stop`). The standard does not define them. |

The result and `checks` are plain **Object** values (no extended type). An Object without `signal`, with a `signal` that is not a Number, or with `checks` that is not an Object of Booleans is an `OPERATION_ERROR` of the iteration.

Keys of an Object are identifiers, so the names of `checks` are identifiers too. Their labels for the user come from the metadata: `stock: { checks: { aboveEma: "Price above the EMA" } }` ([S6](#s6-stock-metadata-and-the-registry)).

A new function:

| Function | Description | Return type |
| :------- | :---------- | :---------: |
| `SCORE(conditions)`, `SCORE(conditions, weights)` | The share of `true` values of an Object of Booleans (e.g. `checks`) or of an `Array<Boolean>`, from `0` to `1`: 5 of 7 → `0.714...`. An empty Object or Array is `0`. | `Number` |

`SCORE($buy) == 1` means "all the conditions are met"; `SCORE($buy) - SCORE($sell)` is a signal with a strength, and the host application decides from which strength it trades.

`SCORE(conditions, weights)` gives some conditions more weight: `SCORE($buy, { trend: 2 })` counts `trend` twice, and every condition without a weight counts once. A weight of a key that is not a condition is an `INVALID_KEY_ERROR`, so a misspelt name is not ignored. The weights can come from `PARAMETERS`, so every instance of a strategy can tune them.

`checks` is a pure alternative to `CHECK`: the conditions are a part of the result instead of a side effect, so the formula works in every implementation and keeps the [optimization of `IF`](../standards/core/functions/IF.md#performance).

### Compatibility

An Object result is an `OPERATION_ERROR` of the iteration in `1.1`.


## S5. Trading helpers

**Standard:** Stock 1.2 · **Size:** medium

Functions for the most common conditions of strategies. Like [`LAG`](../standards/stock/functions/LAG.md) and [`WINDOW`](../standards/stock/functions/WINDOW.md), they work at the current candle (`I`) of a series of `N` elements, and they never give an **Error** because of missing data: a `null` in the values they need, or not enough candles yet, gives `false` (for a Boolean result) or `null`.

A `series` is an **Array** of `N` elements (**Number** or `null`). Where it says `a` or `b`, a **Number** is also allowed (a constant line, e.g. `CROSSOVER($hist, 0)`).

| Function | Result | Description |
| :------- | :----: | :---------- |
| `READY(series, n)` | `Boolean` | The last `n` values (from `I - n + 1` to `I`) exist and are not `null`. Replaces the checks of `null` at the start of a formula. |
| `CROSSOVER(a, b)` | `Boolean` | `a` crosses above `b` at the current candle: `a[I - 1] <= b[I - 1]` and `a[I] > b[I]`. |
| `CROSSUNDER(a, b)` | `Boolean` | `a` crosses below `b`: `a[I - 1] >= b[I - 1]` and `a[I] < b[I]`. |
| `HIGHEST(series, length)` | `Number` | The highest of the last `length` values, up to the current one. `null` values are skipped; `null` if all are `null` or there are fewer than `length` candles. |
| `HIGHEST(series, length, offset)` | `Number` | The same, ending `offset` candles back (`0` = the current one). |
| `LOWEST(series, length[, offset])` | `Number` | The lowest, as `HIGHEST`. |
| `RISING(series, length)` | `Boolean` | Every one of the last `length` values is greater than the one before it. |
| `FALLING(series, length)` | `Boolean` | Every one of the last `length` values is lower than the one before it. |
| `BARS_SINCE(condition)` | `Number` | Number of candles since `condition` (an **Array** of `N` Booleans or `null`) was last `true`: `0` if it is `true` now. `null` if it was never `true`. |
| `VALUE_WHEN(condition, series)` | `Any` | The value of `series` at the last candle where `condition` was `true`, or `null`. |
| `VALUE_WHEN(condition, series, occurrence)` | `Any` | The same for an earlier occurrence (`0` = the last one, `1` = the one before it). |

Wrong arguments (a series that does not have `N` elements, a `length` that is not a whole number greater than `0`) are an `OPERATION_ERROR`, as for `WINDOW`.


## S6. Stock metadata and the registry

**Standard:** Stock 1.2 · **Size:** small

The **Stock** key of the [metadata](#c1-formula-metadata) is `stock`:

| Key | Type | Description |
| :-- | :--: | :---------- |
| `stock.category` | `Text` | A free group for the user, e.g. `"Trend"`, `"Momentum"`. |
| `stock.outputs` | `Object` | For an indicator: key of the result (or `value` for a Number result) → `{ name, description }`. The outputs are what a chart draws. |
| `stock.checks` | `Object` | For a strategy: key of `checks` → label for the user. |

A [registry definition](../standards/stock/README.md#2-formula-registry) (identifier, formula, parameters) **may** be read from the metadata of its formula: `id` is the identifier, `context` (`"Stock.Indicator"` or `"Stock.Pattern"`) is the part of the registry, and the `default` values of `parameters` are the default parameters. The part of the registry therefore follows from the context type, without a separate category.

The context type names for `context` are `"Stock"`, `"Stock.Indicator"`, `"Stock.Pattern"` and `"Stock.Strategy"`.


## Example: MACD + EMA200

The strategy as it is written for MontBlanc today (with `CHECK`, `MAP` over the MACD objects and a manual check of `null` values), rewritten with the proposals. It works in every implementation of Stock 1.2:

```php
<@ {
  id: "macd-ema200",
  name: "MACD + EMA200",
  description: "MACD crossing in the direction of the 200 EMA trend, with the stop loss behind the last swing.",
  context: "Stock.Strategy",
  parameters: {
    emaPeriod: { type: "Number", default: 200, min: 1, description: "Period of the trend EMA" },
    swingBars: { type: "Number", default: 10, min: 1, description: "Stop loss behind the low / high of N candles" },
    bufferAtr: { type: "Number", default: 0.5, min: 0, description: "Stop loss buffer in ATRs" }
  },
  stock: {
    checks: {
      aboveEma: "Price above the EMA", macdCrossUp: "MACD crosses the signal upwards", macdBelowZero: "MACD below 0",
      belowEma: "Price below the EMA", macdCrossDown: "MACD crosses the signal downwards", macdAboveZero: "MACD above 0"
    }
  }
} @>
REQUIRE "stock-1.2+"

$ema = LOAD_INDICATOR("ema", { period: PARAMETERS.emaPeriod })
$macd = LOAD_INDICATOR("macd", { }, { output: "macd" })
$signal = LOAD_INDICATOR("macd", { }, { output: "signal" })
$atr = LOAD_INDICATOR("atr", { period: 14 })[I]

$ready = READY($ema, 1) && READY($macd, 2) && READY($signal, 2) && ISNUM($atr)

$buy = { aboveEma: $ready && CLOSE[I] > $ema[I], macdCrossUp: CROSSOVER($macd, $signal), macdBelowZero: $ready && $macd[I] < 0 }
$sell = { belowEma: $ready && CLOSE[I] < $ema[I], macdCrossDown: CROSSUNDER($macd, $signal), macdAboveZero: $ready && $macd[I] > 0 }

IF(SCORE($buy) == 1,
   { signal: BUY, checks: $buy, reason: "Price above the EMA, MACD up below 0.",
     stop: LOWEST(LOW, PARAMETERS.swingBars) - PARAMETERS.bufferAtr * $atr },
   IF(SCORE($sell) == 1,
      { signal: SELL, checks: $sell, reason: "Price below the EMA, MACD down above 0.",
        stop: HIGHEST(HIGH, PARAMETERS.swingBars) + PARAMETERS.bufferAtr * $atr },
      { signal: NEUTRAL, checks: MERGE($buy, $sell) }))
```

- The metadata replaces the comment with the description and the parameters, and gives the labels of the checks.
- `output` replaces the `MAP` over the MACD objects.
- `READY` replaces the `ISNULL` checks of `$skip`; with the short circuit of `&&` ([C4](#c4-short-circuit-of-and-and-or)), `$ready && CLOSE[I] > $ema[I]` is `false` instead of an **Error** while `$ema[I]` is `null`.
- `CROSSOVER` / `CROSSUNDER` replace the comparisons of `[I - 1]` and `[I]`.
- `checks` replaces `CHECK`; the result with `NEUTRAL` still has `checks`, so the host application can show why there is no signal.
- `LOWEST` / `HIGHEST` replace `MIN(RANGE(LOW, $from, I))` and the computation of `$from`.
- `stop` is a key of the host application, passed unchanged.


## Kept for 2.0

Changes that break the 1.x promise. They are collected here and are not specified in 1.2.

| Change | Why it breaks 1.x |
| :----- | :---------------- |
| Lazy `IF`, `AND`, `OR`, `&&`, `\|\|`: the branch or argument that is not needed is never computed, its assignments included. | In `1.1` the assignments of both branches are executed. |
| `MAX([])`, `MIN([])` and, for consistency, `AVG([])` and `MEDIAN([])` give `null` instead of an `OPERATION_ERROR`, like `FIRST` and `LAST`. | An `OPERATION_ERROR` becomes a value, which `IFERR` and `ISERR` can tell apart. |
| `requires` of the metadata replaces `REQUIRE`. | `REQUIRE` would be removed. |
| `HISTORY` in the Time Context, with a limit given by the host application. | - (new; needs a design of the limit) |


## What stays in the host application

| Extension | Reason |
| :-------- | :----- |
| `CHECK`, `NOTE` | Their purpose is a side effect (diagnostics recorded by the host), against the [pure functions](comparison.md) of the standard; they also disable the [optimization of `IF`](../standards/core/functions/IF.md#performance). [S4](#s4-object-result-of-a-strategy) (`checks`, `reason`) is the pure alternative. |
| `stop`, `target`, `rr`, `entry` in the result of a strategy, the threshold of the signal strength, the modes of stop loss, take profit and entry | The order model of one broker and one trading engine. [S4](#s4-object-result-of-a-strategy) passes such keys to the host without defining them. |
| `EXCHANGE_TIME`, trading hours | The trading hours are settings of a strategy instance in the host application. Time zones in the time functions stay a possible later addition ([Future plans](future_plans.md#2-time-core)). |
| The window of a formula (how many candles it receives) | A decision of the host about cost and data; the standard leaves the context data to the host application. |
| The time limit of an evaluation | It depends on the hardware and on the use (live trading, backtest, preview). |
| A library of standard indicators | The registry is provided by the host application; the examples of the standard are examples, not a library. |
| Native implementations of registry definitions | An implementation may compute a registry definition by other means (e.g. compiled code) when the result is the same as executing the formula (the as-if rule of [C2](#c2-cold-and-hot-execution)). How close "the same" must be for numbers (e.g. `1e-7` relative) is an open question. |


## Mapping of the MontBlanc requests

| Request | Proposal |
| :------ | :------- |
| F1 Result from -1 to 1 with a reason | [S4](#s4-object-result-of-a-strategy) (`signal`, `reason`, `SCORE`) |
| F2 Indicators and candles of other timeframes | [S3](#s3-other-timeframes) |
| F3 Memory | [C6](#c6-memory-store-recall-clear) |
| F4 `READY(series, n)` | [S5](#s5-trading-helpers) |
| F5 Checks and their explanation | [S4](#s4-object-result-of-a-strategy) (`checks`), [S6](#s6-stock-metadata-and-the-registry) (labels) |
| F6 Trading helpers | [S5](#s5-trading-helpers) |
| F7 Lazy `IF`, `&&`, `\|\|` | [C4](#c4-short-circuit-of-and-and-or) (the compatible part), [2.0](#kept-for-20) |
| F8 Validation warnings | [C8](#c8-validation-warnings) |
| F9 `AND` / `OR` with many arguments, `MAX([])`, `PARAMETERS` in a strategy | [C3](#c3-and-and-or-with-many-arguments), [2.0](#kept-for-20), [S1](#s1-parameters-in-the-strategy-context) |
| F10 A lambda in a variable | Already in Core 1.1: [delegate calls](../syntax/functions.md#calling-delegates) (`$cross = (a, b) => ...`, `$cross(1, 2)`). |
| Only the last candle on the server | [C2](#c2-cold-and-hot-execution), [C7](#c7-resumed-iterations) |
| `_` keys of RSI and DMI | [C6](#c6-memory-store-recall-clear) |
| `IND`, `IND_TF`, `CANDLES_TF`, `CHECK`, `NOTE` | [S3](#s3-other-timeframes), [S4](#s4-object-result-of-a-strategy) |


## Reference

- [Future plans](future_plans.md)
- [Core changelog](../standards/core/CHANGELOG.md)
- [Stock changelog](../standards/stock/CHANGELOG.md)
