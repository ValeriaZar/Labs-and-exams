Program Project7;

{$APPTYPE CONSOLE}
{$R *.res}

Uses
    System.SysUtils;

Type
    TGoodsRecord = Record
        Good: String[40];
        NumberInYear: Integer;
        PriceForOne: Real;
        Count: Integer;
    End;

    TStatistics = Record
        NameOfGood: String[40];
        Days: Array Of Integer;
    End;

    TGArray = Array Of TGoodsRecord;
    TSArray = Array Of TStatistics;

Function ReturnIndex(Const Arr: TSArray; Name: String): Integer;
Var
    I: Integer;
Begin
    Result := -1;
    For I := 0 To High(Arr) Do
        If Arr[I].NameOfGood = Name Then
            Result := I;
End;

Procedure CreateStatistics(Var Stat: TSArray; Const Goods: TGArray);
Var
    I, Idx, X: Integer;
Begin
    SetLength(Stat, 0);
    For I := 0 To High(Goods) Do
    Begin
        Idx := ReturnIndex(Stat, Goods[I].Good);
        If Idx = -1 Then
        Begin
            SetLength(Stat, Length(Stat) + 1);
            Idx := High(Stat);
            Stat[Idx].NameOfGood := Goods[I].Good;
            SetLength(Stat[Idx].Days, 0);
        End;
        SetLength(Stat[Idx].Days, Length(Stat[Idx].Days) + 1);
        X := High(Stat[Idx].Days);
        Stat[Idx].Days[X] := Goods[I].NumberInYear;
    End;
End;

Procedure BubbleSort(Var Arr: Array Of Integer);
Var
    I, J, N: Integer;
    Temp: Integer;
Begin
    N := Length(Arr);
    For I := 0 To N - 2 Do
        For J := 0 To N - I - 2 Do
            If Arr[J] > Arr[J + 1] Then
            Begin
                Temp := Arr[J];
                Arr[J] := Arr[J + 1];
                Arr[J + 1] := Temp;
            End;
End;

Function Check(Const Arr: Array Of Integer; Const K: Integer): Boolean;
Var
    I, Max: Integer;
Begin
    Max := 1;
    Result := False;
    For I := 1 To High(Arr) Do
    Begin
        If (Arr[I] = Arr[I - 1] + 1) Then
        Begin
            Inc(Max);
            If Max >= K Then
                Result := True;
        End
        Else
            Max := 1;
    End;
End;

Var
    F: TextFile;
    I, N, K: Integer;
    ArrStat: TSArray;
    ArrGoods: TGArray;

Begin
    AssignFile(F, 'try.txt');
    Reset(F);
    Readln(F, N, K);
    SetLength(ArrGoods, N);
    For I := 0 To N - 1 Do
    Begin
        Readln(F, ArrGoods[I].Good);
        Readln(F, ArrGoods[I].NumberInYear);
        Readln(F, ArrGoods[I].PriceForOne);
        Readln(F, ArrGoods[I].Count);
    End;
    CloseFile(F);
    CreateStatistics(ArrStat, ArrGoods);
    For I := 0 To High(ArrStat) Do
        BubbleSort(ArrStat[I].Days);
    For I := 0 To High(ArrStat) Do
        If Check(ArrStat[I].Days, K) Then
            Writeln(ArrStat[I].NameOfGood);
    Readln;

End.
