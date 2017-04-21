Unit SSLogic;

Interface

Uses
 Crt, GeneralDrawing, SSType, SSConv, SSDraw, SSTrans, SSFile, SSInit,
 SSInt, SSGraph;

Function GetKey (Prog : TProgPtr) : Boolean;

Const
 Up    = 0;
 Down  = 1;
 Left  = 2;
 Right = 3;

Implementation

{*
 * ScrollIfNeeded
 *
 * Arguments
 *  Prog : TProgPtr - A pointer to the main program's data structure.
 *
 *  If the cursor's location is out of the screen (i.e. not visible) this
 * function changes the ScrollColumn and ScrollLine variables until it's
 * visible again.
 *}
Procedure ScrollIfNeeded (Prog : TProgPtr);
Var
 X, Y, Z, ispres, PreviousSize : Integer;
Begin
 For Z:=1 to LinesMaximum do
 Begin
  PreviousSize:= 1;
  ispres:= 0;
  For Y:=1+Prog^.ScrollLine to LinesMaximum do
  Begin
   If (Prog^.CurrentLine=Y) and (2+PreviousSize>24) then Inc (Prog^.ScrollLine);
   If (Prog^.CurrentLine=Y) then ispres:= 1;
   PreviousSize:= PreviousSize+Prog^.LineDimension[Y];
  End;
  If (ispres=0) then Dec (Prog^.ScrollLine);
 End;

 For Z:=1 to ColumnsMaximum do
 Begin
  PreviousSize:= 1;
  ispres:= 0;
  For X:=1+Prog^.ScrollColumn to ColumnsMaximum do
  Begin
   If (Prog^.CurrentColumn=X) and (3+PreviousSize>=80) then Inc (Prog^.ScrollColumn);
   If (Prog^.CurrentColumn=X) then ispres:= 1;
   PreviousSize:= PreviousSize+Prog^.ColumnDimension[X];
  End;
  If (ispres=0) then Dec (Prog^.ScrollColumn);
 End;
End;

{*
 * Paste
 *
 * Arguments
 *  Prog : TProgPtr    - A pointer to the main program's data structure.
 *  OCX, OCY : Integer - The coordinates of the original cell
 *  NCX, NCY : Integer - The coordinates of the cell in which the new
 *                       properties are to be pasted.
 *
 *  Copies the properties (value, text and background colour, text alignment)
 * of Cell[OCY, OCX] into Cell[NCY, NCX]. If the original cell's value is a
 * formula it's cell's identifiers are changed according to the relative
 * position of one cell to the other.
 *}
Procedure Paste (Prog : TProgPtr; OCX, OCY, NCX, NCY : Integer);
Var
 C, D   : Integer;
 NCV    : String;
 Number : String;
Begin
 NCV:= Prog^.Cell[OCY, OCX].Value;

 If (NCV[1]='=') then
 Begin
  For C:=2 to Length (NCV) do
  Begin
   If (LowCase (NCV[C]) in ['a'..'z']) then
   Begin
    NCV[C]:= Chr (Ord (NCV[C])+NCX-OCX);
    D:= C;
    Repeat
     Inc (D);
    Until not (NCV[D] in ['0'..'9']);
    Number:= Copy (NCV, C+1, D-C-1);
    Delete (NCV, C+1, Length (Number));
    Insert (itos (stoi (Number)+NCY-OCY), NCV, C+1);
   End;
  End;
 End;

 Prog^.Cell[NCY, NCX].TextAlignment:= Prog^.Cell[OCY, OCX].TextAlignment;
 Prog^.Cell[NCY, NCX].ForegroundColor:= Prog^.Cell[OCY, OCX].ForegroundColor;
 Prog^.Cell[NCY, NCX].BackgroundColor:= Prog^.Cell[OCY, OCX].BackgroundColor;

 Prog^.Cell[NCY, NCX].Value:= NCV;
End;

{*
 * MoveSelection
 *
 * Arguments
 *  Prog : TProgPtr  - A pointer to the main program's data structure.
 *  Direction : Byte - A direction.
 *
 *  Changes the currently selected cell to the one right next to it,
 * in the specified direction.
 *}
