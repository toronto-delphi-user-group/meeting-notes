unit Unit1;

// Demo 7
//
// Demonstrate how to disambiguate between implementations when implementing interfaces that contain identical methods

interface

uses
  System.Classes, Vcl.Controls, Vcl.Forms, Vcl.StdCtrls;

type
  IMyInterface = interface
  ['{F8C9DDAA-A988-45D5-8B89-F901891D2F71}']
    procedure Foo;
  end;

  IMyOtherInterface = interface
  ['{3458F642-6860-4623-8EBC-986C67E45693}']
    procedure Foo;
  end;

  TMyClass = class(TInterfacedObject,IMyInterface,IMyOtherInterface)
  private
    procedure MyFoo;
    procedure MyOtherFoo;
  protected
    procedure IMyInterface.Foo = MyFoo;
    procedure IMyOtherInterface.Foo = MyOtherFoo;
  end;

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

uses
  Vcl.Dialogs;

{ TMyClass }


procedure TMyClass.MyFoo;
begin
  ShowMessage('Foo!');
end;

procedure TMyClass.MyOtherFoo;
begin
  ShowMessage('Other Foo!');
end;

{ TForm1 }

procedure TForm1.Button1Click(Sender: TObject);
begin
  (TMyClass.Create as IMyInterface).Foo;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  (TMyClass.Create as IMyOtherInterface).Foo;
end;

end.
