# ARRAY

Array [**Core**](../README.md) standard function. Creates an array from provided arguments. Alias for `[...]`.

## Overloads

### Overload 1

Signature: `ARRAY(...elements? <Any>)`

Collection template:

| # | Name |   | Base type | Extended type | Any type | Multiple | Optional |
| - | :--: | - | :-------: | :-----------: | :------: | :------: | :------: |
| 1 | elements | | - | - | true | true | true |

Algorithm:

- Returns a new **Array** with the elements in the order of the arguments
- Without arguments, returns an empty array `[ ]`

Examples:

| elements | ARRAY(...elements) |
| :-: | :-------: |
| 1, 2, 3 | [ 1, 2, 3 ] |
| "a", "b" | [ "a", "b" ] |

## Errors

None. The arguments accept **Any type**, so **Error** values are stored as elements and are not propagated.


## Reference

- [Core standard](../README.md)
