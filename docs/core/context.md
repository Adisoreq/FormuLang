# Context

Context is the object containing all data required for the process of executing a single formula.


## Description

The context holds **local variables**, temporary values, and any data specific to the current formula execution and provides isolation between separate formula executions, while allowing optional persistence when required.


## Context kinds

### 1. Disposable context

   - Created during pre-execution and disposed after execution finishes.
   - Use: single formula execution with no retained state.

### 2. Persistent context

   - Copied or passed by reference across multiple executions (e.g., rolling-window calculations, backtesting).
   - Use: accumulate state (counters, caches) between successive executions.


## Context types

A **context type** describes what the host application provides to a formula and what it expects back. Standards define context types, and the host application chooses the context type of every execution.

Every context type specifies:

| Property | Description |
| :------- | :---------- |
| **Name** | Name of the context type, e.g. `Iteration Context`. |
| **Base type** | Context type it derives from. The derived type has every constant of its base type and follows its rules, unless it states otherwise. |
| **Context constants** | Constants that the host application provides, with their types. |
| **Expected result** | Type (or types) of the value the formula should return. A result of another type is handled by the host application, for example by reporting an error. |

A context type cannot remove or change the type of a constant of its base type. Context constants follow the same rules as [environment](environment.md) constants: they are read-only, and a context variable cannot use their name.

### 1. Default Context

Defined by the [**Core**](../standards/core/README.md) standard. Base of every other context type.

| Property | Value |
| :------- | :---- |
| Base type | - |
| Context constants | none |
| Expected result | any value |
| Kind | Disposable |

### 2. Iteration Context

Defined by the [**Core**](../standards/core/README.md) standard. The host application executes the same formula once for every element of a collection (e.g. every candle of a chart). Each run is an **iteration**.

