Unit SSGraph;

Interface

Uses
 Crt, Graph, SSType, SSConv, SSInt;

Procedure MakeGraph (Prog : TProgPtr; LSX, LSY, LFX, LFY, VSX, VSY, VFX, VFY, GraphType : Integer);

Const
 GTLines = 0;
 GTBars  = 1;

Implementation

{*
 * MakeGraph
 *
 * Arguments
 *  Prog : TProgPtr     - A pointer to the main program's data structure.
 *  LSX, LSY : Integer  - The first cell's coordinates for the labels.
 *  LFX, LFY : Integer  - The last cell's coordinates for the labels.
 *  VSX, VSY : Integer  - The first cell's coordinates for the values.
 *  VFX, VFY : Integer  - The last cell's coordinates for the values.
 *  GraphType : Integer - The type of graph (GTLines or GTBars).
 *
 *  Creates a unidimensional line graphic with information from the cell's
 * matrix formed by Cell[VSY, VSX] to Cell[VFY, VFX].
 *}
Procedure MakeGraph (Prog : TProgPtr; LSX, LSY, LFX, LFY, VSX, VSY, VFX, VFY, GraphType : Integer);
Var
 Z                  : Real;
 MinValue, MaxValue : Real;
 Gd, Gm             : Integer;
 PX, PY, X, Y       : Integer;
 ZeroX, ZeroY       : Integer;
Begin
 MinValue:= Prog^.Cell[VSY, VSX].RValue;
 MaxValue:= Prog^.Cell[VSY, VSX].RValue;
 For Y:=VSY to VFY do
 Begin
  For X:=VSX to VFX do
  Begin
   If (MinValue>Prog^.Cell[Y, X].RValue) then MinValue:= Prog^.Cell[Y, X].RValue;
   If (MaxValue<Prog^.Cell[Y, X].RValue) then MaxValue:= Prog^.Cell[Y, X].RValue;
  End;
 End;

 Gd:= Detect;
 InitGraph (Gd, Gm, 'c:\progra~1\tp\bgi');
 If (GraphResult <> grOk) then Exit;

 ZeroX:= LSX;
 ZeroY:= LSY;
 For Y:=LSY to LFY do
 Begin
  For X:=LSX to LFX do
  Begin
   If (TakeSign (SolveExpression (Prog^.Cell[Y, X].Value))='0') then
   Begin
    ZeroX:= X;
    ZeroY:= Y;
   End;
  End;
 End;

{
 Line (GetMaxX div 10, GetMaxY div 10, GetMaxX div 10, GetMaxY - GetMaxY div 10);
 OutTextXY (1, GetMaxY div 10, rtos (MaxValue));
 OutTextXY (1, GetMaxY - GetMaxY div 10, rtos (MinValue));
 Line (GetMaxX div 10, GetMaxY - GetMaxY div 10, GetMaxX - GetMaxX div 10, GetMaxY - GetMaxY div 10);
}
 If (MinValue<=0) then
  Line (GetMaxX div 10, Round ((GetMaxY - GetMaxY div 10)+MinValue*((GetMaxY - GetMaxY div 5)/
        (MaxValue-MinValue))), GetMaxX - GetMaxX div 10, Round ((GetMaxY - GetMaxY div 10)+MinValue*
        ((GetMaxY - GetMaxY div 5)/(MaxValue-MinValue))))
 Else
  Line (GetMaxX div 10, GetMaxY - GetMaxY div 10, GetMaxX - GetMaxX div 10, GetMaxY - GetMaxY div 10);

 Z:= MaxValue-MinValue;
 If (Z=0) then Z:=1;
 For Y:=LSY to LFY do
 Begin
  For X:=LSX to LFX do
  Begin
   SetTextJustify (CenterText, CenterText);

   If (MinValue<=0) then
    OutTextXY ((GetMaxX div 10)+(X-LSX+Y-LSY)*((GetMaxX - GetMaxX div 5) div (LFX-LSX+LFY-LSY)),
               Round ((GetMaxY - GetMaxY div 10)+MinValue*((GetMaxY - GetMaxY div 5)/(MaxValue-MinValue)))+10,
               TakeSign (SolveExpression (Prog^.Cell[Y, X].Value)))
   Else
    OutTextXY ((GetMaxX div 10)+(X-LSX+Y-LSY)*((GetMaxX - GetMaxX div 5) div (LFX-LSX+LFY-LSY)),
               GetMaxY-GetMaxY div 10 + 10,
               TakeSign (SolveExpression (Prog^.Cell[Y, X].Value)));

   If (X=ZeroX) and (Y=ZeroY) then
   Begin
    Line ((GetMaxX div 10)+(X-LSX+Y-LSY)*((GetMaxX - GetMaxX div 5) div (LFX-LSX+LFY-LSY)), GetMaxY div 10,
          (GetMaxX div 10)+(X-LSX+Y-LSY)*((GetMaxX - GetMaxX div 5) div (LFX-LSX+LFY-LSY)), GetMaxY - GetMaxY div 10);
    For PY:=VSY to VFY do
    Begin
     For PX:=VSX to VFX do
     Begin
      SetTextJustify (RightText, CenterText);
      OutTextXY ((GetMaxX div 10)+(ZeroX-LSX+ZeroY-LSY)*((GetMaxX - GetMaxX div 5) div (LFX-LSX+LFY-LSY)),
                 Round ((GetMaxY - GetMaxY div 10)-(Prog^.Cell[PY, PX].RValue-MinValue)*
                 ((GetMaxY - GetMaxY div 5)/Z)), rtos (Prog^.Cell[PY, PX].RValue));
     End;
    End;
   End;
  End;
 End;

 PX:= GetMaxX div 10;
 PY:= Round ((GetMaxY - GetMaxY div 10)-
             (Prog^.Cell[VSY, VSX].RValue-MinValue)*
             ((GetMaxY - GetMaxY div 5) / Z));
 For Y:=VSY to VFY do
 Begin
  For X:=VSX to VFX do
  Begin
   If (GraphType=GTBars) then
    Bar3D((GetMaxX div 10)+(X-VSX+Y-VSY)*((GetMaxX - GetMaxX div 5) div (VFX-VSX+VFY-VSY)),
          GetMaxY - GetMaxY div 10,
          (GetMaxX div 10)+(X-VSX+Y-VSY)*((GetMaxX - GetMaxX div 5) div (VFX-VSX+VFY-VSY))+20,
          Round((GetMaxY - GetMaxY div 10)-
          (Prog^.Cell[Y, X].RValue-MinValue)*
          ((GetMaxY - GetMaxY div 5) / Z)), 20 div 4, TopOn)
   Else
   Begin
    Line (PX, PY, (GetMaxX div 10)+(X-VSX+Y-VSY)*((GetMaxX - GetMaxX div 5) div (VFX-VSX+VFY-VSY)),
          Round((GetMaxY - GetMaxY div 10)-
          (Prog^.Cell[Y, X].RValue-MinValue)*
          ((GetMaxY - GetMaxY div 5) / Z)));

    PX:= (GetMaxX div 10)+(X-VSX+Y-VSY)*((GetMaxX - GetMaxX div 5) div (VFX-VSX+VFY-VSY));
    PY:= Round ((GetMaxY - GetMaxY div 10)-
                (Prog^.Cell[Y, X].RValue-MinValue)*
                ((GetMaxY - GetMaxY div 5) / Z));
   End;
  End;
 End;
 ReadKey;
 CloseGraph;
End;

Begin
End.