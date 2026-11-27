# Execution

Execution is the entire process of turning the formula expression into calculated result.


## Execution steps

1. **[Validation](./validation.md)** - Checking the environment integrity and looking for syntax errors in formula.
2. **[Metadata reading](../core/metadata.md#metadata-reading)** – Reading the metadata block and removing it from the formula.
3. **[Clean-up](./cleanup.md)** – Removing unnecessary white spaces and comments.
4. **[Tokenization](./tokenization.md)** – Splitting the formula into elementary tokens.
5. **[Parsing](./parsing.md)** – Converting tokens into primitives and building an abstract syntax tree.
6. **[Evaluation](./evaluation.md)** – Calculating function results based on their parameters.
7. **[Finalization](./finalization.md)** – Processing and returning the final result.

| # | Process | Description | Input | Output |
| - | :-----: | :---------: | :---: | :----: |
| 1 | Validation | System loads formula and performs syntax and integrity checking | Unprocessed formula | Array of errors depending on the found problems or empty array if none found. |
| 2 | Metadata reading | Reads the [metadata block](../core/metadata.md), if there is one | Validated formula | Metadata **Object** and the formula without the block |
| 3 | Clean-up | Removes redundant white spaces and comments | Formula without the metadata block | Cleaned formula |
| 4 | Tokenization | Splits formula into tokens | Cleaned formula | Array of tokens |
| 5 | Parsing | Groups tokens into sequences and turns expressions into primitive trees | Array of tokens | Array of abstract primitive trees |
| 6 | Evaluation | Resolves every entry of the primitive map into a value | Primitive map | Computed value |
| 7 | Finalization | Wraps the computed value into a primitive | Computed value | Result primitive |

The metadata reading was added in [**Core**](../standards/core/README.md) `1.2`. A formula without a metadata block passes it unchanged.


## Full pipeline

The execution steps are surrounded by two processes handled with the host application:

**[Pre-execution](./pre-execution.md)** → **Execution** (steps 1–7) → **[Post-execution](./post-execution.md)**

- [**Pre-execution**](./pre-execution.md) - Process of gathering all necessary data to execute the formula from [**environment**](../core/environment.md) in a form of [**context**](../core/context.md). It always runs before the validation.
- [**Post-execution**](./post-execution.md) - Process of extracting and utilizing the computed result in a program and cleaning up the [**context**](../core/context.md).


## Execution modes

The execution steps form two phases:

| Phase | Steps | Depends on |
| :---- | :---- | :--------- |
| **Preparation** | 1 - 5: validation of the formula text, metadata reading, clean-up, tokenization, parsing | the formula text and the **symbols** of the environment (the functions and procedures known to the parser) |
| **Evaluation** | 6 - 7: evaluation, finalization | the prepared formula and the context |

The result of the preparation is a **prepared formula**: the expression trees of the sequences, the primitive map and the [metadata](../core/metadata.md).

A formula is executed in one of two modes:

- **Cold execution** - the full pipeline: pre-execution, preparation, evaluation and post-execution. It is used for a single execution of a formula.
- **Hot execution** - the evaluation of a prepared formula, without the preparation. It is used when the same formula is executed many times: in every iteration of an [Iteration Context](../core/context.md#2-iteration-context), in every frame of a [Time Context](../core/context.md#3-time-context), or in a new context created for the next candle of a chart.

Rules:

1. A prepared formula may be evaluated any number of times, in any number of contexts, as long as the symbols of the environment do not change. If they change (e.g. the host application adds a function), the formula is prepared again.
2. The checks of the environment of the [validation](./validation.md) are performed once for every context, before its first hot execution, and not for every iteration or frame.
3. A hot execution gives the same result, and the same side effects, as a cold execution of the same formula in the same context and environment. Only the cost differs.

The modes describe what an implementation is allowed to reuse; they are not visible to a formula. The same as-if rule allows an implementation to skip the [branch of `IF` that is not selected](../standards/core/functions/IF.md#performance) and to [store the series of `LOAD_INDICATOR`](../standards/stock/functions/LOAD_INDICATOR.md#performance).

Introduced in [**Core**](../standards/core/README.md) `1.2`. Earlier versions do not forbid the reuse; they did not describe it.


## Reference

- [Context](../core/context.md)
- [Metadata](../core/metadata.md)
- [Clean-up](./cleanup.md)
- [Environment](../core/environment.md)
- [Pre-execution](./pre-execution.md)
- [Post-execution](./post-execution.md)
- [Validation](./validation.md)
