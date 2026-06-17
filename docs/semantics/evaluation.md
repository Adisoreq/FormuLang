# Evaluation

Evaluation is the entire process of turning the formula expression into calculated result.

## Evaluation steps
1. **[Clean-up](./cleanup.md)** – Removing unnecessary white spaces and comments.
2. **[Tokenization](./tokenization.md)** – Splitting the formula into elementary tokens.
3. **[Parsing](./parsing.md)** – Converting tokens into primitives and building an abstract syntax tree.
4. **[Computation](./computation.md)** – Calculating function results based on their parameters.
5. **[Finalization](./finalization.md)** – Processing and returning the final result.

## Related processes
- **Pre-evaluation** - Process of gathering all necessary data to evaluate the formula from [**environment**](../core/environment.md) in a form of [**context**](../core/context.md).
- **Post-evaluation** - Process of extracting and utilizing the computed result in a program.

## Example

### 1. Pre-evaluation

#### Context:

Context for this example contains single constant:

| Name | Type | Value |
| :--- | :--- | :---- |
| VECTOR | `Array` | [ 15, 20 ] |

#### Formula:

```
# Vector length normalization formula

# Assuming that VECTOR is an array type constant provided by context.
$ dx = VECTOR[0]; dy = VECTOR[1]

$ length = ROOT(dx^2 + dy^2, 2)
$ dx = DIV(dx, length); dy = DIV(dy, length)

# Result
[dx, dy]
```

### 2. Clean-up

#### Compressed formula

```
$dx=VECTOR[0];dy=VECTOR[1]
$length=ROOT(dx^2+dy^2,2)
$dx=DIV(dx,length);dy=DIV(dy,length)
[dx,dy]
```

### 3. Tokenization

#### Expression tree:

```mermaid
graph TD
    CTX(Context section) --> EQ1["="]
    EQ1 --> dx1[dx]
    EQ1 --> IDX1["[ ]"]
    IDX1 --> V1[VECTOR]
    IDX1 --> N0[0]

    CTX --> EQ2["="]
    EQ2 --> dy1[dy]
    EQ2 --> IDX2["[ ]"]
    IDX2 --> V2[VECTOR]
    IDX2 --> N1[1]

    CTX --> EQ3["="]
    EQ3 --> len[length]
    EQ3 --> ROOT
    ROOT --> PLUS["+"]
    PLUS --> POW1["^"]
    POW1 --> dx2[dx]
    POW1 --> N2a[2]
    PLUS --> POW2["^"]
    POW2 --> dy2[dy]
    POW2 --> N2b[2]
    ROOT --> N2c[2]

    CTX --> EQ4["="]
    EQ4 --> dx3[dx]
    EQ4 --> DIV1[DIV]
    DIV1 --> dx4[dx]
    DIV1 --> len2[length]

    CTX --> EQ5["="]
    EQ5 --> dy3[dy]
    EQ5 --> DIV2[DIV]
    DIV2 --> dy4[dy]
    DIV2 --> len3[length]

    RET(Return section) --> ARR["[ ]"]
    ARR --> dx5[dx]
    ARR --> dy5[dy]
```

## Reference
- [Context](../core/context.md)
- [Environment](../core/environment.md)
- [Evaluation](./evaluation.md)
- [Clean-up](./cleanup.md)