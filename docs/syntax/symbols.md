# Symbols

List of symbols allowed inside **FormuLang** syntax and their usage.

## Symbols list

| Symbol | ASCII code (DEC) | ASCII code (HEX)
|---|---|---|
| `[Tab]` | 9 | 9 |
| `[New line]` | 10 | A |
| `[Space]` | 32 | 20 |
| `!` `"` `#` `$` `%` `&` `'` `(` `)` `*` `+` `,` `-` `.` `/` | 33 - 47 | 21 - 2F |
| `0` `1` `2` `3` `4` `5` `6` `7` `8` `9` | 48 - 57 | 30 - 39 |
| `:` `;` `<` `=` `>` `?` `@` | 58 - 64 | 3A - 40 |
| `A` `B` `C` `D` `E` `F` `G` `H` `I` `J` `K` `L` `M` `N` `O` `P` `Q` `R` `S` `T` `U` `V` `W` `X` `Y` `Z` | 65 - 90 | 41 - 5A |
| `[` `\` `]` `^` `_` `` ` `` | 91 - 96 | 5B - 60 |
| `a` `b` `c` `d` `e` `f` `g` `h` `i` `j` `k` `l` `m` `n` `o` `p` `q` `r` `s` `t` `u` `v` `w` `x` `y` `z` | 97 - 122 | 61 - 7A |
| `{` `\` `}` `~` | 123 - 126 | 7B - 7E | 

## Symbols classification
1. **Letters ( `a-z` , `A-Z` )** - used for naming **primitives** and initializing **text** literals
2. **Digits ( `0-9` )** - used for initializing **number** and **text** literals, and for naming **primitives**
3. **Special characters**
   - **Underline (`_`)** - used for naming **primitives**
   - **Operators ( `+` `-` `*` `/` `|` `\` `&` `%` `&` `^` `=` `<` `>` `!` `?` )** - used to define literals and call functions
   - **White spaces ( `[Space]` , `[Tab]` )** - Depending on dialect, either treated as separators, or purely cosmetic and ignored in parsing process
   - **Delimiters ( `()` `()` `{}` `"` )** - specify the boundaries of expressions
   - **Separators ( `,` `.` )** - separate expressions from each other and indicate their relations (**equal** or **parental**)
   - **Terminators ( `[New line]` `;` )** separate expression sequences from each other
   - **Sigils ( `@` `#` `$` )** - indicate the role of the sequence

## Escape sequences

Some specials characters need to be put in a combination with **backslash (`\`)** in order to be included in a text expression.

Characters that require an escape sequence: `\`,`"`,`[New line]`,`[Tab]`

### List of escape sequences:
- `\\` - **backslash (`\`)** symbol
- `\"` - **quotation mark (`"`)** symbol
- `\n` - **new line** symbol
- `\t` - **tabulator** symbol

### Example:

| Text input | Processed output |
|------------|------------------|
| `"This function is called "hyperbola"."` | ❌ Error due incorrect syntax, since the **quotation mark (`"`)** is a text delimiter. |
| `"This function is called \"hyperbola\"."` | ✅ `This function is called "hyperbola".` |
| `"Reading C:\Users\user\Documents\data.txt file..."` | ❌ Error due incorrect syntax, since the single **backslash (`\`)** is the **escape sequence** operator. |
| `"Reading C:\\Users\\user\\Documents\\data.txt file..."` | ✅ `Reading C:\Users\user\Documents\data.txt file...` |
| Text split into lines | ❌ Text expression must be a single-line character sequence. |
| `"Line 1\nLine 2\n..."` | ✅ Parser splits text using `\n` escape sequences. |