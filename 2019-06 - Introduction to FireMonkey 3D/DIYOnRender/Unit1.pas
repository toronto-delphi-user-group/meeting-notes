unit Unit1;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms3D, FMX.Types3D, FMX.Forms, FMX.Graphics,
  FMX.Dialogs, FMX.Controls3D, FMX.Objects3D,
  System.Math.Vectors;

type
  TForm1 = class(TForm3D)
    Dummy1: TDummy;
    Grid3D1: TGrid3D;
    procedure Dummy1Render(Sender: TObject; Context: TContext3D);
    procedure Form3DMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure Form3DMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Single);
  private
    FClickPoint: TPointF;
  public
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}


// ----------------------------------------------------------------------------
procedure TForm1.Dummy1Render(Sender: TObject; Context: TContext3D);
begin
  Context.DrawCube(
    TPoint3D.Create(1, 1, 1),
    TPoint3D.Create(5, 5, 5),
    1,
    TAlphaColorRec.Black);

  Context.DrawCube(
    TPoint3D.Create(2, 2, 2),
    TPoint3D.Create(4, 4, 4),
    1,
    TAlphaColorRec.Blue);

  Context.DrawCube(
    TPoint3D.Create(3, 3, 3),
    TPoint3D.Create(3, 3, 3),
    1,
    TAlphaColorRec.Red);
end;

// ----------------------------------------------------------------------------
procedure TForm1.Form3DMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Single);
begin
  FClickPoint := PointF(X, Y);
end;

// ----------------------------------------------------------------------------
procedure TForm1.Form3DMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Single);
const
  ROTATION_STEP = 0.3;
begin
  if (ssLeft in Shift) then
  begin
    Dummy1.RotationAngle.X := Dummy1.RotationAngle.X + ((Y - FClickPoint.Y) * ROTATION_STEP);
    Dummy1.RotationAngle.Y := Dummy1.RotationAngle.Y - ((X - FClickPoint.X) * ROTATION_STEP);
    FClickPoint := PointF(X, Y);
  end;
end;

end.
