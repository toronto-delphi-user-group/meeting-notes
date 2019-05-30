object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Delphi Servers'
  ClientHeight = 409
  ClientWidth = 635
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  DesignSize = (
    635
    409)
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 10
    Width = 44
    Height = 16
    Caption = 'Normal'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 8
    Top = 194
    Width = 45
    Height = 16
    Caption = 'Secure'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object btnConnect: TButton
    Left = 16
    Top = 32
    Width = 75
    Height = 25
    Caption = 'Connect'
    TabOrder = 0
    OnClick = btnConnectClick
  end
  object btnDisconnect: TButton
    Left = 16
    Top = 63
    Width = 75
    Height = 25
    Caption = 'Disconnect'
    TabOrder = 1
    OnClick = btnDisconnectClick
  end
  object btnTCPPing: TButton
    Left = 16
    Top = 94
    Width = 75
    Height = 25
    Caption = 'TCP Ping'
    TabOrder = 2
    OnClick = btnTCPPingClick
  end
  object memLog: TRichEdit
    Left = 120
    Top = 32
    Width = 321
    Height = 369
    Anchors = [akLeft, akTop, akBottom]
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    ScrollBars = ssBoth
    TabOrder = 3
    Zoom = 100
  end
  object btnHTTPGet: TButton
    Left = 16
    Top = 125
    Width = 75
    Height = 25
    Caption = 'HTTP Get'
    TabOrder = 4
    OnClick = btnHTTPGetClick
  end
  object btnHTTPPost: TButton
    Left = 16
    Top = 156
    Width = 75
    Height = 25
    Caption = 'HTTP Post'
    TabOrder = 5
    OnClick = btnHTTPPostClick
  end
  object btnConnectSSL: TButton
    Left = 16
    Top = 213
    Width = 75
    Height = 25
    Caption = 'Connect'
    TabOrder = 6
    OnClick = btnConnectSSLClick
  end
  object btnDisconnectSSL: TButton
    Left = 16
    Top = 244
    Width = 75
    Height = 25
    Caption = 'Disconnect'
    TabOrder = 7
    OnClick = btnDisconnectSSLClick
  end
  object btnTCPPingSSL: TButton
    Left = 16
    Top = 275
    Width = 75
    Height = 25
    Caption = 'TCP Ping'
    TabOrder = 8
    OnClick = btnTCPPingSSLClick
  end
  object btnHTTPGetSSL: TButton
    Left = 16
    Top = 306
    Width = 75
    Height = 25
    Caption = 'HTTP Get'
    TabOrder = 9
    OnClick = btnHTTPGetSSLClick
  end
  object btnHTTPPostSSL: TButton
    Left = 16
    Top = 337
    Width = 75
    Height = 25
    Caption = 'HTTP Post'
    TabOrder = 10
    OnClick = btnHTTPPostSSLClick
  end
  object IdTCPClient1: TIdTCPClient
    ConnectTimeout = 0
    IPVersion = Id_IPv4
    Port = 8080
    ReadTimeout = -1
    Left = 496
    Top = 32
  end
  object IdTCPServer1: TIdTCPServer
    Bindings = <>
    DefaultPort = 8080
    OnExecute = IdTCPServer1Execute
    Left = 568
    Top = 32
  end
  object IdHTTP1: TIdHTTP
    AllowCookies = True
    ProxyParams.BasicAuthentication = False
    ProxyParams.ProxyPort = 0
    Request.ContentLength = -1
    Request.ContentRangeEnd = -1
    Request.ContentRangeStart = -1
    Request.ContentRangeInstanceLength = -1
    Request.Accept = 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8'
    Request.BasicAuthentication = False
    Request.UserAgent = 'Mozilla/3.0 (compatible; Indy Library)'
    Request.Ranges.Units = 'bytes'
    Request.Ranges = <>
    HTTPOptions = [hoForceEncodeParams]
    Left = 496
    Top = 80
  end
  object IdHTTPServer1: TIdHTTPServer
    Bindings = <>
    OnCommandGet = IdHTTPServer1CommandGet
    Left = 568
    Top = 80
  end
  object IdTCPClient2: TIdTCPClient
    IOHandler = IdSSLIOHandlerSocketOpenSSL1
    ConnectTimeout = 0
    IPVersion = Id_IPv4
    Port = 8081
    ReadTimeout = -1
    Left = 496
    Top = 160
  end
  object IdTCPServer2: TIdTCPServer
    Bindings = <>
    DefaultPort = 8081
    IOHandler = IdServerIOHandlerSSLOpenSSL1
    OnConnect = IdTCPServer2Connect
    OnExecute = IdTCPServer2Execute
    Left = 568
    Top = 160
  end
  object IdSSLIOHandlerSocketOpenSSL1: TIdSSLIOHandlerSocketOpenSSL
    Destination = ':8081'
    MaxLineAction = maException
    Port = 8081
    DefaultPort = 0
    SSLOptions.Mode = sslmUnassigned
    SSLOptions.VerifyMode = []
    SSLOptions.VerifyDepth = 0
    Left = 496
    Top = 208
  end
  object IdServerIOHandlerSSLOpenSSL1: TIdServerIOHandlerSSLOpenSSL
    SSLOptions.CertFile = 'SelfSigned_crt.pem'
    SSLOptions.KeyFile = 'SelfSigned_key.pem'
    SSLOptions.Mode = sslmUnassigned
    SSLOptions.VerifyMode = []
    SSLOptions.VerifyDepth = 0
    Left = 568
    Top = 208
  end
  object IdHTTP2: TIdHTTP
    IOHandler = IdSSLIOHandlerSocketOpenSSL2
    AllowCookies = True
    ProxyParams.BasicAuthentication = False
    ProxyParams.ProxyPort = 0
    Request.ContentLength = -1
    Request.ContentRangeEnd = -1
    Request.ContentRangeStart = -1
    Request.ContentRangeInstanceLength = -1
    Request.Accept = 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8'
    Request.BasicAuthentication = False
    Request.UserAgent = 'Mozilla/3.0 (compatible; Indy Library)'
    Request.Ranges.Units = 'bytes'
    Request.Ranges = <>
    HTTPOptions = [hoForceEncodeParams]
    Left = 496
    Top = 280
  end
  object IdHTTPServer2: TIdHTTPServer
    Bindings = <>
    DefaultPort = 443
    IOHandler = IdServerIOHandlerSSLOpenSSL2
    OnCommandGet = IdHTTPServer2CommandGet
    Left = 568
    Top = 280
  end
  object IdSSLIOHandlerSocketOpenSSL2: TIdSSLIOHandlerSocketOpenSSL
    MaxLineAction = maException
    Port = 0
    DefaultPort = 0
    SSLOptions.Mode = sslmUnassigned
    SSLOptions.VerifyMode = []
    SSLOptions.VerifyDepth = 0
    Left = 496
    Top = 328
  end
  object IdServerIOHandlerSSLOpenSSL2: TIdServerIOHandlerSSLOpenSSL
    SSLOptions.CertFile = 'SelfSigned_crt.pem'
    SSLOptions.KeyFile = 'SelfSigned_key.pem'
    SSLOptions.Mode = sslmUnassigned
    SSLOptions.VerifyMode = []
    SSLOptions.VerifyDepth = 0
    Left = 568
    Top = 328
  end
end
