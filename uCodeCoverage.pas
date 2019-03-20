unit uCodeCoverage;

{
  Criado por: Luis Olivetti
  Data: 19/03/2019
  Material de apoio: https://github.com/magicmonty/delphi-code-coverage
}

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TfrmCodeCoverage = class(TForm)
    edWorkspace: TEdit;
    btExecutar: TButton;
    mmUnits: TMemo;
    lbCaminho: TLabel;
    lbLista: TLabel;
    lbInfo: TLabel;
    Label1: TLabel;
    procedure btExecutarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCodeCoverage: TfrmCodeCoverage;

implementation

uses
  ShellAPI;

{$R *.dfm}

procedure TfrmCodeCoverage.btExecutarClick(Sender: TObject);
var
  sComando: string;
  sParametro: string;
  sWorkspace: string;
begin
  sWorkspace := Trim(edWorkspace.Text);
  if sWorkspace = EmptyStr then
  begin
    ShowMessage('Por favor, preencha o caminho da workspace.');
    edWorkspace.SetFocus;
    Exit;
  end;

  if Trim(mmUnits.Text) = EmptyStr then
  begin
    ShowMessage('Por favor, preencha a lista de units.');
    mmUnits.SetFocus;
    Exit;
  end;

  mmUnits.Lines.SaveToFile(sWorkspace + '\bin\CodeCoverage\CodeCov_units.lst');

  sComando := sWorkspace + '\bin\CodeCoverage\CodeCoverage.exe';
  sParametro := '-v -e "' + sWorkspace +
    '\bin\pg5AppTests.exe" -m "' + sWorkspace +
    '\bin\pg5AppTests.map" -uf "' + sWorkspace +
    '\bin\CodeCoverage\CodeCov_units.lst" -spf "' + sWorkspace +
    '\bin\CodeCoverage\CodeCov_Paths.lst" -od "' + sWorkspace +
    '\bin\CodeCoverage\Result_CodeCov\" -lt -html -xml -emma -lapi';

  ShellExecute(0, nil, PChar(sComando), PChar(sParametro), nil, SW_SHOWNORMAL);
end;

end.
