program qrcodegenerator;

uses
  Vcl.Forms,
  ufrmPrinc in 'ufrmPrinc.pas' {frmPrinc},
  uFuncoes in '..\src\uFuncoes.pas',
  DelphiZXIngQRCode in '..\src\dependencies\DelphiZXIngQRCode.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmPrinc, frmPrinc);
  Application.Run;
end.