Procedure MoveSelection (Prog : TProgPtr; Direction : Byte);
Begin
 Case Direction of
  Up:
  Begin
   Dec (Prog^.CurrentLine);
   If (Prog^.CurrentLine<=0) then Prog^.CurrentLine:= LinesMaximum;
  End;

  Down:
  Begin
   Inc (Prog^.CurrentLine);
   If (Prog^.CurrentLine>LinesMaximum) then Prog^.CurrentLine:= 1;
  End;

  Left:
  Begin
   Dec (Prog^.CurrentColumn);
   If (Prog^.CurrentColumn<=0) then Prog^.CurrentColumn:= ColumnsMaximum;
  End;

  Right:
  Begin
   Inc (Prog^.CurrentColumn);
   If (Prog^.CurrentColumn>ColumnsMaximum) then Prog^.CurrentColumn:= 1;
  End;
 End;

 ScrollIfNeeded (Prog);
End;

{*
 * InsertCellValue
 *
 * Arguments
 *  Prog : TProgPtr - A pointer to the main program's data structure.
 *
 *  Positions the cursor on the selected cell's coordinates and reads
 * a user-inserted string, which it then assigns to the cell's value.
 * The current colours definitions (for both text and background) are
 * also assigned to the cell.
 *}
Procedure InsertCellValue (Prog : TProgPtr);
Var
 A, B, X, Y    : Integer;
 PreviousSizeX : Integer;
 PreviousSizeY : Integer;
 Value         : String;
Begin
 PreviousSizeX:= 1;
 PreviousSizeY:= 1;

 For Y:=1+Prog^.ScrollLine to LinesMaximum do
 Begin
  PreviousSizeX:= 1;
  For X:=1+Prog^.ScrollColumn to ColumnsMaximum do
  Begin
   If (X=Prog^.CurrentColumn) and (Y=Prog^.CurrentLine) then
   Begin
    For B:=0 to Prog^.LineDimension[Y]-1 do
    Begin
     For A:=0 to Prog^.ColumnDimension[X]-1 do
     Begin
      PutChar (' ', 3+PreviousSizeX+A, 2+PreviousSizeY+B, CellForegroundSelected,
               CellBackgroundSelected);
     End;
    End;
    PutScreen;
    Value:= GetText (Prog^.Cell[Y, X].Value, 3+PreviousSizeX, 2+PreviousSizeY, CellForegroundSelected, CellBackgroundSelected);
    Prog^.Cell[Y, X].Value:= Value;
    Prog^.Cell[Y, X].ForegroundColor:= Prog^.SelectedTextColor;
    Prog^.Cell[Y, X].BackgroundColor:= Prog^.SelectedBackgroundColor;
   End;
   PreviousSizeX:= PreviousSizeX+Prog^.ColumnDimension[X];
  End;
  PreviousSizeY:= PreviousSizeY+Prog^.LineDimension[Y];
 End;
End;

{*
 * CommandLine
 *
 * Arguments
 *  Prog : TProgPtr - A pointer to the main program's data structure.
 *
 *  Reads a string and divides it in commands, sub-commands and variables
 * which it then interpretates, executing the function that is associated
 * to the inserted command.
 *}
Function CommandLine (Prog : TProgPtr) : Boolean;
Var
 C        : Integer;
 NTokens  : Integer;
 LastStop : Integer;
 S, Value : String;
 Token    : Array [1..20] of String[30];
