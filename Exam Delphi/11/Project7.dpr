Program Project7;

{$APPTYPE CONSOLE}
{$R *.res}

Type
    TCar = Record
        Mark: String;
        Year: Integer;
        Probeg: Double;
        Price: Double;
        Phone: String;
    End;

    TArr = Array Of TCar;

Function FindCar(Const Arr: TArr; CurrentYear: Integer): Integer;
Var
    I, MinIndex: Integer;
    MinProbeg, AvProbeg: Double;
Begin
    MinIndex := 0;
    MinProbeg := Arr[0].Probeg / (CurrentYear - Arr[0].Year);
    For I := 1 To High(Arr) Do
    Begin
        AvProbeg := Arr[I].Probeg / (CurrentYear - Arr[I].Year);
        If AvProbeg < MinProbeg Then
        Begin
            MinProbeg := AvProbeg;
            MinIndex := I
        End;
        If AvProbeg = MinProbeg Then
            If Arr[I].Price < Arr[MinIndex].Price Then
            BEgin
                MinProbeg := AvProbeg;
                MinIndex := I
            End;
    End;
    Result := MinIndex;
End;

Var
    F: TextFile;
    I, N, CurrentYear, Index: Integer;
    Arr: TArr;
Begin
    AssignFile(F, 'try.txt');
    Reset(F);
    Readln(F, N, CurrentYear);
    SetLength(Arr, N);
    For I := 0 To High(Arr) Do
    Begin
        Readln(F, Arr[I].Mark);
        Readln(F, Arr[I].Year);
        Readln(F, Arr[I].Probeg);
        Readln(F, Arr[I].Price);
        Readln(F, Arr[I].Phone);
    End;
    CloseFile(F);
    Index := FindCar(Arr, CurrentYear);
    Writeln('Mark: ', Arr[Index].Mark);
    Writeln('Probeg: ', Arr[Index].Probeg:0:2);
    Writeln('Phone: ', Arr[Index].Phone);
    Readln;
End.
