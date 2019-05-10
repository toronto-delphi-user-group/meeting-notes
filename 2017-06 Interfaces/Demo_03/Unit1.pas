unit Unit1;

// Demo 3
//
// Demonstrate potential pitfall when using automatic reference counting
// Parent and child objects are not destroyed because they retain references to each other

interface

uses
  System.Classes, Vcl.Controls, Vcl.Forms, Vcl.StdCtrls;

type
  TParent = class(TInterfacedObject)
  private
    FChild: IInterface;
  public
    constructor Create;
    destructor Destroy; override;
  end;

  TChild = class(TInterfacedObject)
  private
    FParent: IInterface;
  public
    constructor Create(const AParent: IInterface);
    destructor Destroy; override;
  end;

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    FInstance: IInterface;
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

{ TChild }

constructor TChild.Create(const AParent: IInterface);
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
  FInstance := nil;
end;

end.
