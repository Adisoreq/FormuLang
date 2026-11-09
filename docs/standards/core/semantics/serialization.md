# Serialization

Serialization is the process of transforming values with different types into text, following specific rules.

Used for debugging and console line display.


## Serialization parameters

Parameters that affect the serialization result. They are [environment variables](../README.md#3-serialization-variables), so a formula can override them for the current execution, e.g. `@decimal_place = 2`.

| Name | Type | Default | Description |
| :--: | :--: | :---: | ------------- |
| `decimal_place` | **Number** | `-1` | Used to specify, where the serialized number's notation ends |
| `split_array` | **Boolean** | false | Used to specify, if the serialized array should be split using `[New line]` symbols |
| `split_object` | **Boolean** | false | Used to specify, if the serialized object should be split using `[New line]` symbols |
| `include_object_class` | **Boolean** | false | Used to specify, if the serialized object should be preceded by its class notation |
| `max_array_preview` | **Number** | `-1` | Used to specify, how many elements of an array are serialized before the array is abbreviated |

> [!NOTE]
> Serialization is meant for reading. Its result does not have to be a valid formula: e.g. an abbreviated array cannot be parsed back.



## Simple types

### Null values

**Null** values are always serialized into `null` keyword.

Example:

| Type | Serialized |
| :--: | :--------: |
| Null | `null` |

### Boolean values

**Boolean** values are serialized into `true` or `false` keyword depending on their value.

Example:

| Type | Value | Serialized |
| :--: | :---: | :--------: |
| Boolean | true | `true` |
| Boolean | false | `false` |

### Number values

**Number** values are serialized using their decimal notation. Its length is dependent on serialization parameters.

- If `decimal_place` parameter is set to negative value, serialized number's notation is not limited and will be cut reaching its final non-zero digit.
- If `decimal_place` parameter is set to non-negative value, its serialized value is filled or rounded at the **n**-th decimal place

Examples:

| Type | Value | decimal_place | Serialized |
| :--: | :---: | :-----------: | :--------: |
| Number | 64 | -1 | `64` |
| Number | -12.0 | -1 | `-12` |
| Number | 128.24801540 | -1 | `128.2480154` |
| Number | 16.45 | 0 | `16` |
| Number | 2.58 | 0 | `3` |
| Number | 1.451 | 2 | `1.45` |
| Number | 1.451 | 3 | `1.451` |
| Number | 1.451 | 4 | `1.4510` |
| Number | 0.6666 | 3 | `0.667` |
| Number | 0.9999 | 3 | `1.000` |
| Number | 0.001 | 2 | `0.00` |
| Number | 0.001 | 3 | `0.001` |
| Number | 0.001 | 4 | `0.0010` |

> [!IMPORTANT]
> Even with `decimal_place` set to negative number, the serialization output still might be limited by executing program, language, or environment implementation.


### Text values

**Text** values are serialized by directly retrieving their content.

Example:

| Type | Value | Serialized |
| :--: | :---: | :--------: |
| Text | `This is text value` | `This is text value` |


### Undefined values

**Undefined** values are always serialized into `undefined` keyword.

Example:

| Type | Serialized |
| :--: | :--------: |
| Undefined | `undefined` |


### Error values

**Error** values are serialized using the following pattern:

`[<ERROR_NAME> (<ERROR_CODE>)] <ERROR_DESCRIPTION>`

Example:

<table>
    <thead align="center">
        <tr>
            <td colspan="3">Error</td>
            <td rowspan="2">Serialized</td>
        </tr>
        <tr>
            <td>Name</td>
            <td>Code</td>
            <td>Description</td>
        </tr>
    </thead>
    <tbody align="center">
        <tr>
            <td><code>CUSTOM_ERROR</code></td>
            <td><code>1</code></td>
            <td><code>You've reached a breakpoint.</code></td>
            <td><code>[CUSTOM_ERROR (1)] You've reached a breakpoint.</code></td>
        </tr>
        <tr>
            <td><code>INVALID_INDEX_ERROR</code></td>
            <td><code>7</code></td>
            <td><code>Trying to access non-existent array index.</code></td>
            <td><code>[INVALID_INDEX_ERROR (7)] Trying to access non-existent array index.</code></td>
        </tr>
    </tbody>
</table>


## Complex types

### Array values

**Array** values are serialized by enclosing their serialized elements inside **square brackets (`[]`)** and splitting them with **coma (`,`)** symbol.

The `split_array` parameter specifies whether every element should be separated with `[New line]` or not.

Example:

| Type | Value | split_array | Serialized |
| :--: | :---: | :-----------: | :--------- |
| Array | 1, 2 .. 10 | false | `[1, 2, 3, 4, 5, 6, 7, 8, 9, 10]` |
| Array | "abc", "def", "ghi" | true | `[` <br> `  "abc",` <br> `  "def",` <br> `  "ghi"` <br> `]` | 

The `max_array_preview` parameter limits the number of serialized elements:

- If it is negative, or the array has no more elements than its value, every element is serialized.
- Otherwise, with `k` set to its value, only the first `ceil(k / 2)` and the last `floor(k / 2)` elements are serialized, and the omitted ones are replaced with a single `...` element.
- The parameter applies to every array separately, including nested arrays.

Example:

| Type | Value | max_array_preview | Serialized |
| :--: | :---: | :---------------: | :--------- |
| Array | 1, 2 .. 12 | -1 | `[1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]` |
| Array | 1, 2 .. 100 | 10 | `[1, 2, 3, 4, 5, ..., 96, 97, 98, 99, 100]` |
| Array | 1, 2 .. 100 | 5 | `[1, 2, 3, ..., 99, 100]` |
| Array | 1, 2, 3 | 5 | `[1, 2, 3]` |
| Array | 1, 2 .. 100 | 0 | `[...]` |

### Object values

**Object** values are serialized by enclosing their serialized key-value pairs inside **curly brackets (`{}`)** and splitting them with **coma (`,`)** symbol.

The key-value pairs of an **object** are serialized by separating them with `:` symbol. Keys are always valid identifiers, so they are serialized without quotation marks.

The `split_object` parameter specifies whether every element should be separated with `[New line]` or not.

The `include_object_class` parameter specifies whether the object notation should be preceded by object's **class notation**.

- If the object derives from a specific class, its **class notation** is build by enclosing its [**extended type**](/docs/core/types.md#extended-types) inside **square brackets (`[]`)**.

- Otherwise, the **class notation** is built by enclosing the `Object` keyword inside **square brackets (`[]`)**.

Examples:

<table>
    <thead align="center">
        <tr>
            <td colspan="3"><b>Object</b></td>
            <td colspan="2"><b>Parameters</b></td>
            <td rowspan="2"><b>Serialized</b></td>
        </tr>
        <tr>
            <td><b>Base type</b></td>
            <td><b>Extended type</b></td>
            <td><b>Value</b></td>
            <td><b>split_object</b></td>
            <td><b>include_object_class</b></td>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>Object</td>
            <td align="center">-</td>
            <td>name: "John", age: 24</td>
            <td align="center">false</td>
            <td align="center">false</td>
            <td><code>{ name: "John", age: 24 }</code></td>
        </tr>
        <tr>
            <td>Object</td>
            <td align="center">-</td>
            <td>name: "John", age: 24</td>
            <td align="center">false</td>
            <td align="center">true</td>
            <td><code>[Object] { name: "John", age: 24 }</code></td>
        </tr>
        <tr>
            <td>Object</td>
            <td align="center">-</td>
            <td>name: "John", age: 24</td>
            <td align="center">true</td>
            <td align="center">false</td>
            <td>
                <code>{</code><br> 
                <code>  name: "John",</code><br>
                <code>  age: 24</code><br>
                <code>}</code>
            </td>
        </tr>
        <tr>
            <td>Object</td>
            <td align="center">-</td>
            <td>name: "John", age: 24</td>
            <td align="center">true</td>
            <td align="center">true</td>
            <td>
                <code>[Object] {</code><br> 
                <code>  name: "John",</code><br>
                <code>  age: 24</code><br>
                <code>}</code>
            </td>
        </tr>
        <tr>
            <td>Object</td>
            <td align="center">Geometry.Vector3D</td>
            <td>x: 2, y: 1.5, z: 0</td>
            <td align="center">false</td>
            <td align="center">false</td>
            <td><code>{ x: 2, y: 1.5, z: 0 }</code></td>
        </tr>
        <tr>
            <td>Object</td>
            <td align="center">Geometry.Vector3D</td>
            <td>x: 2, y: 1.5, z: 0</td>
            <td align="center">false</td>
            <td align="center">true</td>
            <td><code>[Geometry.Vector3D] { x: 2, y: 1.5, z: 0 }</code></td>
        </tr>
        <tr>
            <td>Object</td>
            <td align="center">Geometry.Vector3D</td>
            <td>x: 2, y: 1.5, z: 0</td>
            <td align="center">true</td>
            <td align="center">false</td>
            <td>
                <code>{</code><br>
                <code>  x: 2,</code><br>
                <code>  y: 1.5,</code><br>
                <code>  z: 0</code><br>
                <code>}</code><br>
            </td>
        </tr>
        <tr>
            <td>Object</td>
            <td align="center">Geometry.Vector3D</td>
            <td>x: 2, y: 1.5, z: 0</td>
            <td align="center">true</td>
            <td align="center">true</td>
            <td>
                <code>[Geometry.Vector3D] {</code><br>
                <code>  x: 2,</code><br>
                <code>  y: 1.5,</code><br>
                <code>  z: 0</code><br>
                <code>}</code><br>
            </td>
        </tr>
    </tbody>
</table>

### Delegate values

**Delegate** serialization is dependent on the stored function reference.

- If delegate stores **named function**, the serializer follows the template: `<FUNCTION_NAME>(args) => any`

- If delegate stores **anonymous function**, the serializer follows the template: `(<ARGUMENT_NAMES>) => any`

Examples:

| Stored function | Function type | Serialized |
| :-------------- | :------------ | :--------- |
| `AVG` | Named function | AVG(args) => any |
| `(x, y) => x * y` | Lambda function | (x, y) => any


## Reference

- [Core/Types](../types/README.md)
- [Functions](/docs/core/functions.md)
- [Types](/docs/core/types.md)