Unit SSType;

Interface

Uses
 Crt;

Const
 ColumnsMaximum = 15;
 LinesMaximum   = 25;

 CellForegroundSelected = White;
 CellBackgroundSelected = Blue;

Type
 TCell = record
  Value           : String[80];
  RValue          : Real;
  TextAlignment   : Byte;
  ForegroundColor : Byte;
  BackgroundColor : Byte;
 End;

 TProg = record
  OCX, OCY                : Byte;
  ScrollLine              : Byte;
  ScrollColumn            : Byte;
  CurrentLine             : Byte;
  CurrentColumn           : Byte;
  SelectedTextColor       : Byte;
  SelectedBackgroundColor : Byte;
  LineDimension           : Array [1..LinesMaximum] of Byte;
  ColumnDimension         : Array [1..ColumnsMaximum] of Byte;
  Cell                    : Array [1..LinesMaximum, 1..ColumnsMaximum] of TCell;
 End;

 TProgPtr = ^TProg;

Implementation

Begin
End.