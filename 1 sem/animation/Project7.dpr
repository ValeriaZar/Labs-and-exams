program Project7;

uses
  Vcl.Forms,
  BoatUnit in 'BoatUnit.pas' {MainForm},
  Unit1 in 'Unit1.pas' {InstAndDev};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TInstAndDev, InstAndDev);
  Application.Run;
end.
