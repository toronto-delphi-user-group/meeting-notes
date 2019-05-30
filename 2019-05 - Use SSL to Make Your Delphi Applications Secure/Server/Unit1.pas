unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, IdCustomTCPServer,
  IdTCPServer, IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient,
  Vcl.ComCtrls, IdContext, IdCustomHTTPServer, IdHTTPServer, IdHTTP,
  IdServerIOHandler, IdSSL, IdSSLOpenSSL, IdIOHandler, IdIOHandlerSocket,
  IdIOHandlerStack;

type
  TForm1 = class(TForm)
    IdTCPClient1: TIdTCPClient;
    IdTCPServer1: TIdTCPServer;
    btnConnect: TButton;
    btnDisconnect: TButton;
    btnTCPPing: TButton;
    Label1: TLabel;
    Label2: TLabel;
    memLog: TRichEdit;
    IdHTTP1: TIdHTTP;
    IdHTTPServer1: TIdHTTPServer;
    btnHTTPGet: TButton;
    btnHTTPPost: TButton;
    btnConnectSSL: TButton;
    btnDisconnectSSL: TButton;
    btnTCPPingSSL: TButton;
    btnHTTPGetSSL: TButton;
    btnHTTPPostSSL: TButton;
    IdTCPClient2: TIdTCPClient;
    IdTCPServer2: TIdTCPServer;
    IdSSLIOHandlerSocketOpenSSL1: TIdSSLIOHandlerSocketOpenSSL;
    IdServerIOHandlerSSLOpenSSL1: TIdServerIOHandlerSSLOpenSSL;
    IdHTTP2: TIdHTTP;
    IdHTTPServer2: TIdHTTPServer;
    IdSSLIOHandlerSocketOpenSSL2: TIdSSLIOHandlerSocketOpenSSL;
    IdServerIOHandlerSSLOpenSSL2: TIdServerIOHandlerSSLOpenSSL;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnConnectClick(Sender: TObject);
    procedure btnDisconnectClick(Sender: TObject);
    procedure btnTCPPingClick(Sender: TObject);
    procedure IdTCPServer1Execute(AContext: TIdContext);
    procedure IdHTTPServer1CommandGet(AContext: TIdContext;
      ARequestInfo: TIdHTTPRequestInfo; AResponseInfo: TIdHTTPResponseInfo);
    procedure btnHTTPGetClick(Sender: TObject);
    procedure btnHTTPPostClick(Sender: TObject);
    procedure IdTCPServer2Connect(AContext: TIdContext);
    procedure IdTCPServer2Execute(AContext: TIdContext);
    procedure btnConnectSSLClick(Sender: TObject);
    procedure btnDisconnectSSLClick(Sender: TObject);
    procedure btnTCPPingSSLClick(Sender: TObject);
    procedure btnHTTPGetSSLClick(Sender: TObject);
    procedure IdHTTPServer2CommandGet(AContext: TIdContext;
      ARequestInfo: TIdHTTPRequestInfo; AResponseInfo: TIdHTTPResponseInfo);
    procedure btnHTTPPostSSLClick(Sender: TObject);
  private
    FServerHost: string;
    procedure Log(const AMsg: string);
    procedure UpdateDisplay;
  public
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}


// ============================================================================
procedure TForm1.FormCreate(Sender: TObject);
begin
  // TODO: Replace "localhost" with local IP address
  FServerHost := 'localhost';

  IdTCPServer1.Active := True;
  IdHTTPServer1.Active := True;
  IdTCPClient1.Host := FServerHost;

  IdTCPServer2.Active := True;
  IdHTTPServer2.Active := True;
  IdTCPClient2.Host := FServerHost;

  UpdateDisplay;
end;

// ----------------------------------------------------------------------------
procedure TForm1.FormDestroy(Sender: TObject);
begin
  IdTCPServer1.Active := False;
  IdHTTPServer1.Active := False;
  IdTCPServer2.Active := False;
  IdHTTPServer2.Active := False;
end;

// ----------------------------------------------------------------------------
procedure TForm1.IdHTTPServer1CommandGet(AContext: TIdContext;
  ARequestInfo: TIdHTTPRequestInfo; AResponseInfo: TIdHTTPResponseInfo);
begin
  AResponseInfo.ContentText := 'VerySecretInformation';
end;

// ----------------------------------------------------------------------------
procedure TForm1.IdHTTPServer2CommandGet(AContext: TIdContext;
  ARequestInfo: TIdHTTPRequestInfo; AResponseInfo: TIdHTTPResponseInfo);
begin
  AResponseInfo.ContentText := 'VerySecretInformation (ssl)';
end;

