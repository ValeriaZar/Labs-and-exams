Program Project7;

{$APPTYPE CONSOLE}
{$R *.res}

Type
    TCar = Record
        Mark: String[20];
        Year: Integer;
        Probeg: Integer;
        Phone: String[20];
        Cost: Real;
    End;

    TStatistics = Record
        Mark: String[20];
        Year: Integer;
        TotalCost: Real;
        Count: Integer;
    End;

    TCarArray = Array of TCar;
    TStatisticsArray = Array of TStatistics;

Function ReturnIndex(const Arr: TStatisticsArray; Marks: String; Years: Integer): Integer;
Var
    I: Integer;
Begin
    Result := -1;
    For I := 0 To High(Arr) Do
        If (Arr[I].Mark = Marks) And (Arr[I].Year = Years) Then
            Result := I;
End;

Procedure CreateStatistics(Var Stat: TStatisticsArray; Const Cars: TCarArray);
Var
    I, idx: Integer;
Begin
    SetLength(Stat, 0);
    For i := 0 To High(Cars) Do
    Begin
        idx := ReturnIndex(Stat, Cars[I].Mark, Cars[I].Year);
        If idx = -1 Then
        Begin
            SetLength(Stat, Length(Stat) + 1);
            idx := High(Stat);
            Stat[idx].Mark := Cars[I].Mark;
            Stat[idx].Year := Cars[I].Year;
            Stat[idx].TotalCost := 0;
            Stat[idx].Count := 0;
        End;
        Stat[idx].TotalCost := Stat[idx].TotalCost + Cars[I].Cost;
        Inc(Stat[idx].Count);
    End;
End;

Var
    I, N: Integer;
    F: TextFile;
    Cars: TCarArray;
    Stat: TStatisticsArray;
Begin
    AssignFile(F, 'try.txt');
    Reset(F);
    Readln(F, N);
    SetLength(Cars, N);
    For I := 0 To N - 1 Do
    Begin
        Readln(F, Cars[I].Mark);
        Readln(F, Cars[I].Year);
        Readln(F, Cars[I].Probeg);
        Readln(F, Cars[I].Phone);
        Readln(F, Cars[I].Cost);
    End;
    CloseFile(F);
    CreateStatistics(Stat, Cars);
    For I := 0 To High(Stat) Do
    Begin
        Writeln(Stat[I].Mark, ' ', Stat[I].Year, ': ', Stat[I].TotalCost/Stat[I].Count);
    End;
    Readln;
End.
