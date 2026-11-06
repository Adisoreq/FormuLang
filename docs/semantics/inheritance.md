# Inheritance

Inheritance is the mechanism by which [extended types](../core/types.md#extended-types) derive properties from other types, forming a structured hierarchy rooted at the built-in **Object** type.

Every extended type is a direct child or an indirect descendant of **Object**. This hierarchy determines how values are validated during [execution](execution.md), and which types are accepted by function parameters.


## Object as the root type

**Object** is the universal base type for all extended types. It carries no predefined properties of its own, but establishes the common ancestor from which every extended type inherits.

| Type | Category | Properties |
| :--- | :------- | :--------- |
| `Object` | Base | *(none)* |
| Any extended type | Extended | Extends `Object` directly or indirectly |


## Inheritance chain

An extended type inherits all properties defined by every type above it in the chain. Each child type extends its parent, preserving its properties.

**`Object`** > **`Level 1 descendant`** > **`Level 2 descendant`** > ...

### Property accumulation

| Level | Type | Extends properties |
| :---: | :--: | :-------------- |
| 0 | `Object` | *(root — no properties)* |
| 1 | `Standard.T1` | Properties defined at this level |
| 2 | `Standard.T2` | Inherits level 1, adds its own properties |
| 3 | `Standard.T3` | Inherits levels 1–2, adds its own properties |
| ... | ... | ... |


## Subtype compatibility (polymorphism)

When a function declares a parameter of type **T**, any value whose type is **T** or a descendant of **T** is accepted. 

This relationship is one-sided - a function expecting a more specific type will not accept a less specific one, as the parent type may lack properties the function requires.

Given the chain `T0` > `T1` > `T2`:

| Function signature | Accepted types |
| :----------------- | :------------- |
| `FUNCTION(T0)` | `T0`, `T1`, `T2` |
| `FUNCTION(T1)` | `T1`, `T2` |
| `FUNCTION(T2)` | `T2` only |

## Example

Geometry extension types

### Inheritance tree

`Object` > `Geometry.Point2D`

`Object` > `Geometry.Transform2D`

`Object` > `Geometry.Object2D`

`Object` > `Geometry.Object2D` > `Geometry.Figure2D`

`Object` > `Geometry.Object2D` > `Geometry.Figure2D` > `Geometry.Circle2D`

`Object` > `Geometry.Object2D` > `Geometry.Figure2D` > `Geometry.Polygon2D`


### Property breakdown

| Level | Type | Inherits from | Adds properties |
| :---: | :--- | :------------ | :-------------- |
| 0 | `Object` | *none* | *none* |
| 1 | `Geometry.Point2D` | `Object` | `x` `y` |
| 1 | `Geometry.Transform2D` | `Object` | `position` `rotation` `scale` |
| 1 | `Geometry.Object2D` | `Object` | `transform` |
| 2 | `Geometry.Figure2D` | `Geometry.Object2D` | `area` |
| 3 | `Geometry.Polygon2D` | `Geometry.Figure2D` | `vertices` `edges` |
| 3 | `Geometry.Circle2D` | `Geometry.Figure2D` | `radius` `perimeter` |


### Subtype compatibility in practice

#### Scaling 2D figures

Formula:
```php
$c = CIRCLE_2D(POINT_2D(0, 0), 4)   # center = { x: 0, y: 0 }, radius = 4
$c = MOVE($c, VECTOR_2D(2, 2))      # position changed by [2,2]
$c = SCALE($c, 1.5)                 # scale changed by [1.5, 1.5]

{ center: $c.transform.position, radius: $c.radius }
```

Result:
```js
{ 
    center: [Geometry.Vector2D] { 
        x: 2, 
        y: 2,
        length: 2.828427125
    }, 
    radius: 6 
}
```

#### Explanation

`MOVE`, `ROTATE`, `SCALE` are methods transforming objects with type `Geometry.Object2D`, but also applies to its descendants.


## Reference

- [Types](../core/types.md)
- [Primitives](../core/primitives.md)
- [Functions](../core/functions.md)
- [Execution](execution.md)
