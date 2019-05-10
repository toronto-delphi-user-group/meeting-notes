object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Reference Counting'
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
  object Button2: TButton
    Left = 8
    Top = 39
    Width = 158
    Height = 25
    Caption = 'As'
    TabOrder = 1
    OnClick = Button2Click
  end
  object Button1: TButton
    Left = 8
    Top = 8
    Width = 158
    Height = 25
    Caption = 'Supports (Class)'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Memo1: TMemo
    Left = 172
    Top = 8
    Width = 367
    Height = 384
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabOrder = 3
  end
  object Button3: TButton
    Left = 8
    Top = 70
    Width = 158
    Height = 25
    Caption = 'Supports (Instance)'
    TabOrder = 2
    OnClick = Button3Click
  end
end
