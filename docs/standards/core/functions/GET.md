# GET

**Core** standard function that returns a value from an array or object.

## Overloads

### Overload 1: Array index

Signature: `GET(array <Array>, index <Number>)`

Returns the array element at `index`. The index must be a whole number and follows the Core `array_indexing` environment variable.

| Expression | Equivalent call |
| :---------- | :-------------- |
| `array[index]` | `GET(array, index)` |

### Overload 2: Object key

Signature: `GET(object <Object>, key <Text>)`

Returns the object value stored under the exact text `key`. Object keys always follow the [identifier naming restrictions](../../../syntax/naming.md#naming-restrictions), so a `key` that is not a valid identifier is never present in an object.

| Expression | Equivalent call |
| :---------- | :-------------- |
| `object.key` | `GET(object, "key")` |
| `object["key"]` | `GET(object, "key")` |

`object.key` is a shorthand for `object["key"]`. Only the bracket form accepts any **Text** expression as the key, e.g. a variable: `$obj[$name]`.

### Overload 3: Key of a missing object

Since `core-1.3`. Signature: `GET(object <Null>, key <Text>)`

Returns `null` (see [Missing values](../README.md#missing-values)): a key of a value that does not exist yet does not exist either, e.g. `$candle.close` while `$candle` is `null`.

| Expression | Equivalent call |
| :---------- | :-------------- |
| `null.key` | `GET(null, "key")` |
| `$x["key"]` with `$x = null` | `GET(null, "key")` |

An index of `null` (`null[0]`) still matches no overload.

### Overload 4: Array index with a fallback

Since `core-1.3`. Signature: `GET(array <Array>, index <Number>, fallback <Any>)`

Returns the element at `index` like the overload 1, or `fallback` if there is no element at `index` (also for an index lower than `array_indexing`). It is the same as `IF(HAS(array, index), array[index], fallback)`. An index that is not a whole number is still an `INVALID_INDEX_ERROR`.

The operator `array[index]` keeps the overload 1, so a wrong index is an **Error** unless the formula asks for a fallback.

### Overload 5: Object key with a fallback

Since `core-1.3`. Signature: `GET(object <Object>, key <Text>, fallback <Any>)`

Returns the value under `key` like the overload 2, or `fallback` if the object has no value stored under `key`. It is the same as `IF(HAS(object, key), object[key], fallback)`.

## Errors

- [`INVALID_INDEX_ERROR`](../errors/INVALID_INDEX_ERROR.md) - `index` is not a whole number, or there is no element at `index` and no `fallback` is given.
- [`INVALID_KEY_ERROR`](../errors/INVALID_KEY_ERROR.md) - the object has no value stored under `key` and no `fallback` is given.
- [`ARGUMENT_ERROR`](../errors/ARGUMENT_ERROR.md) - the arguments match no overload. If one of the arguments is an **Error**, that **Error** is returned instead (see [Evaluation](../../../semantics/evaluation.md#3-function-call)).

## Examples

| Expression | Result |
| :---------- | :----- |
| `GET([10, 20, 30], 1)` | `20` |
| `[10, 20, 30][2]` | `30` |
| `[10, 20, 30][5]` | `Error`: `INVALID_INDEX_ERROR` |
| `GET([10, 20, 30], 5, 0)` | `0` |
| `GET([10, 20, 30], -1, null)` | `null` |
| `GET({"name": "Ada"}, "name")` | `"Ada"` |
| `{"name": "Ada"}.name` | `"Ada"` |
| `{name: "Ada"}["name"]` | `"Ada"` |
| `{name: "Ada"}["first name"]` | `Error`: `INVALID_KEY_ERROR` |
| `GET({name: "Ada"}, "age", 0)` | `0` |
| `null.close` | `null` |
| `GET(CLOSE, I - 1, null)` | the previous close, `null` at the first candle (Stock) |

## Reference

- [Core standard](../README.md)
- [Core functions](README.md)
- [`HAS`](HAS.md)
- [Core environment](../../../core/environment.md)
