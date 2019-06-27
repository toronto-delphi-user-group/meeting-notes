unit Unit1;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms3D, FMX.Types3D, FMX.Forms, FMX.Graphics,
  FMX.Dialogs, System.Math.Vectors, FMX.MaterialSources, FMX.Objects3D,
  FMX.Controls3D;

type
  TForm1 = class(TForm3D)
    Dummy1: TDummy;
    Sphere1: TSphere;
    Cylinder1: TCylinder;
    Cone1: TCone;
    Sphere2: TSphere;
    TextureMaterialSource1: TTextureMaterialSource;
    ColorMaterialSource1: TColorMaterialSource;
    procedure ShapeMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single; RayPos, RayDir: TVector3D);
  private
  public
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}

procedure TForm1.ShapeMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Single; RayPos, RayDir: TVector3D);
var
  p: TPoint3D;
begin
  (Sender as TControl3D).RayCastIntersect(RayPos, RayDir, p);
  Sphere2.Position.Point := p;
end;

end.
