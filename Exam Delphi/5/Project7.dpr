Program Project7;

{$APPTYPE CONSOLE}
{$R *.res}

Type
    TBook = Record
        Author: String[20];
        Name: String[20];
        Number: Integer;
        CostOfDeliver: Real;
        CostOfBook: Real;
    End;

    TBookArr = Array of TBook;

Function FindTheMostExpensive(const Arr: TBookArr; K: Integer): Integer;
Var
    I: Integer;
    Max: Real;
Begin
    Max := -1;
    Result := -1;
    For I := 0 To High(Arr) Do
    Begin
        If Arr[I].Number < K Then
        Begin
            If Arr[I].CostOfBook > Max Then
            Begin
                Max := Arr[I].CostOfBook;
                Result := I;
            End;
        End;
    End;
End;

Var
    F: textFile;
    Arr: TBookArr;
    I, N, X, K: Integer;
Begin
    AssignFile(F, 'try.txt');
    Reset(F);
    Readln(F, N, K);
    SetLength(Arr, N);
    For I := 0 To High(Arr) Do
    Begin
        Readln(F, Arr[I].Author);
        Readln(F, Arr[I].Name);
        Readln(F, Arr[I].Number);
        Readln(F, Arr[I].CostOfDeliver);
        Readln(F, Arr[I].CostOfBook);
    End;
    CloseFile(F);
    X := FindTheMostExpensive(Arr, K);
    IF X = -1 Then
        Writeln('There Are no books')
    Else
    Begin
        Writeln('Name: ', Arr[X].Name);
        Writeln('Author: ', Arr[X].Author);
        Writeln('Count: ', Arr[X].Number);
        Writeln('Cost: ', Arr[X].CostOfBook);
    End;
    Readln;
End.
