program CodeCoverageManual;

uses
  Vcl.Forms,
  uCodeCoverage in 'uCodeCoverage.pas' {frmCodeCoverage},
  Vcl.Themes,
  Vcl.Styles,
  uArquivoIni in 'uArquivoIni.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'Code Coverage - Manual';
  TStyleManager.TrySetStyle('Luna');
  Application.CreateForm(TfrmCodeCoverage, frmCodeCoverage);
  Application.Run;
end.
