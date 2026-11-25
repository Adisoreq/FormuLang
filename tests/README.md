# FormuLang conformance tests

Language-independent tests of the **FormuLang** standards. Each test is data, not code: a formula, the context and environment it runs in, and the expected result. Every implementation (e.g. [FormuLang.NET](https://github.com/Adisoreq/formulang-dotnet) or the npm package [`formulang-ts`](https://github.com/Adisoreq/formulang-ts)) can read these files with a small test runner of its own and check that it follows the specification.

An implementation **conforms** to a standard (e.g. `core-1.0`) if it passes every case whose required standards it supports.


## Structure

```
tests/
├── schema.json              JSON Schema of a test file
├── validate.ps1             checks every test file against the schema
├── core/
│   ├── syntax/              comments, Unicode text
│   ├── validation/          validation errors and messages
│   ├── functions/           Core functions (FORMAT, time functions, basics)
│   └── context/             Iteration Context and Time Context
└── stock/                   Stock standard
```


## Test file

Every file is a JSON object:

| Key | Required | Description |
| :-- | :------: | :---------- |
| `standards` | yes | Identifiers of the standards required by every case of the file, e.g. `["core-1.0"]`. |
| `description` | no | What the file tests. |
| `defaults` | no | `context`, `environment` and `registry` used by every case that does not define them. |
| `cases` | yes | The test cases. |

### Test case

| Key | Required | Description |
| :-- | :------: | :---------- |
| `id` | yes | Unique identifier, e.g. `core.functions.FORMAT.001`. |
| `description` | no | What the case checks. |
| `standards` | no | Standards required in addition to the file's `standards`. |
| `spec` | no | Relative link to the specification. |
| `context` | no | Context of the execution (default: `{ "type": "Default" }`). |
| `environment` | no | Changes to the initial environment. |
| `registry` | no | Formula registry (Stock). |
| `formula` | yes | The formula: a text, or an array of lines joined with a new line (`\n`). |
| `expected` | yes | The expected outcome (see below). |

A `context`, `environment` or `registry` given in a case **replaces** the one from `defaults` entirely; the two are not merged.

### Context

| `type` | Additional keys | Execution |
| :----- | :-------------- | :-------- |
| `Default` | - | One execution. |
| `Iteration` | `n` | `n` iterations. |
| `Time` | `frames`: `[{ "time_s", "dtime_s", "now"? }]` | One execution per frame. `TIME_MS` and `DTIME_MS` are `time_s * 1000` and `dtime_s * 1000`. `now`, if given, is the `NOW` constant of the frame. |
| `Stock`, `Indicator`, `Pattern`, `Strategy` | `candles`, `parameters` (Indicator, Pattern), `source` (Indicator, default `CLOSE`) | One iteration per candle. |

### Environment

The runner starts with the initial environment of the standards (e.g. `array_indexing` = `0`) and then applies:

- `constants`: replaces the values of environment constants, e.g. `{ "NOW": 1795431080123 }`;
- `variables`: replaces the values of environment variables, e.g. `{ "array_indexing": 1 }`;
- `omit`: removes environment elements, to test the [environment checks](../docs/standards/core/semantics/validation.md#environment-checks).

If `NOW` is not given, the runner sets it to `0`, so that the tests are deterministic. The value written in the test may be of a wrong type on purpose (to test the validation).

### Expected outcome

`expected` has exactly one key:

| Key | Meaning |
| :-- | :------ |
| `result` | The execution succeeds with this value. |
| `results` | The value of every iteration or frame, in order. An element `{ "$error": "<CODE>" }` means that this iteration results in an **Error** with the code. |
| `error` | The execution results in this **Error**: `{ "code": "...", "message": "..." }`. `message` is checked only if it is given. |
| `errors` | The [validation](../docs/semantics/validation.md) returns exactly these errors, in this order. |

For `results`, the runner executes **all** iterations or frames, even after an iteration results in an **Error**.

### Values

FormuLang values are written as JSON values:

| FormuLang | JSON |
| :-------- | :--- |
| **Null** | `null` |
| **Boolean** | `true` / `false` |
| **Number** | number |
| **Text** | string |
| **Array** | array |
| **Object** | object (the order of the keys is checked) |
| Extended type | object with the `"$type"` key, e.g. `{ "$type": "Stock.Candle", "open": 1, ... }` |

Numbers are equal if they differ by at most `1e-9` times the larger absolute value (or by `1e-12` when both are close to `0`). **Delegate** values are not compared.


## Running the tests

A runner of an implementation, for every file and every case:

1. Skips the case if the implementation does not support one of its standards.
2. Builds the environment and the context, and the registry for Stock cases.
3. Executes the formula (once, or for every iteration or frame).
4. Compares the outcome with `expected` and reports the case `id` on failure.

Check that the test files match the schema (PowerShell 7):

```bash
pwsh tests/validate.ps1
```


## Adding tests

- Every new function or rule of a standard should come with test cases. A good start is the **Examples** table of the function document.
- Identifiers have the form `<standard>.<area>.<name>.<number>`, e.g. `core.functions.DATE.003`, and are never reused.
- A case that checks a specific rule links to it with `spec`.
