unit uArquivoIni;

{
  Criado por: Luis Olivetti
  Data: 27/03/2019
  Classe criada para ler e gravar configurações
}

interface

uses
  IniFiles;

type
  TArquivoIni = class
    FArquivoIni: TIniFile;
    FCaminhoExecutavel: string;
  private
    FNomeExeTests: string;
    FNomeMapTests: string;
    FCaminhoWorkspace: string;
    FbGravarUltimoWorkspace: boolean;
    procedure LerCaminhoExecutavel;
    procedure LerArquivo;
    procedure CriarArquivo;
    procedure SetNomeExeTests(const Value: string);
    procedure SetNomeMapTests(const Value: string);
    procedure SetCaminhoWorkspace(const Value: string);
    procedure GravarUltimoWorkspace;
  public
    constructor Create;
    destructor Destroy; override;
    property CaminhoWorkspace: string read FCaminhoWorkspace write SetCaminhoWorkspace;
    property NomeExeTests: string read FNomeExeTests write SetNomeExeTests;
    property NomeMapTests: string read FNomeMapTests write SetNomeMapTests;
  end;

implementation

uses
  System.SysUtils;

{ TArquivoIni }

constructor TArquivoIni.Create;
begin
  LerCaminhoExecutavel;
  CriarArquivo;
  LerArquivo;
end;

procedure TArquivoIni.CriarArquivo;
var
  sCaminhoIni: string;
begin
  sCaminhoIni := FCaminhoExecutavel + 'config.ini';
  FArquivoIni := TIniFile.Create(sCaminhoIni);

  if FileExists(sCaminhoIni) then
    Exit;

  FArquivoIni.WriteString('Caminho', 'Workspace', EmptyStr);
  FArquivoIni.WriteBool('Caminho', 'GravarUltimoWorkspace', True);
  FArquivoIni.WriteString('NomeArquivo', 'Exe', 'pg5AppTests.exe');
  FArquivoIni.WriteString('NomeArquivo', 'Map', 'pg5AppTests.map');
end;

destructor TArquivoIni.Destroy;
begin
  try
    GravarUltimoWorkspace;
  finally
    FArquivoIni.Free;
    inherited;
  end;
end;

procedure TArquivoIni.GravarUltimoWorkspace;
begin
  if not(FbGravarUltimoWorkspace) then
    Exit;

  FArquivoIni.WriteString('Caminho', 'Workspace', FCaminhoWorkspace);
end;

procedure TArquivoIni.LerArquivo;
begin
  FCaminhoWorkspace := FArquivoIni.ReadString('Caminho', 'Workspace', EmptyStr);
  FbGravarUltimoWorkspace := FArquivoIni.ReadBool('Caminho', 'GravarUltimoWorkspace', True);
  FNomeExeTests := FArquivoIni.ReadString('NomeArquivo', 'Exe', EmptyStr);
  FNomeMapTests := FArquivoIni.ReadString('NomeArquivo', 'Map', EmptyStr);
end;

procedure TArquivoIni.LerCaminhoExecutavel;
begin
  FCaminhoExecutavel := ExtractFilePath(ParamStr(0));
end;

procedure TArquivoIni.SetCaminhoWorkspace(const Value: string);
begin
  FCaminhoWorkspace := Value;
end;

procedure TArquivoIni.SetNomeExeTests(const Value: string);
begin
  FNomeExeTests := Value;
end;

procedure TArquivoIni.SetNomeMapTests(const Value: string);
begin
  FNomeMapTests := Value;
end;

end.
