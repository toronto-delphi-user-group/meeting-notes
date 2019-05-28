unit Unit1;

// Demo 9
//
// Demonstrate a potential pitfall when using interfaces with generics
// The Supports method used the GUID signature to identify an interface, so it can't distinguish between IList<string> and IList<Integer>
// The Spring4d framework (https://bitbucket.org/sglienke/spring4d) is required to compile this demo

interface

uses
  System.Classes, Vcl.Controls, Vcl.Forms, Vcl.StdCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Memo1: TMemo;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    FStrings: IInterface;
    FIntegers: IInterface;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

uses
  System.SysUtils, Spring.Collections, Spring.Collections.Lists;

{ TForm1 }

constructor TForm1.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FStrings  := TList<string>.Create(['a','b','c','d','e']);
  FIntegers := TList<Integer>.Create([1,2,3,4,5]);
end;

destructor TForm1.Destroy;
begin
  FStrings  := nil;
  FIntegers := nil;
  inherited Destroy;
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  lStrings: IList<string>;
  lString: string;
begin
  Memo1.Lines.Clear;
  if Supports(FStrings,IList<string>,lStrings) then
  begin
    for lString in lStrings do
      Memo1.Lines.Add(lString);
  end;
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  lStrings: IList<string>;
  lString: string;
begin
  Memo1.Lines.Clear;
  if Supports(FIntegers,IList<string>,lStrings) then
  begin
    for lString in lStrings do
      Memo1.Lines.Add(lString);
  end;
end;

end.
