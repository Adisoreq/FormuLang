# Argument template collection

Helper structure defining the full set of parameters accepted by a function call. A collection is an ordered list of [argument templates](./argument_template.md), where each template corresponds to one parameter position.

Arguments are matched against templates sequentially, left to right. Validation fails if:
- A required argument is missing.
- An argument's type does not satisfy its template.
- More arguments are provided than the collection can accept (unless the last template is *multiple*).

## Function overloads

A function may accept more than one argument collection. Each collection represents a separate **overload** — a distinct parameter signature. Only **named** functions have overloads; a [lambda function](../syntax/functions.md#lambda-function-expression) has no argument collection, so its arguments are bound directly to its parameters and the stored body tree is evaluated without any matching (see [lambda invocation](../semantics/evaluation.md#lambda-invocation)).

During validation, overloads are tested in order — result is calculated with first matching overload.
If no overload matches the input, the function is not executed and returns an error: the leftmost **Error** argument, if there is one (the error is propagated), or `ARGUMENT_ERROR` otherwise. See [Evaluation](../semantics/evaluation.md#3-function-call).

## Examples

### Fixed collection

**`ADD(a <Number>, b <Number>)`**

| Position | Name |   | Base type | Extended type | Any type | Multiple | Optional |
| :------: | :--: | - | :-------: | :-----------: | :------: | :------: | :------: |
| 1 | a | | `Number` | - | false | false | false |
| 2 | b | | `Number` | - | false | false | false |

### Overloads

**`ADD(a <Geometry.Vector2D>, b <Geometry.Vector2D>)`** — second overload of `ADD`

| Position | Name |   | Base type | Extended type | Any type | Multiple | Optional |
| :------: | :--: | - | :-------: | :-----------: | :------: | :------: | :------: |
| 1 | a | | `Object` | `Geometry.Vector2D` | false | false | false |
| 2 | b | | `Object` | `Geometry.Vector2D` | false | false | false |

Overload resolution for `ADD`:

| Call | Matched overload |
| :--- | :--------------- |
| `ADD(1, 2)` | overload 1 — both arguments are `Number` |
| `ADD(v1, v2)` | overload 2 — both arguments are `Geometry.Vector2D` |
| `ADD(1, v1)` | error — no overload matches |

### Variadic collection

**`ARRAY(...elements? <Any>)`**

| Position | Name |   | Base type | Extended type | Any type | Multiple | Optional |
| :------: | :--: | - | :-------: | :-----------: | :------: | :------: | :------: |
| 1 | elements | | - | - | true | true | true |

`Multiple: true, Optional: true` — accepts any number of arguments, also none. Valid calls: `ARRAY()`, `ARRAY(3)`, `ARRAY(3, 5, 6)`. With `Optional: false`, at least one argument is required.

### Optional argument

**`JOIN(array <Array>, separator? <Text>)`**

| Position | Name |   | Base type | Extended type | Any type | Multiple | Optional |
| :------: | :--: | - | :-------: | :-----------: | :------: | :------: | :------: |
| 1 | array | | `Array` | - | false | false | false |
| 2 | separator | | `Text` | - | false | false | true |

| Call | Result |
| :--- | :----- |
| `JOIN([1,2,3])` | `"123"` |
| `JOIN([1,2,3], "-")` | `"1-2-3"` |

### Matching overloads

#### Function call
```php
MAX([15, 25, 20])
```

Function with identifier "MAX" called with 1 **Array** literal argument.

#### Function overloads

- Overload 1
    - Signature: `MAX(a <Number>, b <Number>)`
    - Description: Takes 2 numbers and returns the greater one.
    - Collection template:

        | # | Name |   | Base type | Extended type | Any type | Multiple | Optional |
        | - | :--: | - | :-------: | :-----------: | :------: | :------: | :------: |
        | 1 | a | | Number | - | false | false | false |
        | 2 | b | | Number | - | false | false | false |

    - Example:
      - Formula: `MAX(3, 5)`
      - Result: `5`

- Overload 2
    - Signature: `MAX(...numbers <Number>)`
    - Description: Returns the greatest number from the argument collection
    - Collection template:

        | # | Name |   | Base type | Extended type | Any type | Multiple | Optional |
        | - | :--: | - | :-------: | :-----------: | :------: | :------: | :------: |
        | 1 | numbers | | Number | - | false | true | false |

    - Example:
      - Formula: `MAX(5, 15, 25, 10, 20)`
      - Result: `25`

- Overload 3
    - Signature: `MAX(numbers <Array<Number>>)`
    - Description: Returns the greatest number from an array of numbers.
    - Collection template:

        | # | Name |   | Base type | Extended type | Any type | Multiple | Optional |
        | - | :--: | - | :-------: | :-----------: | :------: | :------: | :------: |
        | 1 | numbers | | Array&lt;Number&gt; | - | false | false | false |

    - Example:
      - Formula: `MAX([4, 5, 7, 9])`
      - Result: `9`

- Overload 4
    - Signature: `MAX(elements <Array>, handler <Delegate>)`
    - Description: Maps every element of the array with the handler function, and returns the greatest result.
    - Collection template:

        | # | Name |   | Base type | Extended type | Any type | Multiple | Optional |
        | - | :--: | - | :-------: | :-----------: | :------: | :------: | :------: |
        | 1 | elements | | Array | - | false | false | false |
        | 2 | handler | | Delegate | - | false | false | false |

    - Example 1:
      - Formula: `MAX([true, 4, 5, 7, "9"], (e) => IF(ISNUM(e), e, 0))`
      - Result: `7`
    
    - Example 2:
      - Formula: `MAX([ {name: "Anna", age: 15}, {name: "Billy", age: 18}, {name: "Charlie", age: 21} ], (e) => e.age)`
      - Result: `21`

#### Matching process

| Overload | Match | Explanation |
| :------: | :---: | :---------- |
| 1 | ❌ | Overload expects 2 numbers - both argument count and type are incorrect. |
| 2 | ❌ | Overload expects 1 or more numbers, doesn't accept array. |
| 3 | ✅ | The argument is an array and every element is a `Number`. |
| 4 | - | Not checked: the first matching overload is used. It would not match anyway, because the `handler` argument is missing. |

#### Resolution

The maximum value will be calculated by the 3rd overload of the `MAX` function.

The call `MAX([15, "25", 20])` matches no overload: overload 3 rejects the `Text` element and overload 4 requires a handler. It resolves to `ARGUMENT_ERROR`.

## Reference

- [Argument template](./argument_template.md)
- [Functions](../core/functions.md)
- [Primitives](../core/primitives.md)
