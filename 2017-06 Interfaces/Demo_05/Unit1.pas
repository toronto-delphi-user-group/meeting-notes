unit Unit1;

// Demo 5
//
// Demonstrate another way to get around the reference counting problem shown in Demo 3
// This example is the same as Demo 4, but uses the [weak] attribute instead of a function call
// Only newer versions of Delphi support the [weak] attribute for all compilers

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

  TParent = class(TInterfacedObject,IParent)
  private
    FChild: IChild;
  protected
    procedure QueryChild;
    function WhatsMyName: string;
  public
    constructor Create;
    destructor Destroy; override;
  end;

  TChild = class(TInterfacedObject,IChild)
  private
    [weak]
    FParent: IParent;
  protected
    procedure WhosYourDaddy;
  public
    constructor Create(const AParent: IParent);
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
  FChild := TChild.Create(Self);
end;

destructor TParent.Destroy;
begin
  FChild := nil;
  ShowMessage('destroying parent');
  inherited Destroy;
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

constructor TChild.Create(const AParent: IParent);
begin
  inherited Create;
  ShowMessage('creating child');
  FParent := AParent;
end;

destructor TChild.Destroy;
begin
  FParent := nil;
  ShowMessage('destroying child');
  inherited Destroy;
end;

procedure TChild.WhosYourDaddy;
begin
  ShowMessage('My daddy is ' + FParent.WhatsMyName);
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
