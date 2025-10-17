Unit BoatUnit;

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
    Vcl.ExtCtrls,
    Vcl.Imaging.Pngimage,
    Vcl.StdCtrls,
    Vcl.Menus,
    Unit1;

Const
    KEY_INCREASE_SPEED = Ord('B');
    KEY_DECREASE_SPEED = Ord('S');
    MAX_SPEED = 25;
    MIN_SPEED = 1;

Type
    TMainForm = Class(TForm)
        Timer: TTimer;
        Image: TImage;
        SpeedLabel: TLabel;
        MainMenu: TMainMenu;
        InstructionMainMenu: TMenuItem;
        AboutDeveloperMainMenu: TMenuItem;
        TaskLabel: TLabel;
        Procedure FormCreate(Sender: TObject);
        Procedure TimerTimer(Sender: TObject);
        Procedure FormKeyDown(Sender: TObject; Var Key: Word; Shift: TShiftState);
        Procedure FormResize(Sender: TObject);
        Procedure UpdateBackgroundColor;
        Function FormOnHelp(Command: Word; Data: THelpEventData; Var CallHelp: Boolean): Boolean;
        Procedure FormOnCloseQuerry(Sender: TObject; Var CanClose: Boolean);
        Procedure InstructionMainMenuClick(Sender: TObject);
        Procedure AboutDeveloperMainMenuClick(Sender: TObject);
    Private
        Speed: Integer;
        BaseBottom: Integer;
    Public
    End;

Var
    MainForm: TMainForm;

Implementation

{$R *.dfm}

Procedure TMainForm.AboutDeveloperMainMenuClick(Sender: TObject);
Var
    InstAndDev: TInstAndDev;
Begin
    InstAndDev := TInstAndDev.Create(Self);
    InstAndDev.Caption := 'About Developer';
    InstAndDev.SetText('Developer: Zarivniak Valeria'#13#10'Group: 451004'#13#10'tg: v_zarivnyak');
    InstAndDev.SetBackgroundColor(Self.Color);
    InstAndDev.ShowModal;
    InstAndDev.Free;
End;

Procedure TMainForm.FormCreate(Sender: TObject);
Begin
    Speed := 5;
    Timer.Interval := 25;
    Timer.Enabled := True;
    SpeedLabel.Caption := 'Speed: ' + IntToStr(Speed) + ' km/h';
    DoubleBuffered := True;
    BaseBottom := Self.ClientHeight - Image.Top;
    Self.OnResize := FormResize;
    UpdateBackgroundColor;
End;

Procedure TMainForm.TimerTimer(Sender: TObject);
Begin
    Image.Left := Image.Left + Speed;
    If Image.Left > Self.Width Then
        Image.Left := -Image.Width;
End;

Procedure TMainForm.FormKeyDown(Sender: TObject; Var Key: Word; Shift: TShiftState);
Begin
    If (Key = KEY_INCREASE_SPEED) And (Speed < MAX_SPEED) Then
        Inc(Speed)
    Else If (Key = KEY_DECREASE_SPEED) And (Speed > MIN_SPEED) Then
        Dec(Speed)
    Else If Key = VK_ESCAPE Then
        Close;
    SpeedLabel.Caption := 'Speed: ' + IntToStr(Speed) + ' km/h';
    UpdateBackgroundColor;
End;

Procedure TMainForm.FormOnCloseQuerry(Sender: TObject; Var CanClose: Boolean);
Begin
    If MessageBox(Handle, 'Do you really want to exit??', 'Exit', MB_YESNO Or MB_ICONQUESTION) = IDNO Then
        CanClose := False
    Else
        CanClose := True;
End;

Function TMainForm.FormOnHelp(Command: Word; Data: THelpEventData; Var CallHelp: Boolean): Boolean;
Begin
    CallHelp := False;
    FormOnHelp := True;
End;

Procedure TMainForm.UpdateBackgroundColor;
Begin
    If Speed <= 7 Then
        Color := RGB(173, 216, 230)
    Else
        If Speed <= 15 Then
            Color := RGB(144, 238, 144)
        Else
            Color := RGB(255, 182, 193);
End;

Procedure TMainForm.FormResize(Sender: TObject);
Begin
    Image.Top := Self.ClientHeight - BaseBottom;
End;

Procedure TMainForm.InstructionMainMenuClick(Sender: TObject);
Var
    InstAndDev: TInstAndDev;
Begin
    InstAndDev := TInstAndDev.Create(Self);
    InstAndDev.SetText
        ('Use the B and S keys to change the speed of the boat.'#13#10'B - increase speed, S - decrease speed'#13#10'Press "Esc" to exit the program.');
    InstAndDev.Caption := 'Instruction';
    InstAndDev.SetBackgroundColor(Self.Color);
    InstAndDev.ShowModal;
    InstAndDev.Free;
End;

End.
