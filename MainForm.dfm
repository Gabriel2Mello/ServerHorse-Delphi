object MainFrm: TMainFrm
  Left = 0
  Top = 0
  Caption = 'Server Horse'
  ClientHeight = 221
  ClientWidth = 392
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object memLog: TMemo
    Left = 181
    Top = 0
    Width = 211
    Height = 221
    Align = alRight
    Enabled = False
    ReadOnly = True
    TabOrder = 0
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 181
    Height = 221
    Align = alClient
    TabOrder = 1
    object Label1: TLabel
      Left = 25
      Top = 18
      Width = 36
      Height = 13
      Caption = 'Usu'#225'rio'
    end
    object Label2: TLabel
      Left = 25
      Top = 125
      Width = 26
      Height = 13
      Caption = 'Porta'
    end
    object Label3: TLabel
      Left = 25
      Top = 74
      Width = 30
      Height = 13
      Caption = 'Senha'
    end
    object edtUsuario: TEdit
      Left = 25
      Top = 37
      Width = 121
      Height = 21
      TabOrder = 0
      Text = 'admin'
    end
    object edtPorta: TEdit
      Left = 25
      Top = 144
      Width = 121
      Height = 21
      TabOrder = 2
      Text = '9000'
    end
    object edtSenha: TEdit
      Left = 25
      Top = 93
      Width = 121
      Height = 21
      TabOrder = 1
      Text = 'admin'
    end
    object btnIniciar: TButton
      Left = 8
      Top = 181
      Width = 75
      Height = 25
      Caption = 'Iniciar'
      TabOrder = 3
      OnClick = btnIniciarClick
    end
    object btnParar: TButton
      Left = 89
      Top = 181
      Width = 75
      Height = 25
      Caption = 'Parar'
      TabOrder = 4
      OnClick = btnPararClick
    end
  end
end
