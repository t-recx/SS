Unit SSInt;

Interface

Uses
 Crt, SSConv, SSType, SSTrans;

Function Expression (st : String) : String;
Function SolveExpression (s : String) : String;

Var
 IP : TProgPtr;

Implementation

Procedure Error (S : String);
Begin
End;

Function IsNumber (C : Char) : Boolean;
Begin
 If (C in ['0'..'9']) or (C='.') then IsNumber:= True
 Else IsNumber:= False;
End;

Function IsLetter (C : Char) : Boolean;
Begin
 If (Upcase (C) in ['A'..'Z']) then IsLetter:= True
 Else IsLetter:= False;
End;

Function IsAlphanumeric (C : Char) : Boolean;
Begin
 If (IsNumber (C)=True) or (IsLetter (C)=True) then IsAlphanumeric:= True
 Else IsAlphanumeric:= False;
End;

{*
 * Replace
 *
 *  Replaces all occurances of Element on the string st with Replacement.
 *}
Function Replace (st, Element, Replacement : String) : String;
Var
 C : Integer;
Begin
 Repeat
  C:= Pos (Element, st);
  If (C>0) then
  Begin
   Delete (st, C, Length (Element));
   Insert (Replacement, st, C);
  End;
 Until (C=0);
 Replace:= st;
End;

Function DeleteSpaces (st : String) : String;
Begin
 DeleteSpaces:= Replace (st, ' ', '');
End;

Function MoreOrLess (Op1, Op2 : Char) : Char;
Begin
 If (Op1=Op2) then MoreOrLess:= '+'
 Else MoreOrLess:= '-';
End;

{*
 * Simplify
 *
 *  Simplifies the string st, removing unnecessary operators. For
 * example: Simplify ('+4+-2') would return '+4-2'.
 *}
Function Simplify (st : String) : String;
Var
 C : Integer;
Begin
 For C:=1 to Length (st) do
 Begin
  If (st[C] in ['+', '-']) then
  Begin
   If (st[C+1] in ['+', '-']) then
   Begin
    st[C]:= MoreOrLess (st[C], st[C+1]);
    Delete (st, C+1, 1);
    Dec (C);
   End;
  End;
 End;

 Simplify:= st;
End;

{*
 * PutSign
 *
 *  Puts a plus sign before st if its value - converted to a real - is
 * positive. If it's negative returns st untouched.
 *}
Function PutSign (st : String) : String;
Begin
 If (stor (st)>=0) then PutSign:= '+' + st
 Else PutSign:= st;
End;

Function IsVariable (Name : String) : Boolean;
Begin
 IsVariable:= False;
 If (Length (Name)<2) then Exit;

 If (UpCase (Name[1]) in ['A'..'Z']) and (IsNumber (Name[2])=True) then
  IsVariable:= True;
End;

Function GetVariableValue (Name : String) : String;
Var
 IsNeg : Boolean;
Begin
 GetVariableValue:= Name;

 If (Name[1]='-') then
 Begin
  IsNeg:= True;
  Delete (Name, 1, 1);
 End
 Else IsNeg:= False;

 If (Name[1]='+') then Delete (Name, 1, 1);

 If (IsVariable (Name)) then
 Begin
  If (IsNeg) then GetVariableValue:= rtos (-(IP^.Cell[GetLine (Name), GetColumn (Name)].RValue))
  Else GetVariableValue:= rtos (IP^.Cell[GetLine (Name), GetColumn (Name)].RValue);
 End;
End;

Function SolveExpression (S : String) : String;
Begin
 If (s[1]='=') then SolveExpression:= GetVariableValue (Expression (Copy (S, 2, Length (S)-1)))
 Else SolveExpression:= S;
End;

{*
 * GetMatrixValue
 *
 *  Sums all the cell's values from Cell1 to Cell2.
 *}
Function GetMatrixValue (Cell1, Cell2 : String) : String;
Var
 X, Y  : Integer;
 Value : Real;
Begin
 Value:= 0;

 If (Cell1[1] in ['+', '-']) then Delete (Cell1, 1, 1);
 If (Cell2[1] in ['+', '-']) then Delete (Cell2, 1, 1);

 For Y:=GetLine (Cell1) to GetLine (Cell2) do
  For X:=GetColumn (Cell1) to GetColumn (Cell2) do
   Value:= Value+stor (GetVariableValue (Chr (X+64)+itos (Y)));

 GetMatrixValue:= rtos (Value);
End;

{*
 * Calculate
 *
 *  Performs the operation defined by Op on sn1 and sn2, returning the
 * result in the form of a string or '0' if Op is not recognized.
 *}
Function Calculate (Op : Char; sn1, sn2 : String) : String;
Var
 n1, n2 : Real;
