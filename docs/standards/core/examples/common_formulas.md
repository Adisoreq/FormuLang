# Common formulas

Common mathematical formulas written as **FormuLang** expressions.

## Formulas:

### 1. Delta

Discriminant that determines possible solutions (roots) of quadratic equation.

#### Math formula:

$$
\Delta = b^2 - 4ac
$$

#### **FormuLang** expression:

- Standard expression:

```
$ delta = SUB(POW(b, 2), MUL(MUL(4, a), c))
```

- Operator expression:

```
$ delta = b^2 - 4*a*c
```

---

### 2. Standard deviation 

The measure of how a group of numbers is spread out from their average.

#### Math formula:

$$
\delta = \sqrt{ \frac{ \Sigma (X - \mu)^2 }{ n } }
$$

#### **FormuLang** expression:

- Standard expression:

```
$ stdev = ROOT(DIV(SUM(MAP(arr, (e) => POW(SUB(e, AVG(arr)), 2))), LEN(arr)), 2)
```

- Operator expression:

```
$ stdev = ROOT(SUM(MAP(arr, (e) => (e - AVG(arr))^2)) / LEN(arr), 2)
```

---

### 3. Euclidean / Carthesian distance

Calculates the distance between two points $(x1, y1)$ and $(x2, y2)$ in a 2D plane.

#### Math formula:

$$
d = \sqrt{(x_2 - x_1)^2 + (y_2 - y_1)^2}
$$

- $d$ - distance
- $x_1$ - point 1, coordinate X
- $y_1$ - point 1, coordinate Y
- $x_2$ - point 2, coordinate X
- $y_2$ - point 2, coordinate Y

#### **FormuLang** expression:

- Standard expression:

```
$d = SQRT(ADD(POW(SUB(x2, x1), 2), POW(SUB(y2, y1), 2)))
```

- Operator expression:

```
$d = ((x2 - x1)^2 + (y2 - y1)^2) ^ 0.5
```

### 4. Compound Interest

Calculates the future value of an investment.

#### Math formula:

$$
A = P \left(1 + \frac{r}{n}\right)^{nt}
$$

- $P$ - Principal amount
- $r$ - Annual interest rate
- $n$ - Number of times interest applied per time period
- $t$ - Number of time periods

#### **FormuLang** expression:

- Standard expression:

```
$a = MUL(p, POW(ADD(1, DIV(r, n)), MUL(n, t)))
```

- Operator expression:

```
$a = p * (1 + r/n)^(n*t)
```

## Reference

- [Functions](../core/functions.md)
- [Variables](../core/containers.md)