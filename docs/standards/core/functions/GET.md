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

## Errors

- [`INVALID_INDEX_ERROR`](../errors/INVALID_INDEX_ERROR.md) - `index` is not a whole number, or there is no element at `index`.
- [`INVALID_KEY_ERROR`](../errors/INVALID_KEY_ERROR.md) - the object has no value stored under `key`.
- [`ARGUMENT_ERROR`](../errors/ARGUMENT_ERROR.md) - the arguments match no overload. If one of the arguments is an **Error**, that **Error** is returned instead (see [Evaluation](../../../semantics/evaluation.md#3-function-call)).

## Examples

| Expression | Result |
| :---------- | :----- |
| `GET([10, 20, 30], 1)` | `20` |
| `[10, 20, 30][2]` | `30` |
| `GET({"name": "Ada"}, "name")` | `"Ada"` |
| `{"name": "Ada"}.name` | `"Ada"` |
| `{name: "Ada"}["name"]` | `"Ada"` |
| `{name: "Ada"}["first name"]` | `Error`: `INVALID_KEY_ERROR` |

## Reference

- [Core standard](../README.md)
- [Core functions](README.md)
- [Core environment](../../../core/environment.md)
