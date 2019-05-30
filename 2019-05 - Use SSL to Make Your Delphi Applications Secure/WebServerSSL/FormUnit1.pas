unit FormUnit1;

interface

uses
  Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.AppEvnts, Vcl.StdCtrls, IdHTTPWebBrokerBridge, Web.HTTPApp;

type
  TForm3 = class(TForm)
    ButtonStart: TButton;
    ButtonStop: TButton;
    EditPort: TEdit;
    Label1: TLabel;
    ApplicationEvents1: TApplicationEvents;
    ButtonOpenBrowser: TButton;
    procedure FormCreate(Sender: TObject);
    procedure ApplicationEvents1Idle(Sender: TObject; var Done: Boolean);
    procedure ButtonStartClick(Sender: TObject);
    procedure ButtonStopClick(Sender: TObject);
    procedure ButtonOpenBrowserClick(Sender: TObject);
  private
    FServer: TIdHTTPWebBrokerBridge;
    procedure StartServer;
    procedure OnGetSSLPassword(var APassword: String);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form3: TForm3;

implementation

{$R *.dfm}

uses
  IdSSLOpenSSL,
  WinApi.Windows, Winapi.ShellApi;

procedure TForm3.ApplicationEvents1Idle(Sender: TObject; var Done: Boolean);
begin
  ButtonStart.Enabled := not FServer.Active;
  ButtonStop.Enabled := FServer.Active;
  EditPort.Enabled := not FServer.Active;
end;

procedure TForm3.ButtonOpenBrowserClick(Sender: TObject);
var
  LURL: string;
begin
  StartServer;
  // TODO: Replace "localhost" with local IP address
  LURL := Format('https://localhost:%s', [EditPort.Text]);
  ShellExecute(0,
        nil,
        PChar(LURL), nil, nil, SW_SHOWNOACTIVATE);
end;

procedure TForm3.ButtonStartClick(Sender: TObject);
begin
  StartServer;
end;

procedure TForm3.ButtonStopClick(Sender: TObject);
begin
  FServer.Active := False;
  FServer.Bindings.Clear;
end;

procedure TForm3.FormCreate(Sender: TObject);
var
  LIOHandleSSL: TIdServerIOHandlerSSLOpenSSL;
begin
  FServer := TIdHTTPWebBrokerBridge.Create(Self);
  LIOHandleSSL := TIdServerIOHandlerSSLOpenSSL.Create(FServer);
  LIOHandleSSL.SSLOptions.CertFile := 'SelfSigned_crt.pem';
  LIOHandleSSL.SSLOptions.RootCertFile := '';
  LIOHandleSSL.SSLOptions.KeyFile := 'SelfSigned_key.pem';
  LIOHandleSSL.OnGetPassword := OnGetSSLPassword;
  FServer.IOHandler := LIOHandleSSL;
end;

procedure TForm3.OnGetSSLPassword(var APassword: String);
begin
  APassword := '';
end;

procedure TForm3.StartServer;
begin
  if not FServer.Active then
  begin
    FServer.Bindings.Clear;
    FServer.DefaultPort := StrToInt(EditPort.Text);
    FServer.Active := True;
  end;
end;

end.
