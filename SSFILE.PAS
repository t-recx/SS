Unit SSFile;

Interface

Uses
 Crt, Dos, SSType, SSTrans;

Function FileSave (Prog : TProgPtr; FileName : String) : String;
Function FileLoad (Prog : TProgPtr; FileName : String) : String;

Implementation

{*
 * FileLoad
 *
 * Arguments
 *  Prog : TProgPtr   - A pointer to the main program's data structure.
 *  FileName : String - The name of the file that is to be loaded.
 *
 *  Opens and reads FileName and assigns all it's data into the variables
 * in Prog.
 *}
Function FileLoad (Prog : TProgPtr; FileName : String) : String;
Var
 F    : Text;
 X, Y : Integer;
Begin
 FileLoad:= GTS ('File loaded sucessfully.');
 If (FileName='') then
 Begin
  Exit;
 End;

 Assign (F, FileName);

 Case DosError of
  2:  FileLoad:= GTS ('File not found.');
  3:  FileLoad:= GTS ('Path not found.');
  5:  FileLoad:= GTS ('Access denied.');
  6:  FileLoad:= GTS ('Invalid handle.');
  8:  FileLoad:= GTS ('Not enough memory.');
  10: FileLoad:= GTS ('Invalid environment.');
  11: FileLoad:= GTS ('Invalid format.');
  18: FileLoad:= GTS ('No more files.');
 End;

 If (DosError>0) then Exit;

 {$I-}
 Reset (F);
 {$I+}

 If (IOResult<>0) then
 Begin
  FileLoad:= GTS ('File not found.');
  Exit;
 End;

 For Y:=1 to LinesMaximum do
 Begin
  Readln (F, Prog^.LineDimension[Y]);
 End;

 For X:=1 to ColumnsMaximum do
 Begin
  Readln (F, Prog^.ColumnDimension[X]);
 End;

 For Y:=1 to LinesMaximum do
 Begin
  For X:=1 to ColumnsMaximum do
  Begin
   Readln (F, Prog^.Cell[Y, X].Value);
   Readln (F, Prog^.Cell[Y, X].TextAlignment);
   Readln (F, Prog^.Cell[Y, X].ForegroundColor);
   Readln (F, Prog^.Cell[Y, X].BackgroundColor);
  End;
 End;

 Close (F);
End;

{*
 * FileSave
 *
 * Arguments
 *  Prog : TProgPtr   - A pointer to the main program's data structure.
 *  FileName : String - The name of the file that is to be loaded.
 *
 *  Opens and clears (if it already exists) FileName and writes all the
 * information about the current document into the file.
 *}
Function FileSave (Prog : TProgPtr; FileName : String) : String;
Var
 F    : Text;
 X, Y : Integer;
Begin
 FileSave:= GTS ('File saved sucessfully.');
 If (FileName='') then
 Begin
  Exit;
 End;

 Assign (F, FileName);

 Case DosError of
  2:  FileSave:= GTS ('File not found.');
  3:  FileSave:= GTS ('Path not found.');
  5:  FileSave:= GTS ('Access denied.');
  6:  FileSave:= GTS ('Invalid handle.');
  8:  FileSave:= GTS ('Not enough memory.');
  10: FileSave:= GTS ('Invalid environment.');
  11: FileSave:= GTS ('Invalid format.');
  18: FileSave:= GTS ('No more files.');
 End;

 If (DosError>0) then Exit;

 Rewrite (F);

 For Y:=1 to LinesMaximum do
 Begin
  Writeln (F, Prog^.LineDimension[Y]);
 End;

 For X:=1 to ColumnsMaximum do
 Begin
  Writeln (F, Prog^.ColumnDimension[X]);
 End;

 For Y:=1 to LinesMaximum do
 Begin
  For X:=1 to ColumnsMaximum do
  Begin
   Writeln (F, Prog^.Cell[Y, X].Value);
   Writeln (F, Prog^.Cell[Y, X].TextAlignment);
   Writeln (F, Prog^.Cell[Y, X].ForegroundColor);
   Writeln (F, Prog^.Cell[Y, X].BackgroundColor);
  End;
 End;

 Close (F);
End;

Begin
End.