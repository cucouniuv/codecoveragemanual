object frmCodeCoverage: TfrmCodeCoverage
  Left = 0
  Top = 0
  Caption = 'Code Coverage (Manual)'
  ClientHeight = 300
  ClientWidth = 635
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  DesignSize = (
    635
    300)
  PixelsPerInch = 96
  TextHeight = 13
  object lbCaminho: TLabel
    Left = 8
    Top = 4
    Width = 233
    Height = 13
    Caption = 'Caminho Workspace (Ex.: C:\RTC\DEV\pg5Dev )'
  end
  object lbLista: TLabel
    Left = 8
    Top = 50
    Width = 160
    Height = 13
    Caption = 'Lista de Units (Ex.: uedtFuncoes)'
  end
  object lbInfo: TLabel
    Left = 8
    Top = 269
    Width = 595
    Height = 13
    Anchors = [akLeft, akBottom]
    Caption = 
      'Observa'#231#245'es: Ap'#243's executar, dever'#225' abrir a tela do DUnit (se est' +
      'iver configurado no spCfg.ini). Nela, voc'#234' deve escolher o'
  end
  object Label1: TLabel
    Left = 8
    Top = 283
    Width = 155
    Height = 13
    Anchors = [akLeft, akBottom]
    Caption = 'teste que voc'#234' pretende rodar. '
  end
  object edWorkspace: TEdit
    Left = 8
    Top = 23
    Width = 439
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 0
    Text = 'C:\RTC\DEV_TOKYO_PG5\pg5Dev'
  end
  object btExecutar: TButton
    Left = 497
    Top = 20
    Width = 130
    Height = 27
    Anchors = [akTop, akRight]
    Caption = 'Executar'
    TabOrder = 1
    OnClick = btExecutarClick
  end
  object mmUnits: TMemo
    Left = 8
    Top = 69
    Width = 483
    Height = 194
    Hint = 'Informe as units, pulando a linha quando quiser mais de uma'
    Anchors = [akLeft, akTop, akRight, akBottom]
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    HideSelection = False
    ParentFont = False
    ParentShowHint = False
    ScrollBars = ssVertical
    ShowHint = True
    TabOrder = 2
  end
  object btAbrirRelatorio: TButton
    Left = 497
    Top = 238
    Width = 130
    Height = 25
    Hint = 
      'Os resultados ficam armazenados em "..\bin\CodeCoverage\Result_C' +
      'odeCov"'
    Anchors = [akRight, akBottom]
    Caption = 'Abrir Relat'#243'rio'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 3
    OnClick = btAbrirRelatorioClick
  end
  object Button1: TButton
    Left = 454
    Top = 20
    Width = 37
    Height = 27
    Hint = 'Escolher caminho da workspace'
    Anchors = [akTop, akRight]
    Caption = '...'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 4
    OnClick = Button1Click
  end
  object ckUsarUnitsOriginais: TCheckBox
    Left = 361
    Top = 50
    Width = 130
    Height = 17
    Anchors = [akTop, akRight]
    Caption = 'Usar lista de units padr'#227'o'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -9
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 5
    OnClick = ckUsarUnitsOriginaisClick
  end
  object FileOpenDialog: TFileOpenDialog
    FavoriteLinks = <>
    FileTypes = <>
    Options = [fdoPickFolders]
    Title = 'Escolha o caminho da Workspace'
    Left = 568
    Top = 64
  end
end
