unit uCodeCoverage;

{
  Criado por: Luis Olivetti
  Data: 19/03/2019
  Material de apoio: https://github.com/magicmonty/delphi-code-coverage
}

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, uArquivoIni;

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
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    FArquivoIni: TArquivoIni;
    FWorkspace: string;
    FCaminhoExeAppTests: string;
    FCaminhoMapAppTests: string;
    FCaminhoCodeCovPaths: string;
    FCaminhoCodeCovUnits: string;

    procedure PreencherCaminhoWorkspace;
    procedure ExecutarCodeCoverage;
    function DefinirWorkspace: boolean;
    function ValidarListaUnits: boolean;
    function ValidarExeAppTests: boolean;
    function ValidarMapAppTests: boolean;
    function ValidarCodeCovPaths: boolean;
    function ValidarCodeCovUnits: boolean;
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
begin
  ExecutarCodeCoverage;
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

function TfrmCodeCoverage.DefinirWorkspace: boolean;
begin
  FWorkspace := Trim(edWorkspace.Text);

  if FWorkspace.IsEmpty then
  begin
    ShowMessage('Por favor, preencha o caminho da workspace.');
    if edWorkspace.CanFocus then
      edWorkspace.SetFocus;
  end;

  result := not FWorkspace.IsEmpty;
end;

procedure TfrmCodeCoverage.ExecutarCodeCoverage;
var
  sComando: string;
  sParametro: string;
begin
  if not DefinirWorkspace then
    Exit;
  if not ValidarListaUnits then
    Exit;
  if not ValidarExeAppTests then
    Exit;
  if not ValidarMapAppTests then
    Exit;
  if not ValidarCodeCovPaths then
    Exit;
  if not ValidarCodeCovUnits then
    Exit;

  sComando := FWorkspace + '\bin\CodeCoverage\CodeCoverage.exe';
  sParametro := '-v -e "' + FCaminhoExeAppTests +
    '" -m "' + FCaminhoMapAppTests +
    '" -uf "' + FCaminhoCodeCovUnits +
    '" -spf "' + FCaminhoCodeCovPaths +
    '" -od "' + FWorkspace +
    '\bin\CodeCoverage\Result_CodeCov\" -lt -html -xml -emma -lapi';

  ShellExecute(0, nil, PChar(sComando), PChar(sParametro), nil, SW_SHOWNORMAL);
end;

procedure TfrmCodeCoverage.FormCreate(Sender: TObject);
begin
  FArquivoIni := TArquivoIni.Create;
end;

procedure TfrmCodeCoverage.FormDestroy(Sender: TObject);
begin
  try
    FArquivoIni.CaminhoWorkspace := Trim(edWorkspace.Text);
  finally
    FreeAndNil(FArquivoIni);
  end;
end;

procedure TfrmCodeCoverage.FormShow(Sender: TObject);
begin
  PreencherCaminhoWorkspace;
end;

procedure TfrmCodeCoverage.PreencherCaminhoWorkspace;
begin
  edWorkspace.Text := FArquivoIni.CaminhoWorkspace;
end;

function TfrmCodeCoverage.ValidarCodeCovPaths: boolean;
begin
  FCaminhoCodeCovPaths := FWorkspace + '\bin\CodeCoverage\CodeCov_Paths.lst';

  if FileExists(FCaminhoCodeCovPaths) then
    Exit(True);

  ShowMessage('Arquivo inexistente: ' + FCaminhoCodeCovPaths);
  result := False;
end;

function TfrmCodeCoverage.ValidarCodeCovUnits: boolean;
begin
  if ckUsarUnitsOriginais.Checked then
  begin
    FCaminhoCodeCovUnits := FWorkspace + '\bin\CodeCoverage\CodeCov_units.lst';

    result := FileExists(FCaminhoCodeCovUnits);
    if result then
      Exit;

    ShowMessage('Arquivo inexistente: ' + FCaminhoCodeCovUnits);
  end
  else
  begin
    FCaminhoCodeCovUnits := FWorkspace + '\bin\CodeCoverage\CodeCov_units_manual.lst';
    mmUnits.Lines.SaveToFile(FCaminhoCodeCovUnits);
    result := True;
  end;
end;

function TfrmCodeCoverage.ValidarExeAppTests: boolean;
begin
  FCaminhoExeAppTests := FWorkspace + '\bin\' + FArquivoIni.NomeExeTests;

  if FileExists(FCaminhoExeAppTests) then
    Exit(True);

  ShowMessage('Arquivo inexistente: ' + FCaminhoExeAppTests);
  result := False;
end;

function TfrmCodeCoverage.ValidarListaUnits: boolean;
begin
  if ckUsarUnitsOriginais.Checked then
    Exit(True);

  result := Trim(mmUnits.Text) <> EmptyStr;
  if result then
    Exit;

  ShowMessage('Por favor, preencha a lista de units.');
  if mmUnits.CanFocus then
    mmUnits.SetFocus;
end;

function TfrmCodeCoverage.ValidarMapAppTests: boolean;
begin
  FCaminhoMapAppTests := FWorkspace + '\bin\' + FArquivoIni.NomeMapTests;

  if FileExists(FCaminhoMapAppTests) then
    Exit(True);

  ShowMessage('Arquivo inexistente: ' + FCaminhoMapAppTests);
  result := False;
end;

end.
