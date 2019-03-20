program CodeCoverageManual;

uses
  Vcl.Forms,
  uCodeCoverage in 'uCodeCoverage.pas' {frmCodeCoverage};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmCodeCoverage, frmCodeCoverage);
  Application.Run;
end.
