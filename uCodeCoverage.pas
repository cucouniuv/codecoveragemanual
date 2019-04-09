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
    btAbrirRelatorio: TButton;
    FileOpenDialog: TFileOpenDialog;
    Button1: TButton;
    ckUsarUnitsOriginais: TCheckBox;
    procedure btExecutarClick(Sender: TObject);
    procedure btAbrirRelatorioClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure ckUsarUnitsOriginaisClick(Sender: TObject);
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

procedure TfrmCodeCoverage.btAbrirRelatorioClick(Sender: TObject);
var
  sComando: string;
begin
  sComando := Trim(edWorkspace.Text) + '\bin\CodeCoverage\Result_CodeCov\CodeCoverage_summary.html';

  if not (FileExists(sComando)) then
  begin
    ShowMessage('Arquivo inexistente: ' + sComando);
    Exit;
  end;

  ShellExecute(0, nil, PChar(sComando), PChar(''), nil, SW_SHOWNORMAL);
end;

procedure TfrmCodeCoverage.btExecutarClick(Sender: TObject);
var
  sComando: string;
  sParametro: string;
  sWorkspace: string;
  sArqListaUnit: string;
begin
  sWorkspace := Trim(edWorkspace.Text);
  if sWorkspace = EmptyStr then
  begin
    ShowMessage('Por favor, preencha o caminho da workspace.');
    edWorkspace.SetFocus;
    Exit;
  end;

  if (not ckUsarUnitsOriginais.Checked) and (Trim(mmUnits.Text) = EmptyStr) then
  begin
    ShowMessage('Por favor, preencha a lista de units.');
    mmUnits.SetFocus;
    Exit;
  end;

  if not (FileExists(sWorkspace + '\bin\pg5AppTests.exe')) then
  begin
    ShowMessage('Arquivo inexistente: ' + sWorkspace + '\bin\pg5AppTests.exe');
    Exit;
  end;

  if not (FileExists(sWorkspace + '\bin\pg5AppTests.map')) then
  begin
    ShowMessage('Arquivo inexistente: ' + sWorkspace + '\bin\pg5AppTests.map');
    Exit;
  end;

  if not (FileExists(sWorkspace + '\bin\CodeCoverage\CodeCov_Paths.lst')) then
  begin
    ShowMessage('Arquivo inexistente: ' + sWorkspace + '\bin\CodeCoverage\CodeCov_Paths.lst');
    Exit;
  end;

  if ckUsarUnitsOriginais.Checked then
  begin
    sArqListaUnit := sWorkspace + '\bin\CodeCoverage\CodeCov_units.lst';

    if not (FileExists(sArqListaUnit)) then
    begin
      ShowMessage('Arquivo inexistente: ' + sArqListaUnit);
      Exit;
    end;
  end
  else
  begin
    sArqListaUnit := sWorkspace + '\bin\CodeCoverage\CodeCov_units_manual.lst';
    mmUnits.Lines.SaveToFile(sArqListaUnit);
  end;

  sComando := sWorkspace + '\bin\CodeCoverage\CodeCoverage.exe';
  sParametro := '-v -e "' + sWorkspace +
    '\bin\pg5AppTests.exe" -m "' + sWorkspace +
    '\bin\pg5AppTests.map" -uf "' +
    sArqListaUnit + '" -spf "' + sWorkspace +
    '\bin\CodeCoverage\CodeCov_Paths.lst" -od "' + sWorkspace +
    '\bin\CodeCoverage\Result_CodeCov\" -lt -html -xml -emma -lapi';

  ShellExecute(0, nil, PChar(sComando), PChar(sParametro), nil, SW_SHOWNORMAL);
end;

procedure TfrmCodeCoverage.Button1Click(Sender: TObject);
begin
  FileOpenDialog.Execute;

  if FileOpenDialog.FileName = EmptyStr then
    Exit;

  edWorkspace.Text := FileOpenDialog.FileName;
end;

procedure TfrmCodeCoverage.ckUsarUnitsOriginaisClick(Sender: TObject);
begin
  mmUnits.Enabled := not ckUsarUnitsOriginais.Checked;
end;

end.
