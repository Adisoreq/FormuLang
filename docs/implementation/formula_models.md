# Formula models

**Formula models** are structures that implementations of the [**Stock**](../standards/stock/README.md) standard give to host applications, to work with indicators, patterns and strategies without repeating the same code in every host: a **definition** read from the [metadata](../core/metadata.md) of a formula, a **parameter specification** with one normalization algorithm, an **instance** (a definition with its parameter values), and the **runs** of an instance over a chart.

This document is a part of the implementation structures, not of the language: a formula gives the same result with or without them, and they do not change the version of a standard. They are defined here so that every implementation (e.g. [FormuLang.NET](https://github.com/Adisoreq/formulang-dotnet) and [`formulang-ts`](https://github.com/Adisoreq/formulang-ts)) gives the host the same definitions, the same parameter values and the same problems. Their conformance tests are in [tests/stock/models.json](../../tests/stock/models.json).

Requires `core-1.2+` and `stock-1.2+`.

What a host application keeps for itself is listed in [What the models do not contain](#what-the-models-do-not-contain).


## Parameter specification

A **parameter specification** describes one parameter of a formula. It is read from a [parameter description](../standards/core/README.md#metadata) in the `parameters` key of the metadata:

| Property | From the parameter description | Description |
| :------- | :----------------------------- | :---------- |
| Key | the key in `parameters` | Name of the parameter, the key of `PARAMETERS`. |
| Type | `type` | Base or extended type of the value, e.g. `"Number"`; none if `type` is not given. |
| Default | `default` | Default value; none if `default` is not given. |
| Name | `name` | Name for the user; the key if `name` is not given. |
| Description | `description` | Description for the user; none if not given. |
| Min, Max | `min`, `max` | Lowest and highest allowed value of a **Number**; none if not given. |
| Options | `options` | Allowed values; none if not given. |

The specifications keep the order of the keys of `parameters`. A parameter description that is not an **Object**, or a known key of a wrong type (the [`METADATA_TYPE`](../standards/core/semantics/warnings.md) warnings), makes the definition invalid (see [Definition](#definition)).

### Parameter normalization

**Parameter normalization** turns the parameter values given by a host application (e.g. chosen by a user) into the complete `PARAMETERS` **Object** of a formula, or into a list of **problems**.

| | Description |
| :-- | :---------- |
| **Input** | The specifications, and the given values: an **Object** (keys and values). |
| **Output** | The normalized **Object**, or the problems (never both). |

Algorithm:

1. For every key of the given values that is not the key of a specification, in the order of the given values, add the problem `UNKNOWN`.
2. For every specification, in their order:
   1. The value is the given value of its key, or its default if the key is not given.
   2. If there is no value (the key is not given and there is no default), add the problem `MISSING` and continue with the next specification.
   3. If the specification has a type and the base type of the value is not the base type of the type (or, for an extended type, the value is not of that extended type or a type derived from it), add the problem `TYPE` and continue with the next specification. `null` is a value of the type **Null**: it is allowed only for a parameter without a type, or with the type `"Null"`.
   4. If the value is a **Number**: if it is lower than Min, add the problem `MIN`; if it is greater than Max, add the problem `MAX`.
   5. If the specification has options and the value is not equal ([`EQU`](../standards/core/functions/EQU.md)) to any of them, add the problem `OPTION`.
3. If there are problems, return them. Otherwise, return an **Object** with the key and the value of every specification, in the order of the specifications.

A **problem** has a code, the key of the parameter, and a message for the user:

| Code | Problem |
| :--- | :------ |
| `UNKNOWN` | A given key is not a parameter of the formula. |
| `MISSING` | A parameter without a default is not given. |
| `TYPE` | The value is not of the type of the parameter. |
| `MIN` | The value is lower than the lowest allowed value. |
| `MAX` | The value is greater than the highest allowed value. |
| `OPTION` | The value is not one of the allowed values. |

The messages are defined by the implementation.

How an implementation accepts the given values of its own language (e.g. JavaScript values, `JsonElement`s of .NET) is not specified; they are converted to FormuLang values before the algorithm. A conversion that is not possible (e.g. a function) is a `TYPE` problem.

### Parameter key

The **parameter key** of a normalized **Object** is its [serialization](../standards/core/semantics/serialization.md) with the initial values of the serialization variables, e.g. `{ period: 14, source: "close" }`. Two normalized Objects with the same values in the same order have the same key, so a host can use it, with the identifier, as the key of a cache or of a stored series.


## Definition

A **definition** is a formula with the information read from its metadata. It is read with the [metadata reading](../core/metadata.md#metadata-reading):

| Property | From the metadata | Description |
| :------- | :---------------- | :---------- |
| Kind | `context` | `Indicator` for `"Stock.Indicator"`, `Pattern` for `"Stock.Pattern"`, `Strategy` for `"Stock.Strategy"`. |
| Identifier | `id` | Identifier of the formula. |
| Name | `name` | Name for the user; the identifier if `name` is not given. |
| Description | `description` | Description for the user; none if not given. |
| Parameters | `parameters` | The [parameter specifications](#parameter-specification); none if `parameters` is not given. |
| Category | `stock.category` | A free group for the user; none if not given. |
| Outputs | `stock.outputs` | Indicator only: the outputs, in the order of the keys, each with a key, a name (the key if not given) and a description. None if not given (the outputs are then the keys of the results). |
| Checks | `stock.checks` | Strategy only: the keys of the `checks` of the [signal object](../standards/stock/README.md#strategy-context), each with its label. None if not given. |
| Formula | - | The formula text, with its metadata block. |

A formula is **not a valid definition** for one of these reasons, checked in this order:

| Reason | Problem |
| :----- | :------ |
| `ERROR` | The validation or the metadata reading fails; the host gets the **Error** (e.g. a `SYNTAX_ERROR`). |
| `METADATA_TYPE` | The metadata has a `METADATA_TYPE` warning: a value of a wrong type in a known key, of the Core or of the Stock standard. |
| `ID` | `id` is missing, or is not a valid identifier (letters, digits, `_` and `-`, starting with a letter or `_`). |
| `CONTEXT` | `context` is missing, or is not one of the three context types above. |

The host application gets the reason and a message. A definition does not depend on an environment: it is read from the formula text only. An indicator or pattern definition can be added to the [formula registry](../standards/stock/README.md#2-formula-registry) with its identifier, formula, and the defaults of its parameters (`null` for a parameter without a default).


## Instance

An **instance** is a definition with its parameter values:

| Property | Description |
| :------- | :---------- |
| Definition | The definition. |
| Parameters | The normalized **Object** of the parameter values: the result of the [parameter normalization](#parameter-normalization) of the values given by the host application. |
| Key | The identifier of the definition, `|`, and the [parameter key](#parameter-key), e.g. `RSI|{ period: 14 }`. |

An instance can only be created with values that the normalization accepts; otherwise the host gets the problems. The serialized form of an instance is `{ "id": <identifier>, "parameters": <normalized Object> }`; the parameters are normalized again when an instance is read back, because the definition may have changed.


## Runs

A **run** executes an instance over a **chart**: the candles of a [Stock Context](../standards/stock/README.md#stock-context), with its `TIMEFRAME`, `INSTRUMENT` and [other timeframes](../standards/stock/README.md#other-timeframes). The formula is executed in the context type of the kind of its definition, with the parameters of the instance as `PARAMETERS`, once for every candle.

| Kind | Result |
| :--- | :----- |
| Indicator | The **indicator series**: for every output, an array with one value (**Number** or `null`) for every candle. A **Number** result is the output `value`; an **Object** result has an output for every key. Without results other than `null`, the outputs are the outputs of the definition (or `value`), with `null` for every candle. The outputs are in the order of the outputs of the definition, then the other keys in the order of the results. |
| Pattern | The **pattern series**: a **Boolean** for every candle (`true` if the pattern is found at the candle). |
| Strategy | The **signals**: a signal (below) for every candle whose signal (the **Number** result, or the `signal` of the signal object) is not `NEUTRAL` after the clamping, in the order of the candles. The results of all the candles are given too, e.g. to show the `checks` of a candle without a signal. |

The expected results of the context types apply (e.g. an indicator that returns a **Text** is an `OPERATION_ERROR`); an **Error** of an iteration is the result of the run.

A **signal** has:

| Property | Description |
| :------- | :---------- |
| Index | Index of the candle, from `0`. |
| Time | `time` of the candle, or `null`. |
| Signal | The **Number** result, or the `signal` of the signal object, clamped to the range from `SELL` to `BUY` (`-1` to `1`). |
| Reason | The `reason` of the signal object; none for a **Number** result. |
| Checks | The `checks` of the signal object; none for a **Number** result. |
| Extra | The other keys of the signal object (e.g. `stop`, `target`), unchanged. |

### Live runs

A **live run** keeps the state of a run (`PREV`, `HISTORY` and the [memory](../core/context.md#memory)) and continues it when new candles close, with the [resumed iterations](../core/context.md#resumed-iterations): it returns only the results of the new candles, and they are the same as the results of a new run over all the candles. The host application may save the state of a live run and restore it later.


## What the models do not contain

These stay in the host application ([Proposals for the 1.2 standards](../misc/proposals.md#what-stays-in-the-host-application)):

- display settings: colors, panes, line styles, overlays (a host may keep them under the `x` key of the metadata);
- the order model: stops, targets, entries and exits of the signals, trading hours, markets;
- storage, revisions and the status of the formulas;
- a library of standard indicators, and native implementations of registry definitions.


## Reference

- [Metadata](../core/metadata.md)
- [Core metadata keys](../standards/core/README.md#metadata)
- [Stock standard](../standards/stock/README.md)
- [Conformance tests](../../tests/stock/models.json)
