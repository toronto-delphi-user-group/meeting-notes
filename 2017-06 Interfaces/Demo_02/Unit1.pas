unit Unit1;

// Demo 2
//
// Demonstrate automatic reference counting in TInterfacedObject

interface

uses
  System.Classes, Vcl.Controls, Vcl.Forms, Vcl.StdCtrls;

type
  TMyClass = class(TInterfacedObject)
  public
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

{ TMyClass }

destructor TMyClass.Destroy;
begin
  ShowMessage('bye bye');
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
  FInstance := TMyClass.Create;
  ShowMessage('class instantiated');
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  FInstance := nil;
end;

end.
