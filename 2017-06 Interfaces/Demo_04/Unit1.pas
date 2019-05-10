unit Unit1;

// Demo 4
//
// Demonstrate one way to get around the reference counting problem shown in Demo 3
// The child object accesses the parent object through a function call rather than an interface reference
// This can be used in older versions of Delphi that do not support the [weak] attribute (see Demo 5)

interface

uses
  System.Classes, Vcl.Controls, Vcl.Forms, Vcl.StdCtrls;

type
  IParent = interface
  ['{C91BE670-ED7E-4A27-B396-A04FD741E4BF}']
    procedure QueryChild;
    function WhatsMyName: string;
  end;

  IChild = interface
  ['{9DE35E8D-0E1F-45A5-98E0-60AEABDF79A8}']
    procedure WhosYourDaddy;
  end;

  TGetParentEvent = procedure(var AParent: IParent) of object;

  TParent = class(TInterfacedObject,IParent)
  private
    FChild: IChild;
    procedure OnGetParent(var AParent: IParent);
  protected
    procedure QueryChild;
    function WhatsMyName: string;
  public
    constructor Create;
    destructor Destroy; override;
  end;

  TChild = class(TInterfacedObject,IChild)
  private
    FOnGetParent: TGetParentEvent;
    function GetParentInterface: IParent;
  protected
    procedure WhosYourDaddy;
  public
    constructor Create(const AOnGetParent: TGetParentEvent);
    destructor Destroy; override;
  end;

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    FInstance: IParent;
  public
    destructor Destroy; override;
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

uses
  Vcl.Dialogs;

{ TParent }

constructor TParent.Create;
begin
  inherited Create;
  ShowMessage('creating parent');
  FChild := TChild.Create(OnGetParent);
end;

destructor TParent.Destroy;
begin
  FChild := nil;
  ShowMessage('destroying parent');
  inherited Destroy;
end;

procedure TParent.OnGetParent(var AParent: IParent);
begin
  AParent := Self;
end;

procedure TParent.QueryChild;
begin
  FChild.WhosYourDaddy;
end;

function TParent.WhatsMyName: string;
begin
  Result := 'Darth Vader';
end;

{ TChild }

constructor TChild.Create(const AOnGetParent: TGetParentEvent);
begin
  inherited Create;
  ShowMessage('creating child');
  FOnGetParent := AOnGetParent;
end;

destructor TChild.Destroy;
begin
  FOnGetParent := nil;
  ShowMessage('destroying child');
  inherited Destroy;
end;

function TChild.GetParentInterface: IParent;
begin
  if Assigned(FOnGetParent) then
    FOnGetParent(Result);
end;

procedure TChild.WhosYourDaddy;
begin
  ShowMessage('My daddy is ' + GetParentInterface.WhatsMyName);
end;

{ TForm1 }

destructor TForm1.Destroy;
begin
  FInstance := nil;
  inherited Destroy;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  FInstance := TParent.Create;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  if (FInstance <> nil) then
    FInstance.QueryChild;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  FInstance := nil;
end;

end.
