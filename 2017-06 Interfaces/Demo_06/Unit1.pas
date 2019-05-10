unit Unit1;

// Demo 6
//
// Demonstrate interface aggregation
// The interface is implemented by a descendent of TAggregatedObject that is contained in an instance of TInterfacedObject
// Re-use of the inner object can reduce code duplication

interface

uses
  System.Classes, Vcl.Controls, Vcl.Forms, Vcl.StdCtrls;

type
  IMyInterface = interface
  ['{DC52CFF7-51C7-47AB-BE71-093BC593032D}']
    procedure DoTheThing;
  end;

  TInnerClass = class(TAggregatedObject)
  public
    procedure DoTheThing;
  end;

  TOuterClass = class(TInterfacedObject,IMyInterface)
  private
    FImplementor: TInnerClass;
    property Implementor: TInnerClass read FImplementor implements IMyInterface;
  public
    constructor Create;
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
    FInstance: IMyInterface;
  public
    destructor Destroy; override;
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

uses
  Vcl.Dialogs;

{ TInnerClass }

procedure TInnerClass.DoTheThing;
begin
  ShowMessage('I did the thing!');
end;

{ TOuterClass }

constructor TOuterClass.Create;
begin
  inherited Create;
  ShowMessage('instantiating objects');
  FImplementor := TInnerClass.Create(Self);
end;

destructor TOuterClass.Destroy;
begin
  FImplementor.Free;
  ShowMessage('destroying classes');
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
  FInstance := TOuterClass.Create;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  if (FInstance <> nil) then
    FInstance.DoTheThing;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  FInstance := nil;
end;

end.
