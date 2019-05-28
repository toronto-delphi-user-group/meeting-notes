unit Unit1;

// Demo 8
//
// Use runtime type information, IInvokable and TVirtualInterface to bind an implementation to an interface at runtime

interface

uses
  System.Classes, System.Rtti, Vcl.Controls, Vcl.Forms, Vcl.StdCtrls;

type
  IMyInterface = interface(IInvokable)
  ['{B648C732-7078-4C68-B3F5-2460CC021214}']
    procedure Upper(const AString: string);
    procedure Lower(const AString: string);
    procedure Reverse(const AString: string);
    procedure Clear;
  end;

  TForm1 = class(TForm)
    Label1: TLabel;
    Edit1: TEdit;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Memo1: TMemo;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
  private
    FInvokable: IMyInterface;
    procedure OnInvoke(Method: TRttiMethod; const Args: TArray<TValue>; out Result: TValue);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

uses
  System.SysUtils, System.StrUtils;

{ TForm1 }

constructor TForm1.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Supports(TVirtualInterface.Create(TypeInfo(IMyInterface),OnInvoke),IMyInterface,FInvokable);
end;

destructor TForm1.Destroy;
begin
  FInvokable := nil;
  inherited Destroy;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  FInvokable.Upper(Edit1.Text);
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  FInvokable.Lower(Edit1.Text);
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  FInvokable.Reverse(Edit1.Text);
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
  FInvokable.Clear;
end;

procedure TForm1.OnInvoke(Method: TRttiMethod; const Args: TArray<TValue>; out Result: TValue);
begin
  if SameText(Method.Name,'Upper') then
    Memo1.Lines.Add(Args[1].ToString.ToUpper)
  else if SameText(Method.Name,'Lower') then
    Memo1.Lines.Add(Args[1].ToString.ToLower)
  else if SameText(Method.Name,'Reverse') then
    Memo1.Lines.Add(ReverseString(Args[1].ToString))
  else if SameText(Method.Name,'Clear') then
    Memo1.Lines.Clear;
end;

end.