Begin
 Calculate:= '0';
 n1:= stor (GetVariableValue (sn1));
 n2:= stor (GetVariableValue (sn2));

 Case Op of
  '+': Calculate:= rtos (n1+n2);
  '-': Calculate:= rtos (n1-n2);
  '*': Calculate:= rtos (n1*n2);
  '/':
  Begin
   If (n2=0) then
   Begin
    Error ('Division by zero (' + rtos(n1) + '/' + rtos(n2) + ')');
    Calculate:= GTS ('Error: Division by zero');
    Exit;
   End;
   Calculate:= rtos (n1/n2);
  End;
  '>': If (n1>n2) then Calculate:= itos (1);
  '<': If (n1<n2) then Calculate:= itos (1);
  '=': If (n1=n2) then Calculate:= itos (1);
  '!': If (n1<>n2) then Calculate:= itos (1);
  '&': If (n1<>0) and (n2<>0) then Calculate:= itos (1);
  '|': If (n1<>0) or (n2<>0) then Calculate:= itos (1);
  ':': Calculate:= GetMatrixValue (sn1, sn2);
  '~': Calculate:= rtosRounded (n1, Round (n2), Round (n2));
 End;
End;

Function GetFirstOperand (st : String; C : Integer) : String;
Var
 N : Integer;
Begin
 N:= 0;
 Repeat
  Dec (C);
  Inc (N);
 Until (IsAlphanumeric (st[C])=False) or (C=1);

 If (C>1) and not (st[C] in ['+', '-']) then
 Begin
  Inc (C);
  Dec (N);
 End;

 GetFirstOperand:= Copy (st, C, N);
End;

Function GetSecondOperand (st : String) : String;
Var
 N : Integer;
Begin
 N:= 0;
 If not (st[1] in ['+', '-']) and (IsAlphanumeric (st[1])=False) then Error ('Unknown identifier');

 Repeat
  Inc (N);
 Until (IsAlphanumeric (st[N+1])=False) or (N=Length (st));

 GetSecondOperand:= Copy (st, 1, N);
End;

{*
 * Occurs
 *
 *  Returns True if any of the characters that compose Substr are present
 * in st or False otherwise.
 *}
Function Occurs (Substr, st : String) : Boolean;
Var
 C : Integer;
Begin
 Occurs:= False;
 For C:=1 to Length (Substr) do
 Begin
  If (Pos (Substr[C], st)<>0) then Occurs:= True;
 End;
End;

{*
 * Operation
 *
 * Arguments
 *  Start : Integer    - The starting character from which the expression will
 *                       be evaluated.
 *  Operators : String - The various operators that are to be solved.
 *  st        : String - The expression.
 *
 *  Evaluates the expression st from character Start, checking and performing
 * the operations defined in Operators and returning the result in form of
 * a string.
 *}
Function Operation (Start : Integer; Operators, st : String) : String;
Var
 C       : Integer;
 Op      : Char;
 Operand : array [1..2] of String;
Begin
 Repeat
  Operand[1]:=''; Operand[2]:='';
  For C:=Start to Length (st) do
  Begin
   If (Occurs (Operators, st[c])) then
   Begin
    Op:= st[C];
    Operand[1]:= GetFirstOperand (Copy (st, 1, C), C);
    Operand[2]:= GetSecondOperand (Copy (st, C+1, Length (st)));
    Delete (st, C-Length (Operand[1]), 1+Length (Operand[1])+Length (Operand[2]));
    Insert (PutSign (Calculate (Op, Operand[1], Operand[2])), st, C-Length (Operand[1]));
    Break;
   End;
  End;
  If (Operand[1]='') or (Operand[2]='') then Break;
 Until (C=Length (st));
 Operation:= st;
End;

{*
 * Solve
 *
 *  Solves the expression st according to the various operators precedence.
 *}
Function Solve (st : String) : String;
Begin
 Solve:= Operation (1, '~',
         Operation (1, '&|',
         Operation (1, '<>=!',
         Operation (2, '+-',
         Operation (1, '*/',
         Operation (1, ':', st))))));
End;

{*
 * IsValidExp
 *
 *  Performs a check on the expression st, returning True if it's valid
 * or False otherwise.
 *}
Function IsValidExp (st : String) : Boolean;
Var
 C, P : Byte;
Begin
 P:= 0;

 For C:=1 to Length (st) do
 Begin
  If (st[C]='(') then Inc (P);
  If (st[C]=')') then Dec (P);
 End;

 If (P=0) then IsValidExp:= True
 Else IsValidExp:= False;
End;

{*
 * Expression
 *
 *  Solves the expression defined on string st and returns it's value,
 * solved or an error in case it isn't valid.
 *}
Function Expression (st : String) : String;
Var
 OpFragment   : String;
 C, LastIndex : Integer;
Begin
 If not (IsValidExp (st)) then
 Begin
  Error ('Missing parentheses');
  Expression:= GTS ('Error: Missing parentheses');
  Exit;
 End;

 st:= DeleteSpaces (st);

 Repeat
  LastIndex:= -1;
  For C:=1 to length (st) do
  Begin
   If (st[C]='(') then
   Begin
    LastIndex:= C;
   End;
   If (st[C]=')') then
   Begin
    OpFragment:= Copy (st, LastIndex+1, C-LastIndex-1);
    Delete (st, LastIndex, C-LastIndex+1);
    Insert (Solve (OpFragment), st, LastIndex);
    st:= Simplify (st);
    Break;
   End;
  End;
 Until (LastIndex=-1);
 Expression:= Solve (st);
End;

Begin
End.