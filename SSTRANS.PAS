Unit SSTrans;

Interface

Uses
 Crt, Dos, GeneralDrawing;

Function GTS (Sentence : String) : String;
Function SelectTranslation : String;

Implementation

Var
 CurrentTranslationFile : String;

Function Space (Number : Integer) : String;
Var
 C : Integer;
 S : String;
Begin
 S:= '';
 For C:=0 to Number do S:= S + ' ';
 Space:= S;
End;

Function DoMenu (X, Y : Integer; Option : Array of String) : Integer;
Var
 Key                : Char;
 FG, BG, Selected   : Integer;
 C, MaxChr, MaxOpts : Integer;
Begin
 FG:= LightGray;
 BG:= Black;

 MaxChr:= 0;
 Selected:= 0;

 C:= 0;
 Repeat
  If (Length (Option[C])>MaxChr) then MaxChr:= Length (Option[C]);
  Inc (C);
 Until (Option[C]='');
 MaxOpts:= C-1;
 Dec (MaxChr);

 If (X<=0) then X:= 80 div 2-(MaxChr+2) div 2;
 If (Y<=0) then Y:= 25 div 2-(MaxOpts+2) div 2;

 Repeat
  Rect (X, Y, MaxChr+2, MaxOpts+2, LightGray, Black);
  For C:=0 to MaxOpts do
  Begin
   If (C=Selected) then
   Begin
    FG:= White;
    BG:= Blue;
   End
   Else
   Begin
    FG:= LightGray;
    BG:= Black;
   End;
   PutText (Space (MaxChr), TextLeft, X+1, Y+1+C, FG, BG);
   PutText (Option[C], TextLeft, X+1, Y+1+C, FG, BG);
  End;

  PutScreen;

  Key:= ReadKey;
  Case Key of
   Chr (72):
   Begin
    Dec (Selected);
    If (Selected<0) then Selected:= MaxOpts;
   End;
   Chr (80): Inc (Selected);
  End;
  If (Selected>MaxOpts) then Selected:= 0;
 Until (Key=Chr(27)) or (Key=Chr(13));

 DoMenu:= Selected;
End;

Function GetTranslatedSentence (TranslationFile, Sentence : String) : String;
Var
 F : Text;
 S : String;
Begin
 If (TranslationFile='') then
 Begin
  GetTranslatedSentence:= Sentence;
  Exit;
 End;
 Assign (F, TranslationFile);
 Reset (F);
 While not (Eof (F)) do
 Begin
  ReadLN (F, S);
  If (S=Sentence) then
  Begin
   ReadLN (F, S);
   GetTranslatedSentence:= S;
   Close (F);
   Exit;
  End;
 End;
 Close (F);
 GetTranslatedSentence:= Sentence;
End;

Function GTS (Sentence : String) : String;
Begin
 GTS:= GetTranslatedSentence (CurrentTranslationFile, Sentence);
End;

Function GetHeader (FileName : String) : String;
Var
 F : Text;
 S : String;
Begin
 Assign (F, FileName);
 Reset (F);
 ReadLN (F, S);
 GetHeader:= S;
 Close (F);
End;

Function SelectTranslation : String;
Var
 C       : Integer;
 DirInfo : SearchRec;
 FILEST  : Array [1..10] of String;
 NAMEST  : Array [1..10] of String;
Begin
 For C:=1 to 10 do
 Begin
  FILEST[C]:= '';
  NAMEST[C]:= '';
 End;
 C:= 1;
 FindFirst('*.TRL', Archive, DirInfo);
 While (DosError = 0) do
 Begin
  If (C<10) then
  Begin
   FILEST[C]:= DirInfo.Name;
   NAMEST[C]:= GetHeader (DirInfo.Name);
   Inc (C);
  End;
  FindNext (DirInfo);
 End;
 DosError:= 0;
 CurrentTranslationFile:= FILEST[DoMenu (-1,-1,NAMEST)+1];
End;

Begin
End.