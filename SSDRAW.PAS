Unit SSDraw;

Interface

Uses
 Crt, SSType, SSConv, SSInt, GeneralDrawing;

Procedure DrawValues (Prog : TProgPtr);
Procedure DrawProgram (Prog : TProgPtr);

Implementation

{*
 * DrawTable
 *
 * Arguments
 *  Prog : TProgPtr - A pointer to the main program's data structure.
 *
 *  Draws the layout table, the numbers and the letters.
 *}
Procedure DrawTable (Prog : TProgPtr);
Var
 X, Y, FG, BG : Byte;
 PreviousSize : Integer;
Begin
 HLine ('Í', 1, 2, 80, LightGray, Black);
 VLine ('º', 3, 1, 24, LightGray, Black);
 PutChar ('Î', 3, 2, LightGray, Black);

 PutText ('SS', TextLeft, 1, 1, Prog^.SelectedTextColor, Prog^.SelectedBackgroundColor);

 PreviousSize:= 1;
 For Y:=1+Prog^.ScrollLine to LinesMaximum do
 Begin
  If (Y=Prog^.CurrentLine) then
  Begin
   FG:= Black;
   BG:= LightGray;
  End
  Else
  Begin
   FG:= LightGray;
   BG:= Black;
  End;
  For X:=2+PreviousSize to PreviousSize+Prog^.LineDimension[Y]+1 do
  Begin
   PutText ('  ', TextLeft, 1, X, FG, BG);
  End;
  PutText (itos (Y), TextRight, 3, 2+PreviousSize, FG, BG);
  PreviousSize:= PreviousSize+Prog^.LineDimension[Y];
 End;

 PreviousSize:= 1;
 For X:=1+Prog^.ScrollColumn to ColumnsMaximum do
 Begin
  If (X=Prog^.CurrentColumn) then
  Begin
   FG:= Black;
   BG:= LightGray;
  End
  Else
  Begin
   FG:= LightGray;
   BG:= Black;
  End;
  For Y:=3+PreviousSize to 3+PreviousSize+Prog^.ColumnDimension[X] do
  Begin
   If (Y<>3+PreviousSize+Prog^.ColumnDimension[X] div 2) then
   Begin
    PutChar (' ', Y, 1, FG, BG);
   End;
  End;
  PutText (chr (X+64), TextCenter, 3+PreviousSize+
           Prog^.ColumnDimension[X] div 2, 1, FG, BG);
  PreviousSize:= PreviousSize+Prog^.ColumnDimension[X];
 End;
End;

{*
 * DrawValues
 *
 * Arguments
 *  Prog : TProgPtr - A pointer to the main program's data structure.
 *
 *  Draws the various cells values, evaluating them along the way.
 *}
Procedure DrawValues (Prog : TProgPtr);
Var
 FG, BG        : Byte;
 TextX         : Integer;
 A, B, X, Y    : Integer;
 PreviousSizeX : Integer;
 PreviousSizeY : Integer;
Begin
 {First we draw the background}
 PreviousSizeY:= 1;
 For Y:=1+Prog^.ScrollLine to LinesMaximum do
 Begin
  PreviousSizeX:= 1;
  For X:=1+Prog^.ScrollColumn to ColumnsMaximum do
  Begin
   FG:= Prog^.Cell[Y, X].ForegroundColor;
   BG:= Prog^.Cell[Y, X].BackgroundColor;
   If (X=Prog^.CurrentColumn) and (Y=Prog^.CurrentLine) then
   Begin
    FG:= CellForegroundSelected;
    BG:= CellBackgroundSelected;
   End;
   For B:=0 to Prog^.LineDimension[Y]-1 do
   Begin
    For A:=0 to Prog^.ColumnDimension[X]-1 do
    Begin
     PutChar (' ', 3+PreviousSizeX+A, 2+PreviousSizeY+B, FG, BG);
    End;
   End;
   PreviousSizeX:= PreviousSizeX+Prog^.ColumnDimension[X];
  End;
  PreviousSizeY:= PreviousSizeY+Prog^.LineDimension[Y];
 End;

 {Now we draw the actual values}
 PreviousSizeY:= 1;
 For Y:=1+Prog^.ScrollLine to LinesMaximum do
 Begin
  PreviousSizeX:= 1;
  For X:=1+Prog^.ScrollColumn to ColumnsMaximum do
  Begin
   FG:= Prog^.Cell[Y, X].ForegroundColor;
   BG:= Prog^.Cell[Y, X].BackgroundColor;
   If (X=Prog^.CurrentColumn) and (Y=Prog^.CurrentLine) then
   Begin
    FG:= CellForegroundSelected;
    BG:= CellBackgroundSelected;
   End;
   {If the values are expressions, they are evaluated}
   Prog^.Cell[Y, X].RValue:= stor (SolveExpression (Prog^.Cell[Y, X].Value));

   TextX:= 3+PreviousSizeX;
   Case Prog^.Cell[Y, X].TextAlignment of
    TextRight:  TextX:= TextX+Prog^.ColumnDimension[X];
    TextCenter: TextX:= TextX+Prog^.ColumnDimension[X] div 2;
   End;
   PutText (TakeSign (SolveExpression (Prog^.Cell[Y, X].Value)),
            Prog^.Cell[Y, X].TextAlignment, TextX, 2+PreviousSizeY, FG, BG);

   PreviousSizeX:= PreviousSizeX+Prog^.ColumnDimension[X];
  End;
  PreviousSizeY:= PreviousSizeY+Prog^.LineDimension[Y];
 End;
End;

{*
 * DrawCL
 *
 * Arguments
 *  Prog : TProgPtr - A pointer to the main program's data structure.
 *
 *  Draws the command line (namely the cells values).
 *}
Procedure DrawCL (Prog : TProgPtr);
Begin
 TextColor (Black);
 Gotoxy (1, 25);
 ClrEol;
 HLine (' ', 1, 25, 80, Black, Black);
 If (Prog^.Cell[Prog^.CurrentLine, Prog^.CurrentColumn].Value<>'') then
 Begin
  TextColor (LightGray);
  Write (Prog^.Cell[Prog^.CurrentLine, Prog^.CurrentColumn].Value);
 End;
End;

{*
 * DrawProgram
 *
 * Arguments
 *  Prog : TProgPtr - A pointer to the main program's data structure.
 *
 *  Draws everything.
 *}
Procedure DrawProgram (Prog : TProgPtr);
Begin
 ClearBuffer;
 DrawValues (Prog);
 DrawTable (Prog);
 DrawCL (Prog);
 PutScreen;
 GotoXY (80, 25);
End;

Begin
End.