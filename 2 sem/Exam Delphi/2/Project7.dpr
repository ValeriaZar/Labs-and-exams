Program Project7;

{$APPTYPE CONSOLE}
{$R *.res}

Type
    TBooks = Record
        Author: String[40];
        Name: String[30];
        Count: Integer;
        CostOfDeliver: Real;
        CostOfOne: Real;
    End;

    TArr = Array Of TBooks;

Function ReturnMinIndex(Const Arr: TArr): Integer;
Var
    I, MinIndex: Integer;
    Min: Real;
Begin
    Min := Arr[0].CostOfDeliver + Arr[0].CostOfOne;
    MinIndex := 0;
    For I := 1 To High(Arr) Do
    Begin
        If (Arr[I].CostOfDeliver + Arr[I].CostOfOne) < Min Then
        Begin
            Min := Arr[I].CostOfDeliver + Arr[I].CostOfOne;
            MinIndex := I;
        End
    Else If (Arr[I].CostOfDeliver + Arr[I].CostOfOne) = Min Then
        If  Arr[I].Count > Arr[MinIndex].Count Then
        Begin
            Min := Arr[I].CostOfDeliver + Arr[I].CostOfOne;
            MinIndex := I;
        End;
    End;
    ReturnMinIndex := MinIndex;
End;

Var
    I, N, idx: Integer;
    F: TextFile;
    BooksArray: TArr;
Begin
    AssignFile(F, 'try.txt');
    Reset(F);
    Readln(F, N);
    SetLength(BooksArray, N);
    For I := 0 To N - 1 Do
    Begin
        Readln(F, BooksArray[I].Author);
        Readln(F, BooksArray[I].Name);
        Readln(F, BooksArray[I].Count);
        Readln(F, BooksArray[I].CostOfDeliver);
        Readln(F, BooksArray[I].CostOfOne);
    End;
    CloseFile(F);
    idx :=  ReturnMinIndex(BooksArray);
    Writeln(BooksArray[idx].Name, BooksArray[idx].Author, BooksArray[idx].CostOfDeliver + BooksArray[idx].CostOfOne);
    Readln;
End.