| Property | Value |
| :------- | :---- |
| Base type | Default Context |
| Context constants | `I`, `N`, `PREV`, `HISTORY` |
| Expected result | any value |
| Kind | Persistent (only through `PREV`, `HISTORY` and the [memory](#memory)) |

| Constant | Type | Description |
| :------- | :--: | :---------- |
| `I` | `Number` | Index of the current iteration. |
| `N` | `Number` | Number of iterations (number of elements of the collection). |
| `PREV` | `Any` | Result of the previous iteration. `null` in the first iteration. |
| `HISTORY` | `Array` | Results of all the previous iterations, from the first one (since `core-1.2`). |

Rules:

- The iterations are executed in order. The first iteration has the index `@array_indexing`, the last one `@array_indexing + N - 1`. `I` is computed at the moment it is read from the current value of `@array_indexing`, so `array[I]` always points to the element of the current iteration, even if the formula overrides `@array_indexing`.
- `N` does not depend on `@array_indexing`.
- Every iteration starts with no context variables and with the environment variables of the environment. Context variables and overridden environment variables are not kept between iterations. The only state passed from one iteration to the next is `PREV`, `HISTORY` and the [memory](#memory).
- `HISTORY` has one element for every previous iteration, from the first one, so `HISTORY[k]` is the result of the iteration with the index `k` (for any `@array_indexing`, as for every array that has one element per iteration), and its last element is `PREV`. It is empty in the first iteration. If the host application continues the iterations after an iteration that resulted in an **Error**, the element of that iteration is `null`.
- If an iteration results in an **Error**, the host application decides whether the remaining iterations are executed.
- The `NOW` environment constant is set once before the first iteration and is the same in all iterations.

#### Resumed iterations

The state passed between iterations is `PREV`, `HISTORY` and the memory: a formula cannot keep a state anywhere else. A host application may therefore keep this state after the last iteration and later **resume** the iterations on a longer collection (e.g. when a new candle closes), from the next index, with the same formula and environment. The results of the resumed iterations must be the same as when all the iterations are executed again from the first one. The elements of the collection that were already iterated must not change; if they do, the host application executes all the iterations again.

A host application that does not keep the state executes all the iterations, as before `core-1.2`.

Example: `HISTORY` in a strategy that gives at most 3 `BUY` signals (`@array_indexing` = `0`):

```php
$buys = LEN(FILTER(HISTORY, (r) => r == BUY))
IF($buys < 3 && CLOSE[I] > OPEN[I], BUY, NEUTRAL)
```

### 3. Time Context

Defined by the [**Core**](../standards/core/README.md) standard. The host application executes the same formula repeatedly as time passes (e.g. once for every frame of an animation, a simulation step or a real-time measurement). Each run is a **frame**. Unlike in the Iteration Context, the number of frames does not have to be known in advance.

| Property | Value |
| :------- | :---- |
| Base type | Default Context |
| Context constants | `TIME_S`, `TIME_MS`, `DTIME_S`, `DTIME_MS`, `FRAME`, `PREV` |
| Expected result | any value |
| Kind | Persistent (only through `PREV` and the [memory](#memory)) |

| Constant | Type | Description |
| :------- | :--: | :---------- |
| `TIME_S` | `Number` | Total time from the start of the first frame to the start of the current frame, in seconds. `0` in the first frame. |
| `TIME_MS` | `Number` | `TIME_S` in milliseconds (`TIME_S * 1000`). |
| `DTIME_S` | `Number` | Delta time: time from the start of the previous frame to the start of the current frame, in seconds. `0` in the first frame. |
| `DTIME_MS` | `Number` | `DTIME_S` in milliseconds (`DTIME_S * 1000`). |
| `FRAME` | `Number` | Index of the current frame. The first frame has the index `@array_indexing`. |
| `PREV` | `Any` | Result of the previous frame. `null` in the first frame. |

Rules:

- The frames are executed in order, one at a time. The host application decides when the next frame starts (e.g. at a fixed rate, or as fast as possible) and when the frames stop.
- The time constants are not required to be whole numbers. `TIME_S` and `TIME_MS` never decrease, and `DTIME_S` and `DTIME_MS` are never negative.
- `FRAME` is computed from the current value of `@array_indexing`, in the same way as `I` in the Iteration Context.
- Every frame starts with no context variables and with the environment variables of the environment. The only state passed from one frame to the next is `PREV` and the [memory](#memory).
- The `NOW` environment constant is set again for every frame. `TIME_S` is measured by the host application, so it does not have to be equal to the difference of `NOW` values.
- If a frame results in an **Error**, the host application decides whether the next frames are executed.

Example: a point that moves with the speed of `5` units per second and stops at `100`:

```php
$speed = 5
$position = IF(ISNULL(PREV), 0, PREV)
MIN($position + $speed * DTIME_S, 100)
```


## Memory

Since `core-1.2`, every Iteration Context and Time Context (and every context type derived from them) has a **memory**: a map from **Text** keys to values, which keeps a state between iterations (or frames) without making it a part of the result. It is empty before the first iteration.

The memory is used only through the procedures [`STORE`](../standards/core/procedures/STORE.md) and [`CLEAR`](../standards/core/procedures/CLEAR.md) and the function [`RECALL`](../standards/core/functions/RECALL.md):

```php
# Count of the iterations in which the value was above 10.
$count = RECALL("count", 0) + IF(SOURCE[I] > 10, 1, 0)
STORE("count", $count)
$count
```

Rules:

1. **Snapshot.** During an iteration, the memory does not change: `RECALL` gives the values as they were at the start of the iteration. The writes of `STORE` and `CLEAR` are collected, and applied after the iteration, in the order in which they were executed; the last write of a key wins. A write is therefore visible from the next iteration.
2. **Selected paths only.** The writes executed in a branch of [`IF`](../standards/core/functions/IF.md) that is not selected, or in an argument of [`AND`](../standards/core/functions/AND.md) or [`OR`](../standards/core/functions/OR.md) that does not decide the result, are discarded. So `IF($cond, STORE("x", 1), 0)` writes only when `$cond` is `true`, although both branches are computed.
3. **Errors.** If an iteration results in an **Error**, none of its writes are applied.
4. **Scope.** The memory belongs to one context. A child context (e.g. an indicator loaded by the **Stock** function `LOAD_INDICATOR`) has its own memory, and the calling formula cannot read it.
5. The Default Context has no memory: `STORE`, `CLEAR` and `RECALL` are an `OPERATION_ERROR` there.

Because `RECALL` does not change during an iteration, it behaves like a context constant. A branch whose only side effects are writes to the memory may be skipped by the [optimization of `IF`](../standards/core/functions/IF.md#performance), because its writes would be discarded anyway.


## Lifecycle

1. Pre-execution
   - Initializing the context with environment-supplied data.
2. Execution
   - Reading/modifying context **variables** and **constants**.
   - Applying temporary **environment** parameters.
3. Post-execution
   - **Disposable**: freeing resources.
   - **Persistent**: returning or storing context for next execution.


## Reference

- [Containers](containers.md)
- [Environment](environment.md)
- [Metadata](metadata.md)
- [Execution](../semantics/execution.md)
- [Core standard](../standards/core/README.md#context-structure)