// ----------------------------------------------------------------------------
procedure TForm1.IdTCPServer1Execute(AContext: TIdContext);
var
  s: string;
begin
  s := AContext.Connection.IOHandler.ReadLn;
  if SameText('ping', s) then
    AContext.Connection.IOHandler.WriteLn('pong');
end;

// ----------------------------------------------------------------------------
procedure TForm1.IdTCPServer2Connect(AContext: TIdContext);
begin
  // These two lines are required to get SSL to work.
  if (AContext.Connection.IOHandler is TIdSSLIOHandlerSocketBase) then
    TIdSSLIOHandlerSocketBase(AContext.Connection.IOHandler).PassThrough := False;
end;

// ----------------------------------------------------------------------------
procedure TForm1.IdTCPServer2Execute(AContext: TIdContext);
var
  s: string;
begin
  s := AContext.Connection.IOHandler.ReadLn;
  if SameText('ping', s) then
    AContext.Connection.IOHandler.WriteLn('pong (ssl)');
end;

// ----------------------------------------------------------------------------
procedure TForm1.btnConnectClick(Sender: TObject);
begin
  IdTCPClient1.Connect;

  UpdateDisplay;
end;

// ----------------------------------------------------------------------------
procedure TForm1.btnConnectSSLClick(Sender: TObject);
begin
  IdTCPClient2.Connect;

  UpdateDisplay;
end;

// ----------------------------------------------------------------------------
procedure TForm1.btnDisconnectClick(Sender: TObject);
begin
  IdTCPClient1.Disconnect;

  UpdateDisplay;
end;

// ----------------------------------------------------------------------------
procedure TForm1.btnDisconnectSSLClick(Sender: TObject);
begin
  IdTCPClient2.Disconnect;

  UpdateDisplay;
end;

// ----------------------------------------------------------------------------
procedure TForm1.btnHTTPGetClick(Sender: TObject);
var
  s: string;
begin
  Log('HTTP Send: get');
  s := IdHTTP1.Get('http://' + FServerHost);
  Log('HTTP Recv: ' + s);
end;

// ----------------------------------------------------------------------------
procedure TForm1.btnHTTPGetSSLClick(Sender: TObject);
var
  s: string;
begin
  Log('HTTP Send: get');
  s := IdHTTP2.Get('https://' + FServerHost);
  Log('HTTP Recv: ' + s);
end;

// ----------------------------------------------------------------------------
procedure TForm1.btnHTTPPostClick(Sender: TObject);
var
  s: string;
  LParams: TStringList;
begin
  LParams := TStringList.Create;
  try
    LParams.Add('username=SomeUser');
    LParams.Add('password=SomePass');
    Log('HTTP Send: post');
    s := IdHTTP1.Post('http://' + FServerHost, LParams);
    Log('HTTP Recv: ' + s);
  finally
    LParams.Free;
  end;
end;

// ----------------------------------------------------------------------------
procedure TForm1.btnHTTPPostSSLClick(Sender: TObject);
var
  s: string;
  LParams: TStringList;
begin
  LParams := TStringList.Create;
  try
    LParams.Add('username=SomeUser');
    LParams.Add('password=SomePass');
    Log('HTTP Send: post');
    s := IdHTTP2.Post('https://' + FServerHost, LParams);
    Log('HTTP Recv: ' + s);
  finally
    LParams.Free;
  end;
end;

// ----------------------------------------------------------------------------
procedure TForm1.btnTCPPingClick(Sender: TObject);
var
  s: string;
begin
  Log('TCP Send: ping');
  IdTCPClient1.IOHandler.WriteLn('ping');
  s := IdTCPClient1.IOHandler.ReadLn;
  Log('TCP recv: ' + s)
end;

// ----------------------------------------------------------------------------
procedure TForm1.btnTCPPingSSLClick(Sender: TObject);
var
  s: string;
begin
  Log('TCP Send: ping');
  IdTCPClient2.IOHandler.WriteLn('ping');
  s := IdTCPClient2.IOHandler.ReadLn;
  Log('TCP recv: ' + s)
end;

// ----------------------------------------------------------------------------
procedure TForm1.Log(const AMsg: string);
begin
  memLog.Lines.Add(AMsg);
end;

// ----------------------------------------------------------------------------
procedure TForm1.UpdateDisplay;
begin
  btnConnect.Enabled := not IdTCPClient1.Connected;
  btnDisconnect.Enabled := IdTCPClient1.Connected;
  btnTCPPing.Enabled := IdTCPClient1.Connected;

  btnConnectSSL.Enabled := not IdTCPClient2.Connected;
  btnDisconnectSSL.Enabled := IdTCPClient2.Connected;
  btnTCPPingSSL.Enabled := IdTCPClient2.Connected;
end;

end.
