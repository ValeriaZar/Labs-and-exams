program Project7;

{$APPTYPE CONSOLE}

{$R *.res}

Type
    TEmployee = record
        FIO: String;
        Otdel: String[20];
        Year: Integer;
        Money: Real;
    end;

    TStatistics = record
        Otdel: String[20];
        TotalPrice: Real;
        Count: Integer;
    end;

    TEmployeeArr = Array of TEmployee;
    TStat = Array of TStatistics;

Function ReturnIndex(const Stat: TStat; Otdel: String): Integer;
Var
    I: Integer;
Begin
    Result := -1;
    For I := 0 To High(Stat) Do
        If Stat[I].Otdel = Otdel Then
            Result := I;
End;

Procedure CreateStatistics(var Stat: TStat; Const Employees: TEmployeeArr);
var
    I, idx: Integer;
Begin
    SetLength(Stat, 0);
    For I := 0 To High(Employees) Do
    Begin
        idx := ReturnIndex(Stat, Employees[I].Otdel);
        If idx = -1 Then
        Begin
            SetLength(Stat, Length(Stat)+1);
            idx := High(Stat);
            Stat[idx].Otdel := Employees[I].Otdel;
            Stat[idx].TotalPrice := 0;
            Stat[idx].Count := 0;
        End;
        Stat[idx].TotalPrice := Stat[idx].TotalPrice + Employees[I].Money;
        Inc(Stat[idx].Count);
    End;
End;

Function FindMax(const Arr: TStat): Integer;
Var
    I: Integer;
    Max: Real;
Begin
    Result := 0;
    Max := Arr[0].TotalPrice;
    For I := 1 To High(Arr) Do
    Begin
        If Arr[I].TotalPrice > Max Then
        Begin
            Max := Arr[I].TotalPrice;
            Result := I
        End;
    End;
End;

Var
    I, N, Index: Integer;
    F: TextFile;
    Employees: TEmployeeArr;
    Stats: TStat;
begin
    AssignFile(F, 'try.txt');
    Reset(F);
    Readln(F, N);
    SetLength(Employees, N);
    For I := 0 To High(Employees) Do
    Begin
        REadln(F, Employees[I].FIO);
        REadln(F, Employees[I].Otdel);
        REadln(F, Employees[I].Year);
        REadln(F, Employees[I].Money);
    End;
    CloseFile(F);
    CreateStatistics(Stats, Employees);
    Index := FindMax(Stats);
    Writeln('Average price: ', Stats[Index].TotalPrice/Stats[Index].Count, ' Otdel: ', Stats[Index].Otdel);
    Readln;
end.
