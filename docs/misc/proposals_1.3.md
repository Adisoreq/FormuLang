# Proposals for the 1.3 standards

Changes of **Core 1.3** and **Stock 1.3**, and the proposals that were not taken. Like 1.2 ([Proposals for the 1.2 standards](proposals.md)), they come from the trading platform MontBlanc: its built-in strategies needed many checks of the warm-up of the indicators (`READY`, `IFNULL`) only to avoid an **Error** while a value is `null`.

**Status (2026-11-28):** released as `core-1.3` and `stock-1.3`. All the changes below are in the standard documents ([Core changelog](../standards/core/CHANGELOG.md#13), [Stock changelog](../standards/stock/CHANGELOG.md#13)) and covered by conformance tests ([core13.json](../../tests/core/functions/core13.json), [stock13.json](../../tests/stock/stock13.json)).

Every 1.3 change keeps the rule of 1.2: a formula whose result is a value in `1.2` gives the same value in `1.3`; only formulas whose result was an **Error** can give a value now. A formula that catches that **Error** with `IFERR` or `ISERR` sees the value instead (e.g. `IFERR(null + 1, 0)` is `null`, `ISERR(null > 1)` is `false`).


## Core 1.3

| # | Change | Before (`core-1.2`) | Since `core-1.3` |
| :-: | :----- | :------------------ | :--------------- |
| C1 | Comparisons `<` `<=` `>` `>=` with `null` on either side | `ARGUMENT_ERROR` | `false` |
| C2 | Arithmetic `+` `-` `*` `/`, unary `-`, `ABS` with `null` | `ARGUMENT_ERROR` | `null` |
| C3 | `MIN`, `MAX`, `SUM`, `AVG` of an array with a `null` element | `ARGUMENT_ERROR` | `null` (not skipped) |
| C4 | `MIN([])`, `MAX([])` | `OPERATION_ERROR` | `null`, like `FIRST` and `LAST` |
| C5 | A key of `null`: `null.close`, `$x.close` with `$x = null` | `ARGUMENT_ERROR` | `null` |
| C6 | `GET(array, index, fallback)`, `GET(object, key, fallback)` | - | the value, or `fallback` |
| C7 | `APPEND`, `INSERT`, `PUT`, `REMOVE`, `CONCAT` of arrays | - | a new array |
| C8 | `VALUES`, `ENTRIES`, `FROM_ENTRIES`, `PUT` and `REMOVE` of objects, `MERGE` of many objects | - | a new array or object |

The rules of `null` are in [Missing values](../standards/core/README.md#missing-values). With them, a condition like `CLOSE[I] > $ema[I]` is `false` while `$ema[I]` is `null`, so a strategy does not need `READY($ema, 1) &&`.

`==` and `!=` do not change. With `null`, a comparison and its negation can both be `false`: `!(a > b)` is not `a <= b`. The standard documents this and the examples write the opposite conditions directly.

The new functions never change their arguments: like `MAP` or `SORT`, they return a new array or object. The element replacement is called `PUT`, because `SET` is the procedure of the assignment.

`MIN([])` and `MAX([])` were kept for `2.0` in the 1.2 proposals, because the **Error** becomes a value that `IFERR` and `ISERR` can tell apart. 1.3 applies the same rule to them as to the other changes from an **Error** to a value. `AVG([])` and `MEDIAN([])` stay for `2.0`.


## Stock 1.3

| # | Change | Since `stock-1.3` |
| :-: | :----- | :---------------- |
| S1 | `SCORE` with a `null` condition | a condition that is not met, in the denominator (`SCORE([true, null])` is `0.5`) |
| S2 | [`SIGNAL_SCORE(buy, sell, weights)`](../standards/stock/functions/SIGNAL_SCORE.md) | `SCORE(buy) - SCORE(sell)` from `-1` to `1`, with one Object of weights for both sides |
| S3 | [Formula results](../standards/stock/README.md#formula-results) | one table of the results of indicators, patterns and strategies |

`SIGNAL_SCORE` gives the signal of a strategy in one call: its author writes the buy and the sell conditions and does not combine two scores. It is a function, not a new kind of result, so the results of a strategy and the host applications do not change. The weights are one Object for both sides, because the keys of the two sides are usually different (`aboveEma`, `belowEma`); weights of Arrays would need two more arguments, and `SCORE(buy, wb) - SCORE(sell, ws)` already gives them.

The results stay plain values, not extended types: an extended type has a constructor and is a different type for `TYPE` and `ISOBJ`, while a result is a literal built and combined like any other Object.


## Not taken

| Proposal | Why not |
| :------- | :------ |
| `VOTE(buy, sell)` and `VOTES(votes)` | `VOTE(b, s)` is `b - s` and the mean of differences is the difference of means, so `VOTES([VOTE(b1, s1), ...])` is `SCORE([b1, ...]) - SCORE([s1, ...])`. They lose the names of the conditions and the weights, and need the conditions in pairs. `SIGNAL_SCORE` gives the same signal with the names and the weights. |
| An index outside of an array gives `null` (`x[5]`, `x[-1]`) | `INVALID_INDEX_ERROR` would be lost for arrays and a wrong index would be silent: with the comparisons, `null` becomes `false` and a strategy never trades without an **Error**. `GET(array, index, fallback)` asks for the fallback explicitly. |
| `null` as a condition (`null && x`, `IF(null, a, b)` as `false`) | `NOT(null)` stays an **Error**, because it is not known if the result is `true` or `false`; `&&` and `IF` keep the same rule. A comparison never gives `null`, so the conditions are always **Boolean**. |
| An overload `SCORE(buy, sell)` | `SCORE(Object, Object)` is already `SCORE(conditions, weights)`, and `SCORE` would have two meanings (a share from `0` to `1`, a signal from `-1` to `1`). The signal has its own name, `SIGNAL_SCORE`. |
| A strategy result `{ buy, sell }` (a conditions object) that the implementation turns into a signal object | A second kind of result makes the language and every host more complex for what one function gives. |
| A cache of the series between evaluations (`SeriesCache` in the context options) | A host that creates a new context on a moving window of candles cannot get the same results from a cache (an EMA depends on the beginning of the window). The host keeps the context between evaluations instead, with the [resumed iterations](../core/context.md#resumed-iterations). |
| Mutating array functions (`PUSH`, `POP`, `ERASE` that change the array) | A formula is pure: the same arguments give the same result, which the optimization of `IF` and the resumed iterations need. `APPEND`, `REMOVE` and `LAST` cover them. |


## Reference

- [Proposals for the 1.2 standards](proposals.md)
- [Core changelog](../standards/core/CHANGELOG.md)
- [Stock changelog](../standards/stock/CHANGELOG.md)
