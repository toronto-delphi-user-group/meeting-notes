object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Parent-Child the New Way'
  ClientHeight = 147
  ClientWidth = 307
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Button3: TButton
    Left = 74
    Top = 103
    Width = 158
    Height = 25
    Caption = 'Set Reference to nil'
    TabOrder = 2
    OnClick = Button3Click
  end
  object Button1: TButton
    Left = 74
    Top = 22
    Width = 158
    Height = 25
    Caption = 'Create Instance'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 74
    Top = 63
    Width = 158
    Height = 25
    Caption = 'Who'#39's Your Daddy'
    TabOrder = 1
    OnClick = Button2Click
  end
end
