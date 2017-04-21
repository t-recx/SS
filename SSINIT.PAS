Unit SSInit;

Interface

Uses
 Crt, SSType, SSDraw, SSInt, GeneralDrawing;

Procedure InitProgram (Prog : TProgPtr);

Implementation

{*
 * InitProgram
 *
 * Arguments
 *  Prog : TProgPtr    - A pointer to the main program's data structure.
 *
 *  Initializes Prog's variables.
 *}
Procedure InitProgram (Prog : TProgPtr);
Var
 X, Y : Integer;
Begin
 IP:= Prog;
 With Prog^ do
 Begin
  OCX:= 1;
  OCY:= 1;
  SelectedTextColor:= Lightgray;
  SelectedBackgroundColor:= Black;

  ScrollLine:= 0;
  ScrollColumn:= 0;

  CurrentLine:= 1;
  CurrentColumn:= 1;

  For Y:=1 to LinesMaximum do LineDimension[Y]:= 1;
  For X:=1 to ColumnsMaximum do ColumnDimension[X]:= 10;

  For Y:=1 to LinesMaximum do
  Begin
   For X:=1 to ColumnsMaximum do
   Begin
    Cell[Y, X].Value:= '';
    Cell[Y, X].RValue:= 0;
    Cell[Y, X].TextAlignment:= TextLeft;
    Cell[Y, X].ForegroundColor:= LightGray;
    Cell[Y, X].BackgroundColor:= Black;
   End;
  End;
 End;
End;

Begin
End.