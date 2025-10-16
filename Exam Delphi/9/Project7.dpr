Program Project7;

{$APPTYPE CONSOLE}
{$R *.res}

Type
    TBid = Record
        Bid: String[20];
        NumberOfBid: Integer;
        Data: string;
        TimeSpent: Integer;
    End;

    TStatistics = Record
        Data: string;
        TotalTime: Integer;
        Count: Integer;
    End;

    TBidArray = Array Of TBid;
    TStatArray = Array Of TStatistics;

Function ReturnIndex(Const Arr: TStatArray; Const Data: string): Integer;
Var
    I: Integer;
Begin
    Result := -1;
    For I := 0 To High(Arr) Do
        If Arr[I].Data = Data Then
            Result := I;
End;

Procedure CreateStatistics(Var Stat: TStatArray; Const Bid: TBidArray);
Var
    I, idx: Integer;
Begin
    SetLength(Stat, 0);
    For I := 0 To High(Bid) Do
    Begin
        idx := ReturnIndex(Stat, Bid[I].Data);
        If idx = -1 then
        Begin
            SetLength(Stat, length(Stat) + 1);
            idx := High(Stat);
            Stat[idx].Data := Bid[I].Data;
            Stat[idx].Totaltime := 0;
            Stat[idx].Count := 0;
        End;
        Inc(Stat[idx].Count);
        Inc(Stat[idx].TotalTime, Bid[I].TimeSpent);
    End;
End;

Procedure BubbleSort(var Stat: TStatArray);
Var
    I, J: Integer;
    Temp: TStatistics;
Begin
    For I := 0 To High(Stat) - 1 Do
        For J := 0 To High(Stat) - 1 - I Do
            If Stat[J].Count < Stat[J + 1].Count Then
            Begin
                Temp := Stat[J+1];
                Stat[J+1] := Stat[J];
                Stat[J] := Temp;
            End;
End;

Var
    F: TextFile;
    I, N, K: integer;
    Arr: TBidArray;
    Stat: TStatArray;
Begin
    AssignFile(F, 'try.txt');
    Reset(F);
    Readln(F, N, K);
    SetLength(Arr, N);
    For I := 0 To High(Arr) Do
    Begin
        Readln(F, Arr[I].Bid);
        Readln(F, Arr[I].NumberOfBid);
        Readln(F, Arr[I].Data);
        Readln(F, Arr[I].TimeSpent);
    End;
    CloseFile(F);
    CreateStatistics(Stat, Arr);
    BubbleSort(Stat);
    For I := 0 To K - 1 Do
        Writeln('DATA: ', Stat[I].Data, '; Total Time: ', Stat[I].TotalTime, '; Count: ', Stat[I].Count);
    Readln;
End.
