# Execution

Execution is the entire process of turning the formula expression into calculated result.


## Execution steps

1. **[Validation](./validation.md)** - Checking the environment integrity and looking for syntax errors in formula.
2. **[Clean-up](./cleanup.md)** – Removing unnecessary white spaces and comments.
3. **[Tokenization](./tokenization.md)** – Splitting the formula into elementary tokens.
4. **[Parsing](./parsing.md)** – Converting tokens into primitives and building an abstract syntax tree.
5. **[Evaluation](./evaluation.md)** – Calculating function results based on their parameters.
6. **[Finalization](./finalization.md)** – Processing and returning the final result.

| # | Process | Description | Input | Output |
| - | :-----: | :---------: | :---: | :----: |
| 1 | Validation | System loads formula and performs syntax and integrity checking | Unprocessed formula | Array of errors depending on the found problems or empty array if none found. |
| 2 | Clean-up | Removes redundant white spaces and comments | Unprocessed formula | Cleaned formula |
| 3 | Tokenization | Splits formula into tokens | Cleaned formula | Array of tokens |
| 4 | Parsing | Groups tokens into sequences and turns expressions into primitive trees | Array of tokens | Array of abstract primitive trees |
| 5 | Evaluation | Resolves every entry of the primitive map into a value | Primitive map | Computed value |
| 6 | Finalization | Wraps the computed value into a primitive | Computed value | Result primitive |


## Full pipeline

The execution steps are surrounded by two processes handled with the host application:

**[Pre-execution](./pre-execution.md)** → **Execution** (steps 1–6) → **[Post-execution](./post-execution.md)**

- [**Pre-execution**](./pre-execution.md) - Process of gathering all necessary data to execute the formula from [**environment**](../core/environment.md) in a form of [**context**](../core/context.md). It always runs before the validation.
- [**Post-execution**](./post-execution.md) - Process of extracting and utilizing the computed result in a program and cleaning up the [**context**](../core/context.md).


## Reference

- [Context](../core/context.md)
- [Clean-up](./cleanup.md)
- [Environment](../core/environment.md)
- [Execution](./execution.md)
- [Pre-execution](./pre-execution.md)
- [Post-execution](./post-execution.md)
- [Validation](./validation.md)
