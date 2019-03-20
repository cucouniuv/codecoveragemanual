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
  Position = poDesktopCenter
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
    Width = 575
    Height = 13
    Anchors = [akLeft, akBottom]
    Caption = 
      'Observa'#231#245'es: Ap'#243's executar, dever'#225' abrir a tela do DUnit. Nela, ' +
      'voc'#234' deve escolher o teste que voc'#234' pretende rodar. '
  end
  object Label1: TLabel
    Left = 8
    Top = 283
    Width = 453
    Height = 13
    Anchors = [akLeft, akBottom]
    Caption = 
      'Ap'#243's executar, os resultados ficam armazenados em "..\bin\CodeCo' +
      'verage\Result_CodeCov" '
  end
  object edWorkspace: TEdit
    Left = 8
    Top = 23
    Width = 483
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
    Width = 619
    Height = 194
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabOrder = 2
  end
end
