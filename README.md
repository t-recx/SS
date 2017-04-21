# What is this?
SS (Simple Spreadsheet) is a command line spreadsheet program for DOS made in Turbo Pascal 7. 
I made it when I was still a student for a school project and thought it was lost forever until I found it on an old external HDD.
It's pretty feature-complete, supporting crude mathematical formulas, graphical representation of data and even printing [!]
The original README is in portuguese and the formatting is all off, so here's the gist of it:

# Keys
* Cursor keys: change cell
* ENTER: Set a cell value (start with '=' for an expression)
* '.': copy cell
* '-': paste copied
* Z, X, C: Change text alignment
* W, E: Increase / decrease column size
* S, D: Increase / decrease line size
* O, P: Change currently selected background color 
* L, Ç: Change currently selected text color
* Q, A: Change background / foreground colour to currently selected colors
 
* ESCAPE: Enter command mode

Cells are identified by their column name and line number (ex: A12, D4)
# Commands
- New
- Load <file>
- Save <file>
- Select 
  - Textcolor <name>
  - Backgroundcolor <name>
  - Change
    - Textcolor <name> <cell>
    - Backgroundcolor <name> <cell>
    - Width <cell> <size>
    - Alignment <cell> <alignment>
- Graph <first label cell> <last label cell> <first value cell> <last value cell> [type of graphic]
- Help
- Print
- Translate
- Quit

# Constants
## Alignments
* Center             
* Left               
* Right              

## Colours
* Black              
* Blue               
* Green              
* Cyan               
* Red                
* Magenta            
* Brown              
* LightGray          
* DarkGray           
* LightBlue          
* LightGreen         
* LightCyan          
* LightRed           
* LightMagenta       
* Yellow             
* White              

## Types of Graphics
* Bars
* Lines

My god, I really was a boring kid.
