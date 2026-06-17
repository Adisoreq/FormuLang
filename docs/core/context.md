# Context

Context is the object containing all data required for the process of evaluating a single formula.

## Description

The context holds **local variables**, temporary values, and any data specific to the current formula evaluation and provides isolation between separate formula evaluations, while allowing optional persistence when required.

## Context types

### 1. Disposable
   - Created during pre-evaluation and disposed after evaluation finishes.
   - Use: single formula execution with no retained state.

### 2. Persistent
   - Copied or passed by reference across multiple evaluations (e.g., rolling-window calculations, backtesting).
   - Use: accumulate state (counters, caches) between successive evaluations.

## Lifecycle

1. Pre-evaluation
   - Initializing the context with environment-supplied data.
2. Evaluation
   - Reading/modifying context **variables** and **constants**.
   - Applying temporary **environment** parameters.
3. Post-evaluation
   - **Disposable**: freeing resources.
   - **Persistent**: returning or storing context for next evaluation.

## Examples

### Disposable context

```
$a = 3
$b = 4
$c2 = a^2 + b^2

SQRT(c2)
```

This context stores disposal data and can be disposed after evaluation.

### Persistent context

```
@REQUIRE "stock-1.x.x"

$sum := 0
$period := PARAMS[0]

$start = I - period
$sum = SUB(sum, CLOSE[start])
$sum = ADD(sum, CLOSE[I])

DIV(sum, period)
```

The `sum` and `period` variables in above example are initialized once and accessed during multiple evaluation iterations, which is possible only with persistent context.

## Reference

- [Containers](containers.md)
- [Environment](environment.md)
- [Evaluation](../semantics/evaluation.md)