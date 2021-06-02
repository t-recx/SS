# Welcome!

Simple Spreadsheet is a terminal-based spreadsheet program for DOS made in Turbo Pascal 7. It was made for an end-of-year school project.

It supports mathematical formulas, charts, internationalization and printing using a serial printer.

# Usage

SS has three modes of operation: **Normal mode**, **cell value assignment mode** and **command mode**.

* **Normal mode** is used for formatting, movement and editing between cells;
* **Cell value assignment mode** is used to insert or edit a value in a cell. Press _ENTER_ while in **normal mode** to start, and _ENTER_ again to finish;
* **Command mode** is used to enter commands that operate on a file (loading, saving, discarding), formatting cells, plot charts, print documents, or other program operations like changing language or exiting. Press _ESCAPE_ while in **normal mode** to start, _ENTER_ to execute command or _ESCAPE_ to cancel and go back to **normal mode**.

Cells are identified by their column name and line number (ex: A12, d4)

## Keys

### Normal mode

|Key|Description|
|:-:|-|
|Cursors|Changes selected cell|
|ENTER|Enters **cell value assignment mode**|
|.|Copies cell|
|-|Pastes cell|
|Z|Changes selected cell's text alignment to the left|
|X|Changes selected cell's text alignment to the center|
|C|Changes selected cell's text alignment to the right|
|W|Increases selected column's size|
|E|Decreases selected column's size|
|S|Increases selected line's size|
|D|Decreases selected line's size|
|O|Changes currently selected background colour|
|P|Changes currently selected text colour|
|Q|Changes currently selected cell's background colour to the one specified by the Select command|
|A|Changes currently selected cell's text colour to the one specified by the Select command|
|K|Reverts to default colours (light gray for text, black for foreground)|
|ESC|Enters **command mode**|

### Cell value assignment mode

|Key|Description|
|:-:|-|
|Cursors|Changes character position|
|ENTER|Finishes editing and returns to **normal mode**|
|ESC|Leaves **cell value assignment mode** and returns to **normal mode**|

### Command mode

|Key|Description|
|:-:|-|
|Cursors|Changes character position|
|ENTER|Executes command|
|ESC|Leaves **command mode** and returns to **normal mode**|

## Commands

Use _ESCAPE_ to enter **command mode**. To execute a command, write it down along with its parameters and press _ENTER_. SS supports the following commands:

|Name|Parameters|Description|
|-|-|-|
|New||Creates a new file|
|Load|\<filename>|Loads \<filename>|
|Save|\<filename>|Writes file into \<filename>|
|Select Textcolour|[\<colour>](#colours)|Selects [\<colour>](#colours) for foreground text applied when pressing A|
|Select Backgroundcolour|[\<colour>](#colours)|Selects [\<colour>](#colours) for the cell's background applied when pressing Q|
|Select Change Textcolour|[\<colour>](#colours) \<cell>|Selects [\<colour>](#colours) for the \<cell>'s foreground text|
|Select Change Backgroundcolour|[\<colour>](#colours) \<cell>|Selects [\<colour>](#colours) for the \<cell>'s background|
|Select Change Width|\<cell> \<size>|Changes \<cell>'s width to \<size>|
|Select Change Alignment|\<cell> [\<alignment>](#alignments)|Changes \<cell>'s text alignment|
|Graph|\<first_label_cell> \<last_label_cell> \<first_value_cell> \<last_value_cell> [[chart_type]](#chart-types)|Plots a chart using as labels the specified by the interval \<first_label_cell> and \<last_label_cell> and using as values the cells specified by the interval \<first_value_cell> and \<last_value_cell> using the [chart_type]|
|Help||Shows the help screen|
|Print||Prints the spreadsheet|
|Translate||Opens the menu showing the various supported languages|
|Quit||Exits the program|

## Operators

SS supports various operators. To use them, prefix a cell value with the '=' character.

|Operator|Precedence|Type|Description|Example|
|-|-|-|-|-|
|:|1st|Sum|Sums all cells between first and second operands|=a1:a10|
|*|2nd|Multiplication|Multiplies two cells|=a1\*b1|
|/|2nd|Division|Divides a cell by another|=a1\/a2|
|+|3rd|Addition|Adds two cells|=c1+c2|
|-|3rd|Subtraction|Subtracts two cells|=d1-d10|
|>|4th|Relational >|Compares two cells, returning 1 if the first cell has a higher value than the second or 0 otherwise|=a1\>a2|
|<|4th|Relational <|Compares two cells, returning 1 if the first cell has a lower value than the second or 0 otherwise|=a1\<a2|
|=|4th|Relational =|Compares two cells, returning 1 if the first cell has a  value equal to the second or 0 otherwise|=a1=a2|
|!|4th|Relational ≠|Compares two cells, returning 1 if the first cell has a  different value compared to the second or 0 otherwise|=a1\!a2|
|&|5th|Logical AND|Returns 1 if both operands' values are different than 0, or 0 otherwise|=a10=a12&c10=c12|
|\||5th|Logical OR|Returns 1 if any of the operands' values are different than 0, or 0 otherwise|=a10=a12\|c10=c12|
|~|6th|Rounding|Rounds results to the value specified by the second operand|=(c1+c2)\/a5~2|

## Reference values

### Alignments

|Left|Center|Right|
|:--|:-:|--:|
|Left aligned text|Centered text|Right aligned text||

### Colours

- ![Black](https://via.placeholder.com/15/000000/000000?text=+) Black
- ![Blue](https://via.placeholder.com/15/0000FF/000000?text=+) Blue
- ![Green](https://via.placeholder.com/15/008000/000000?text=+) Green
- ![Cyan](https://via.placeholder.com/15/00FFFF/000000?text=+) Cyan
- ![Red](https://via.placeholder.com/15/FF0000/000000?text=+) Red
- ![Magenta](https://via.placeholder.com/15/FF00FF/000000?text=+) Magenta
- ![Brown](https://via.placeholder.com/15/964B00/000000?text=+) Brown
- ![LightGray](https://via.placeholder.com/15/C0C0C0/000000?text=+) LightGray
- ![DarkGray](https://via.placeholder.com/15/808080/000000?text=+) DarkGray
- ![LightBlue](https://via.placeholder.com/15/add8e6/000000?text=+) LightBlue
- ![LightGreen](https://via.placeholder.com/15/90ee90/000000?text=+) LightGreen
- ![LightCyan](https://via.placeholder.com/15/e0ffff/000000?text=+) LightCyan
- ![LightRed](https://via.placeholder.com/15/ffcccb/000000?text=+) LightRed
- ![LightMagenta](https://via.placeholder.com/15/ff80ff/000000?text=+) LightMagenta
- ![Yellow](https://via.placeholder.com/15/FFFF00/000000?text=+) Yellow
- ![White](https://via.placeholder.com/15/FFFFFF/000000?text=+) White

### Chart types

|Type|Name|
|:-:|-|
|▄▒█|Bars|
|_/¯|Lines|

