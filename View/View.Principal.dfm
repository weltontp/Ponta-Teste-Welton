object FrmPrincipal: TFrmPrincipal
  Left = 0
  Top = 0
  Caption = 'Agro'
  ClientHeight = 437
  ClientWidth = 1080
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object MainMenu1: TMainMenu
    Left = 952
    Top = 184
    object Cadastro1: TMenuItem
      Caption = 'Cadastro'
      object Fazenda1: TMenuItem
        Caption = 'Fazenda'
        OnClick = Fazenda1Click
      end
      object Animal1: TMenuItem
        Caption = 'Animal'
        OnClick = Animal1Click
      end
    end
    object Relatrio1: TMenuItem
      Caption = 'Relat'#243'rios'
      object Fazenda2: TMenuItem
        Caption = 'Fazendas'
        OnClick = Fazenda2Click
      end
      object Animais1: TMenuItem
        Caption = 'Animais'
        OnClick = Animais1Click
      end
    end
  end
end