Begin
 TextColor (LightGray);
 CommandLine:= False;
 Window (1, 25, 79, 25);
 Gotoxy (1, 1);
 ClrEol;

 ReadLN (Value);
 Window (1, 1, 80, 25);

 LastStop:= 1;
 Value:= Value + ' ';
 For NTokens:=1 to 20 do Token[NTokens]:= '';

 NTokens:= 1;
 For C:=1 to Length (Value) do
 Begin
  If (Value[C]=' ') then
  Begin
   Token[NTokens]:= LowCaseString (Copy (Value, LastStop, C-LastStop));
   Inc (NTokens);
   LastStop:= C+1;
  End;
 End;

 If (Token[1]=GTS ('quit')) then
 Begin
  CommandLine:= True;
 End
 Else If (Token[1]=GTS ('select')) then
 Begin
  If (Token[2]=GTS ('textcolor')) then
  Begin
   Prog^.SelectedTextColor:= ColorToNumber (Token[3]);
  End
  Else If (Token[2]=GTS ('backgroundcolor')) then
  Begin
   Prog^.SelectedBackgroundColor:= ColorToNumber (Token[3]);
  End
  Else
  Begin
   Gotoxy (1, 25); ClrEol;
   Write (GTS ('Unknown command'),': ', Token[2],'.');
   Repeat Until (KeyPressed);
  End;
 End

 Else If (Token[1]=GTS ('graph')) then
 Begin
  If (NTokens>5) then
  Begin
   MakeGraph (Prog,
              GetColumn (Token[2]), GetLine (Token[2]),
              GetColumn (Token[3]), GetLine (Token[3]),
              GetColumn (Token[4]), GetLine (Token[4]),
              GetColumn (Token[5]), GetLine (Token[5]),
              GetGraphicType (Token[6]));
   ClearScreen;
   DrawProgram (Prog);
  End
  Else
  Begin
   Gotoxy (1, 25); ClrEol;
   Write (GTS ('Usage: Graph <LabelStart> <LabelFinish> <ValueStart> <ValueFinish> [GraphType].'));
   Repeat Until (KeyPressed);
  End;
 End

 Else If (Token[1]=GTS ('change')) then
 Begin
  If (Token[2]=GTS ('textcolor')) then
  Begin
   If (NTokens>4) then
    Prog^.Cell[GetLine (Token[3]), GetColumn (Token[3])].ForegroundColor:= ColorToNumber (Token[4])
   Else
   Begin
    Gotoxy (1, 25); ClrEol;
    Write (GTS ('Usage: Change TextColor <Cell> <Color>.'));
    Repeat Until (KeyPressed);
   End;
  End
  Else If (Token[2]=GTS ('backgroundcolor')) then
  Begin
   If (NTokens>4) then
    Prog^.Cell[GetLine (Token[3]), GetColumn (Token[3])].BackgroundColor:= ColorToNumber (Token[4])
   Else
   Begin
    Gotoxy (1, 25); ClrEol;
    Write (GTS ('Usage: Change BackgroundColor <Cell> <Color>.'));
    Repeat Until (KeyPressed);
   End;
  End
  Else If (Token[2]=GTS ('width')) then
  Begin
   If (NTokens>4) then
    Prog^.ColumnDimension[GetColumn (Token[3])]:= stoi (Token[4])
   Else
   Begin
    Gotoxy (1, 25); ClrEol;
    Write (GTS ('Usage: Change Width <Column> <Dimension>.'));
    Repeat Until (KeyPressed);
   End;
  End
  Else If (Token[2]=GTS ('height')) then
  Begin
   If (NTokens>4) then
    Prog^.LineDimension[stoi (Token[3])]:= stoi (Token[4])
   Else
   Begin
    Gotoxy (1, 25); ClrEol;
    Write (GTS ('Usage: Change Height <Line> <Dimension>.'));
    Repeat Until (KeyPressed);
   End;
  End
  Else If (Token[2]=GTS ('alignment')) then
  Begin
   If (NTokens>4) then
    Prog^.Cell[GetLine (Token[3]), GetColumn (Token[3])].TextAlignment:= GetAlignment (Token[4])
   Else
   Begin
    Gotoxy (1, 25); ClrEol;
    Write (GTS ('Usage: Change Alignment <Cell> <Alignment>.'));
    Repeat Until (KeyPressed);
   End;
  End
  Else
  Begin
   Gotoxy (1, 25); ClrEol;
   Write (GTS ('Unknown command'),': ', Token[2],'.');
   Repeat Until (KeyPressed);
  End;
 End
 Else If (Token[1]=GTS ('new')) then
 Begin
  InitProgram (Prog);
 End
 Else If (Token[1]=GTS ('load')) then
 Begin
  If (Token[2]<>'') then
  Begin
   S:= FileLoad (Prog, Token[2]);
   DrawValues (Prog);
  End
  Else S:= GTS ('Usage: Load <FileName>.');
  Gotoxy (1, 25); ClrEol;
  Write (S);
  Repeat Until (KeyPressed);
 End
 Else If (Token[1]=GTS ('save')) then
 Begin
  Gotoxy (1, 25); ClrEol;
  If (Token[2]<>'') then Write (FileSave (Prog, Token[2]))
  Else Write (GTS ('Usage: Save <FileName>.'));

  Repeat Until (KeyPressed);
 End
 Else If (Token[1]=GTS ('translate')) then
 Begin
  SelectTranslation;
 End
 Else If (Token[1]=GTS ('print')) then
 Begin
  PrintScreen;
 End
 Else If (Token[1]=GTS ('help')) then
 Begin
  S:= FileLoad (Prog, GTS ('help.hlp'));
  DrawValues (Prog);
  If (S=GTS ('File not found.')) then
  Begin
   S:= GTS ('Help file not found.');
  End
  Else S:= GTS ('Help file successfully loaded.');
  Gotoxy (1, 25); ClrEol;
  Write (S);
  Repeat Until (KeyPressed);
 End
 Else
 Begin
  Gotoxy (1, 25); ClrEol;
  Write (GTS ('Unknown command'),': ', Token[1], '.');
  Repeat Until (KeyPressed);
 End;
