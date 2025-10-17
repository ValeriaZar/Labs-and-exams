Unit Unit1;

Interface

Uses
    Winapi.Windows,
    Winapi.Messages,
    System.SysUtils,
    System.Variants,
    System.Classes,
    Vcl.Graphics,
    Vcl.Controls,
    Vcl.Forms,
    Vcl.Dialogs,
    Vcl.StdCtrls,
    Vcl.Imaging.GIFImg;

Type
    TInstAndDev = Class(TForm)
        InstAndDevLabel: TLabel;
        Function FormOnHelp(Command: Word; Data: THelpEventData; Var CallHelp: Boolean): Boolean;
        Procedure SetText(Const AText: String);
        Procedure SetBackgroundColor(AColor: TColor);
        Procedure FormOnKeyDown(Sender: TObject; Var Key: Word; Shift: TShiftState);
    Private
        { Private declarations }
    Public
        { Public declarations }
    End;

Var
    InstAndDev: TInstAndDev;

Implementation

{$R *.dfm}

Function TInstAndDev.FormOnHelp(Command: Word; Data: THelpEventData; Var CallHelp: Boolean): Boolean;
Begin
    CallHelp := False;
    FormOnHelp := True;
End;

Procedure TInstAndDev.SetText(Const AText: String);
Begin
    InstAndDevLabel.Caption := AText;
    InstAndDevLabel.Left := (Self.ClientWidth - InstAndDevLabel.Width) Div 2;
    InstAndDevLabel.Top := (Self.ClientHeight - InstAndDevLabel.Height) Div 2;
End;

Procedure TInstAndDev.FormOnKeyDown(Sender: TObject; Var Key: Word; Shift: TShiftState);
Begin
    If Key = VK_ESCAPE Then
        Close;
End;

Procedure TInstAndDev.SetBackgroundColor(AColor: TColor);
Begin
    Self.Color := AColor;
End;

End.
