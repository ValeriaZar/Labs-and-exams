Program Project7;

{$APPTYPE CONSOLE}
{$R *.res}

Type
    TEmergency = record
        Brigade: String;
        Time: Integer;
        Distance: Double;
    end;

    TSatistics = record
        Brigade: String;
        Count: Integer;
        TotalTime: Integer;
    end;

    TEmergencyArr = Array of TEmergency;
    TStatArray = Array of TSatistics;

Function ReturnIndex(Const Arr: TStatArray; Brigade: String): Integer;
Var
    I: Integer;
Begin
    Result := -1;
    For I := 0 To High(Arr) do
        If Arr[I].Brigade = Brigade Then
            Result := I;
End;

Procedure CreateStatistics(var Stat: TStatArray; Const Emergency: TEmergencyArr; Const K: Integer);
Var
    I, idx: Integer;
Begin
    SetLength(Stat, 0);
    For I := 0 To High(Emergency) Do
    Begin
        idx := ReturnIndex(Stat, Emergency[I].Brigade);
        if idx = -1 then
        Begin
            SetLength(Stat, Length(Stat) + 1);
            idx := High(Stat);
            Stat[idx].Brigade := Emergency[I].Brigade;
            Stat[idx].Count := 0;
            Stat[idx].TotalTime := 0;
        End;
        If Emergency[I].Distance > K Then
        Begin
            Inc(Stat[idx].Count);
            Inc(Stat[idx].TotalTime, Emergency[I].Time);
        End;
    End;
End;

Var
    F: TextFile;
    I, K, N: Integer;
    Arr: TEmergencyArr;
    Stat: TStatArray;
Begin
    AssignFile(F, 'try.txt');
    Reset(F);
    Readln(F, N, K);
    SetLength(Arr, N);
    for I := Low(Arr) to High(arr) do
    Begin
        Readln(F, Arr[I].Brigade);
        Readln(F, Arr[I].Time);
        Readln(F, Arr[I].Distance);
    End;
    CloseFile(F);
    CreateStatistics(Stat, Arr, K);
    For I := 0 To High(Stat) Do
        Writeln('Brigade: ', Stat[I].Brigade, '; Count: ', Stat[I].Count, '; Total Time: ', Stat[I].TotalTime);
    Readln;
End.
