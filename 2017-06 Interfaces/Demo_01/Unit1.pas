unit Unit1;

// Demo 1
//
// Implement interfaces using descendants of TInterfacedObject
// Use the Supports method to determine the interfaces implemented by a class
// Use the "as" operator or the Supports method to determine the interfaces implemented by an instance of a class

interface

uses
  System.Classes, Vcl.Controls, Vcl.Forms, Vcl.StdCtrls;

type
  IRidable = interface
  ['{120D7A31-396F-40AD-98D1-933E4E74C612}']
    function MaxPassengers: Integer;
  end;

  IFlying = interface
  ['{01FE341D-280A-4533-83CB-E96869CAA657}']
    function MaxAltitude: Integer;
  end;

  TVehicle = class(TInterfacedObject,IRidable)
  protected
    function MaxPassengers: Integer; virtual; abstract;
  end;

  TBalloon = class(TVehicle,IFlying)
  protected
    function MaxPassengers: Integer; override;
    function MaxAltitude: Integer;
  end;

  TBicycle = class(TVehicle)
  protected
    function MaxPassengers: Integer; override;
  end;

  TMagicCarpet = class(TVehicle,IFlying)
  protected
    function MaxPassengers: Integer; override;
    function MaxAltitude: Integer;
  end;

  TTrain = class(TVehicle)
  protected
    function MaxPassengers: Integer; override;
  end;

  TAnimal = class(TInterfacedObject);

  TDragon = class(TAnimal,IRidable,IFlying)
  protected
    function MaxPassengers: Integer;
    function MaxAltitude: Integer;
  end;

  THorse = class(TAnimal,IRidable)
  protected
    function MaxPassengers: Integer;
  end;

  TPigeon = class(TAnimal,IFlying)
  protected
    function MaxAltitude: Integer;
  end;

  TRat = class(TAnimal);

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Memo1: TMemo;
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

uses
  System.SysUtils;

const
  AllTheThings: TArray<TInterfacedClass> = [TBalloon,TBicycle,TDragon,THorse,TMagicCarpet,TPigeon,TRat,TTrain];

{ TBalloon }

function TBalloon.MaxPassengers: Integer;
begin
  Result := 10;
end;

function TBalloon.MaxAltitude: Integer;
begin
  Result := 3000;
end;

{ TBicycle }

function TBicycle.MaxPassengers: Integer;
begin
  Result := 2;
end;

{ TMagicCarpet }

function TMagicCarpet.MaxPassengers: Integer;
begin
  Result := 4;
end;

function TMagicCarpet.MaxAltitude: Integer;
begin
  Result := 4000;
end;

{ TTrain }
function TTrain.MaxPassengers: Integer;
begin
  Result := 400;
end;

{ TDragon }
function TDragon.MaxPassengers: Integer;
begin
  Result := 6;
end;

function TDragon.MaxAltitude: Integer;
begin
  Result := 2000;
end;

{ THorse }

function THorse.MaxPassengers: Integer;
begin
  Result := 2;
end;

{ TPigeon }

function TPigeon.MaxAltitude: Integer;
begin
  Result := 500;
end;

{ TForm1 }

procedure TForm1.Button1Click(Sender: TObject);
var
  lThing: TClass;
begin
  Memo1.Lines.Clear;
  for lThing in AllTheThings do
  begin
    if Supports(lThing,IRidable) then
      Memo1.Lines.Add(lThing.ClassName + ' can be ridden');
    if Supports(lThing,IFlying) then
      Memo1.Lines.Add(lThing.ClassName + ' can fly');
  end;
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  lThing: TInterfacedClass;
  lInterface: IInterface;
  lLine: string;
begin
  Memo1.Lines.Clear;
  for lThing in AllTheThings do
  begin
    lInterface := lThing.Create;
    try
      // IRidable
      try
        lLine := lThing.ClassName + ' can have ' + (lInterface as IRidable).MaxPassengers.ToString + ' passengers';
      except
        on E: EIntfCastError do
          lLine := lThing.ClassName + ' cannot have passengers'
        else
          raise;
      end;
      Memo1.Lines.Add(lLine);
      // IFlying
      try
        lLine := lThing.ClassName + ' can fly up to ' + (lInterface as IFlying).MaxAltitude.ToString + ' meters';
      except
        on E: EIntfCastError do
          lLine := lThing.ClassName + ' cannot fly'
        else
          raise;
      end;
      Memo1.Lines.Add(lLine);
    finally
      lInterface := nil;
    end;
  end;
end;

procedure TForm1.Button3Click(Sender: TObject);
var
  lThing: TInterfacedClass;
  lInterface: IInterface;
  lRidable: IRidable;
  lFlying: IFlying;
begin
  Memo1.Lines.Clear;
  for lThing in AllTheThings do
  begin
    lInterface := lThing.Create;
    try
      // IRidable
      if Supports(lInterface,IRidable,lRidable) then
        Memo1.Lines.Add(lThing.ClassName + ' can have ' + lRidable.MaxPassengers.ToString + ' passengers')
      else
        Memo1.Lines.Add(lThing.ClassName + ' cannot have passengers');
      // IFlying
      if Supports(lInterface,IFlying,lFlying) then
        Memo1.Lines.Add(lThing.ClassName + ' can fly up to ' + lFlying.MaxAltitude.ToString + ' meters')
      else
        Memo1.Lines.Add(lThing.ClassName + ' cannot fly');
    finally
      lInterface := nil;
    end;
  end;
end;

end.
