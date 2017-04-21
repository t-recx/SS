Unit SSConv;

Interface

Uses
 Crt, SSTrans, GeneralDrawing;

Function itos (I : Integer) : String;
Function stoi (S : String) : Integer;

Function rtos (R : Real) : String;
Function rtosRounded (R : Real; n1, n2 : Integer) : String;
Function stor (S : String) : Real;

Function LowCase (C : Char) : Char;
Function UpCaseString (S : String) : String;
Function LowCaseString (S : String) : String;

Function ColorToNumber (S : String) : Byte;

Function GetLine (S : String) : Integer;
Function GetColumn (S : String) : Integer;
Function GetAlignment (S : String) : Byte;

Function GetGraphicType (S : String) : Byte;

Function TakeSign (S : String) : String;

Implementation

{*
 * itos
 *
 *  Converts an integer into a string.
 *}
Function itos (I : Integer) : String;
Var
 S : String;
Begin
 Str (I, S);
 itos:= S;
End;

{*
 * stoi
 *
 *  Converts a string to an integer.
 *}
Function stoi (S : String) : Integer;
Var
 I, Code : Integer;
Begin
 Val (S, I, Code);
 stoi:= I;
End;

{*
 * rtos
 *
 *  Converts a real to a string.
 *}
Function rtos (R : Real) : String;
Var
 S         : String;
 sc, dc, C : Integer;
Begin
 dc:= 0;
 Str (R:10:10, S);
 rtos:= S;
 For C:=1 to Length (S) do
 Begin
  If (S[C]='.') then
  Begin
   sc:= 0;
   For C:=C+1 to Length (S) do
   Begin
    Inc (sc);
    If (stoi(S[C])>0) then dc:= sc;
   End;
   Break;
  End;
 End;

 Str (R:dc:dc, S);
 rtos:= S;
End;

Function rtosRounded (R : Real; n1, n2 : Integer) : String;
Var
 S         : String;
 sc, dc, C : Integer;
Begin
 dc:= 0;
 Str (R:n1:n2, S);
 rtosRounded:= S;
 For C:=1 to Length (S) do
 Begin
  If (S[C]='.') then
  Begin
   sc:= 0;
   For C:=C+1 to Length (S) do
   Begin
    Inc (sc);
    If (stoi(S[C])>0) then dc:= sc;
   End;
   Break;
  End;
 End;
 Str (R:dc:dc, S);
 rtosRounded:= S;
End;


{*
 * stor
 *
 *  Converts a string to a real.
 *}
Function stor (S : String) : Real;
Var
 R    : Real;
 Code : Integer;
Begin
 Val (S, R, Code);
 stor:= R;
End;

{*
 * UpCaseString
 *
 *  Returns the string S in all uppercase.
 *}
Function UpCaseString (S : String) : String;
Var
 C : Integer;
Begin
 For C:=1 to Length (S) do
 Begin
  S[C]:= UpCase (S[C]);
 End;
 UpCaseString:= S;
End;

{*
 * LowCase
 *
 *  Converts a character into lowercase.
 *}
Function LowCase (C : Char) : Char;
Begin
 If (C in ['A'..'Z']) then LowCase:= Chr (Ord (C)+32)
 Else LowCase:= C;
End;

{*
 * LowCaseString
 *
 *  Returns the string S in all lowercase.
 *}
Function LowCaseString (S : String) : String;
Var
 C : Integer;
Begin
 For C:=1 to Length (S) do
 Begin
  S[C]:= LowCase (S[C]);
 End;
 LowCaseString:= S;
End;

{*
 * ColorToNumber
 *
 * Arguments
 *  S : String - A color name.
 *
 *  Converts a color name (in the form of the string S) into a number
 * (according to the Crt Unit color constants) and returns it. If there's
 * no match it will return LightGray.
 *}
Function ColorToNumber (S : String) : Byte;
Const
 Color : Array [0..15] of String =
 ('Black', 'Blue', 'Green', 'Cyan', 'Red', 'Magenta', 'Brown', 'LightGray',
  'DarkGray', 'LightBlue', 'LightGreen', 'LightCyan', 'LightRed',
  'LightMagenta', 'Yellow', 'White');
Var
 C : Integer;
Begin
 For C:=0 to 15 do
 Begin
  If (UpCaseString (GTS (Color[C]))=UpCaseString (S)) then
  Begin
   ColorToNumber:= C;
   Exit;
  End;
 End;
 ColorToNumber:= LightGray;
End;

{*
 * GetAlignment
 *
 * Arguments
 *  S : String - A text alignment.
 *
 *  Converts a string with a text alignment into the corresponding
 * byte constant, defined in the GeneralDrawing Unit. If there's no
 * match, it will return TextLeft.
 *}
Function GetAlignment (S : String) : Byte;
Begin
 If (UpCaseString (S)=GTS ('RIGHT')) then GetAlignment:= TextRight
 Else If (UpCaseString (S)=GTS ('CENTER')) or (UpCaseString (S)=GTS ('CENTRE')) then GetAlignment:= TextCenter
 Else GetAlignment:= TextLeft;
End;

{*
 * GetColumn
 *
 * Arguments
 *  S : String - A cell's name.
 *
 *  Extracts the column out of a cell's name and returns it in the
 * form of an integer.
 *}
Function GetColumn (S : String) : Integer;
Begin
 GetColumn:= Ord (UpCase (S[1]))-64;
End;

{*
 * GetLine
 *
 * Arguments
 *  S : String - A cell's name.
 *
 *  Extracts the line out of a cell's name and returns it in the
 * form of an integer.
 *}
Function GetLine (S : String) : Integer;
Begin
 GetLine:= stoi (Copy (S, 2, 2));
End;

Function GetGraphicType (S : String) : Byte;
Const
 GTLines = 0;
 GTBars  = 1;
Begin
 If (LowCaseString (S)=GTS ('bars')) or (LowCaseString (S)=GTS ('bar'))
 then GetGraphicType:= GTBars Else GetGraphicType:= GTLines;
End;

{*
 * TakeSign
 *
 * Arguments
 *  S : String - A signed number.
 *
 *  Removes the plus sign out of a number, if there is one.
 *}
Function TakeSign (S : String) : String;
Begin
 If (S[1]='+') then TakeSign:= Copy (S, 2, Length (S))
 Else TakeSign:= S;
End;

Begin
End.