{$M 65520, 0, 655360}
Program Spreadsheet;

Uses
 Crt, SSType, SSInit, SSLogic, SSFile, SSDraw;

Procedure ProgramLoop;
Var
 Prog         : TProgPtr;
 EndOfProgram : Boolean;
Begin
 New (Prog);
 InitProgram (Prog);

 If (ParamCount>=1) then FileLoad (Prog, ParamStr(1));

 Repeat
  DrawProgram (Prog);
  EndOfProgram:= GetKey (Prog);
 Until (EndOfProgram);

 Dispose (Prog);
 ClrScr;
End;

Begin
 ProgramLoop;
End.