End;

{*
 * GetKey
 *
 * Arguments
 *  Prog : TProgPtr - A pointer to the main program's data structure.
 *
 *  Waits for a key press and does the function that is associated to
 * it. Returns True if the user wants to quit and False otherwise.
 *}
Function GetKey (Prog : TProgPtr) : Boolean;
Var
 Key : Char;
Begin
 GetKey:= False;

 Repeat Until (KeyPressed);
 Key:= ReadKey;

 Case Ord (Key) of
  27: GetKey:= CommandLine (Prog); {Escape}
  13: InsertCellValue (Prog); {Enter}
  09: GetKey:= True; {Tab}

  55: {Up and left}
  Begin
   MoveSelection (Prog, Up);
   MoveSelection (Prog, Left);
  End;
  49: {Down and left}
  Begin
   MoveSelection (Prog, Down);
   MoveSelection (Prog, Left);
  End;
  57: {Up and right}
  Begin
   MoveSelection (Prog, Up);
   MoveSelection (Prog, Right);
  End;
  51: {Down and right}
  Begin
   MoveSelection (Prog, Down);
   MoveSelection (Prog, Right);
  End;
  56, 72: MoveSelection (Prog, Up); {Up}
  54, 77: MoveSelection (Prog, Right); {Right}
  52, 75: MoveSelection (Prog, Left); {Left}
  50, 80: MoveSelection (Prog, Down); {Down}

  122, 90: Prog^.Cell[Prog^.CurrentLine, Prog^.CurrentColumn].TextAlignment:= TextLeft;
  120, 88: Prog^.Cell[Prog^.CurrentLine, Prog^.CurrentColumn].TextAlignment:= TextCenter;
  99,  67: Prog^.Cell[Prog^.CurrentLine, Prog^.CurrentColumn].TextAlignment:= TextRight;

  113, 81: Prog^.Cell[Prog^.CurrentLine, Prog^.CurrentColumn].BackgroundColor:= Prog^.SelectedBackgroundColor;
  97,  65: Prog^.Cell[Prog^.CurrentLine, Prog^.CurrentColumn].ForegroundColor:= Prog^.SelectedTextColor;

  101, 69: Inc (Prog^.ColumnDimension[Prog^.CurrentColumn]);
  119, 87:
  Begin
   Dec (Prog^.ColumnDimension[Prog^.CurrentColumn]);
   If (Prog^.ColumnDimension[Prog^.CurrentColumn]<1) then Prog^.ColumnDimension[Prog^.CurrentColumn]:= 1;
  End;

  100, 68: Inc (Prog^.LineDimension[Prog^.CurrentLine]);
  115, 83:
  Begin
   Dec (Prog^.LineDimension[Prog^.CurrentLine]);
   If (Prog^.LineDimension[Prog^.CurrentLine]<1) then Prog^.LineDimension[Prog^.CurrentLine]:= 1;
  End;

  46: {.}
  Begin
   Prog^.OCX:= Prog^.CurrentColumn;
   Prog^.OCY:= Prog^.CurrentLine;
  End;

  45: Paste (Prog, Prog^.OCX, Prog^.OCY, Prog^.CurrentColumn, Prog^.CurrentLine); {-}

  111, 79: {o}
  Begin
   If (Prog^.SelectedBackgroundColor=0) then Prog^.SelectedBackgroundColor:= 7;
   Dec (Prog^.SelectedBackgroundColor);
  End;

  112, 80: {p}
  Begin
   Inc (Prog^.SelectedBackgroundColor);
   If (Prog^.SelectedBackgroundColor>7) then Prog^.SelectedBackgroundColor:= 0;
  End;

  108, 76: {l}
  Begin
   If (Prog^.SelectedTextColor=0) then Prog^.SelectedTextColor:= 16;
   Dec (Prog^.SelectedTextColor);
  End;

  135: {‡}
  Begin
   Inc (Prog^.SelectedTextColor);
   If (Prog^.SelectedTextColor>15) then Prog^.SelectedTextColor:= 0;
  End;

  107, 75: {k}
  Begin
   Prog^.SelectedBackgroundColor:= Black;
   Prog^.SelectedTextColor:= LightGray;
  End;
 End;
End;

Begin
End.