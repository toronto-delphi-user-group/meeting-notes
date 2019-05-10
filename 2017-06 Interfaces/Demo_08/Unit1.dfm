object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'RTTI'
  ClientHeight = 400
  ClientWidth = 547
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  DesignSize = (
    547
    400)
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 50
    Height = 13
    Caption = 'Parameter'
  end
  object Button1: TButton
    Left = 8
    Top = 54
    Width = 158
    Height = 25
    Caption = 'Upper'
    TabOrder = 1
    OnClick = Button1Click
  end
  object Memo1: TMemo
    Left = 172
    Top = 8
    Width = 367
    Height = 384
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabOrder = 5
  end
  object Edit1: TEdit
    Left = 8
    Top = 27
    Width = 158
    Height = 21
    TabOrder = 0
    Text = 'The Quick Brown Fox'
  end
  object Button2: TButton
    Left = 8
    Top = 85
    Width = 158
    Height = 25
    Caption = 'Lower'
    TabOrder = 2
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 8
    Top = 116
    Width = 158
    Height = 25
    Caption = 'Reverse'
    TabOrder = 3
    OnClick = Button3Click
  end
  object Button4: TButton
    Left = 8
    Top = 147
    Width = 158
    Height = 25
    Caption = 'Clear'
    TabOrder = 4
    OnClick = Button4Click
  end
end
