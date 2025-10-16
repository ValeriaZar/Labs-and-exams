Program Project7;

{$APPTYPE CONSOLE}
{$R *.res}

Type
    TStudent = Record
        FIO: String;
        MarkTeacher: Integer;
        MarkRecensia: Integer;
        AverageScore: Real;
    End;

    TArr = Array Of TStudent;

Function FindStudent(Const Arr: TArr): Integer;
Var
    I: Integer;
    MaxDiffer: Real;
Begin
    MaxDiffer := Abs(Arr[0].MarkRecensia - Arr[0].AverageScore);
    Result := 0;
    For I := 1 To High(Arr) Do
    Begin
        If MaxDiffer < Abs(Arr[I].MarkRecensia - Arr[I].AverageScore) Then
        Begin
            MaxDiffer := Abs(Arr[I].MarkRecensia - Arr[I].AverageScore);
            Result := I;
        End;
    End;
End;

Var
    I, N: Integer;
    F: TextFile;
    Arr: TArr;
Begin
    AssignFile(F, 'try.txt');
    Reset(F);
    Readln(F, N);
    Setlength(Arr, N);
    For I := 0 To High(Arr) Do
    Begin
        Readln(F, Arr[I].FIO);
        Readln(F, Arr[I].MarkTeacher);
        Readln(F, Arr[I].MarkRecensia);
        Readln(F, Arr[I].AverageScore);
    End;
    CloseFile(F);
    Writeln('FIO: ', Arr[FindStudent(Arr)].FIO);
    Writeln('Mark: ', ((Arr[FindStudent(Arr)].MarkTeacher + Arr[FindStudent(Arr)].MarkRecensia +Arr[FindStudent(Arr)].AverageScore) / 3):0:2);
    Readln;
End.
