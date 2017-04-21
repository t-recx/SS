Unit GeneralDrawing;

Interface

Uses
 Crt, Printer;

Procedure PutChar (Symbol : Char; X, Y, FG, BG : Integer);
Procedure PutText (Text : String; Alignment, X, Y, FG, BG : Integer);
Procedure PutScreen;

Procedure HLine (c : Char; x, y, w, fg, bg : Integer);
Procedure VLine (c : Char; x, y, h, fg, bg : Integer);
Procedure Rect (x, y, w, h, fg, bg : Integer);

Function  GetText (S: String; X, Y, FG, BG : Integer) : String;

Procedure ClearBuffer;
Procedure ClearScreen;

Procedure PrintScreen;

Const
 None       = -1;

 TextLeft   = 0;
 TextCenter = 1;
 TextRight  = 2;

Implementation

Type
 TScreen = Record
  Symbol          : Char;
  ForegroundColor : Byte;
  BackgroundColor : Byte;
 End;

Var
 Screen       : Array [1..25, 1..80] of TScreen;
 BufferScreen : Array [1..25, 1..80] of TScreen;

Procedure PutChar (Symbol : Char; X, Y, FG, BG : Integer);
Begin
 If not (X in [1..80]) or not (Y in [1..25]) then Exit;
 BufferScreen[Y, X].Symbol:= Symbol;
 If (FG<>None) then BufferScreen[y, x].ForegroundColor:= FG;
 If (BG<>None) then BufferScreen[y, x].BackgroundColor:= BG;
End;

Procedure PutText (Text : String; Alignment, X, Y, FG, BG : Integer);
Var
 C : Integer;
Begin
 Case Alignment of
  TextRight : X:= X-Length (Text);
  TextCenter: X:= X-Length (Text) div 2;
 End;

 For C:=1 to Length (Text) do
 Begin
  PutChar (Text[C], X+C-1, Y, FG, BG);
 End;
End;

Procedure ClearBuffer;
Var
 X, Y : Integer;
Begin;
 For Y:=1 to 25 do
 Begin
  For X:=1 to 80 do
  Begin
   PutChar (' ', X, Y, LightGray, Black);
  End;
 End;
End;

Procedure ClearScreen;
Begin
 ClearBuffer;
 PutScreen;
End;

Procedure PutScreen;
Var
 X, Y : Integer;
Begin
 For Y:=1 to 25 do
 Begin
  For X:=1 to 80 do
  Begin
   If (BufferScreen[Y, X].Symbol<>Screen[Y, X].Symbol)                   or
      (BufferScreen[Y, X].ForegroundColor<>Screen[Y, X].ForegroundColor) or
      (BufferScreen[Y, X].BackgroundColor<>Screen[Y, X].BackgroundColor) then
   Begin
    Screen[Y, X].Symbol:= BufferScreen[Y, X].Symbol;
    Screen[Y, X].ForegroundColor:= BufferScreen[Y, X].ForegroundColor;
    Screen[Y, X].BackgroundColor:= BufferScreen[Y, X].BackgroundColor;
    If not ((X=80) and (Y=25)) then
    Begin
     With Screen[Y, X] do
     Begin
      GotoXY (X, Y);
      TextBackground (BackgroundColor);
      TextColor (ForegroundColor);
      Write (Symbol);
      NormVideo;
     End;
    End;
   End;
  End;
 End;
End;

Function GetText (S : String; X, Y, FG, BG : Integer) : String;
Var
 Key : Char;
 C   : Integer;
Begin
{ S:= '';}

 For C:=1 to Length (S) do
 Begin
  PutChar (S[C], X+C-1, Y, FG, BG);
 End;
 PutScreen;

 GotoXY (X+Length(S), Y);

 Repeat
  If (KeyPressed) then
  Begin
   Key:= ReadKey;

   Case Ord (Key) of
    8:
    If (Length (S)>0) then
    Begin
     PutChar (' ', X+Length (S)-1, Y, FG, BG);
     Delete (S, Length (S), 1);
    End;
    32..168: S:= S+Key;
   End;

   For C:=1 to Length (S) do
   Begin
    PutChar (S[C], X+C-1, Y, FG, BG);
   End;
   PutScreen;

   GotoXY (X+Length(S), Y);
  End;
 Until (Key=Chr (13));

 GetText:= S;
End;

Procedure PrintScreen;
Var
 X, Y : Integer;
Begin
 For Y:=1 to 25 do
 Begin
  For X:=1 to 80 do
  Begin
   Write (Lst, Screen[Y, X].Symbol);
  End;
  WriteLn (Lst, '');
 End;
End;

Procedure VLine (C : Char; X, Y, H, FG, BG : Integer);
Var
 A : Integer;
Begin
 For A:=0 to H-1 do
 Begin
  PutChar (C, X, Y+A, FG, BG);
 End;
End;

Procedure HLine (C : Char; X, Y, W, FG, BG : Integer);
Var
 A : Integer;
Begin
 For A:=0 to W-1 do
 Begin
  PutChar (C, X+A, Y, FG, BG);
 End;
End;

Procedure Rect (X, Y, W, H, FG, BG : Integer);
Var
 C : Integer;
Begin

 For C:=0 to H do
 Begin
  HLine (' ', X, Y+C, W, FG, BG);
 End;
 VLine ('º', X, Y, H, FG, BG);
 HLine ('Í', X, Y, W, FG, BG);
 VLine ('º', X+W, Y, H, FG, BG);
 HLine ('Í', X, Y+H, W, FG, BG);

 PutChar ('É', X, Y, FG, BG);
 PutChar ('»', X+W, Y, FG, BG);
 PutChar ('È', X, Y+H, FG, BG);
 PutChar ('¼', X+W, Y+H, FG, BG);
End;

Begin
End.