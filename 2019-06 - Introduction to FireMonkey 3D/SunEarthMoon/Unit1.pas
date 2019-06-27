unit Unit1;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.Viewport3D, System.Math.Vectors,
  FMX.MaterialSources, FMX.Ani, FMX.Objects3D, FMX.Controls3D;

type
  TForm1 = class(TForm)
    Viewport3D1: TViewport3D;
    Panel1: TPanel;
    rbTraditional: TRadioButton;
    rbNonTraditional: TRadioButton;
    Dummy1: TDummy;
    dskFlatEarth: TDisk;
    sphFlatEarthMoon: TSphere;
    sphFlatEarthSun: TSphere;
    sphSun: TSphere;
    FloatAnimation1: TFloatAnimation;
    sphEarth: TSphere;
    mtlSun: TTextureMaterialSource;
    mtlEarth: TTextureMaterialSource;
    mtlFlatEarth: TTextureMaterialSource;
    mtlMoon: TTextureMaterialSource;
    sphMoon: TSphere;
    Timer1: TTimer;
    Grid3D1: TGrid3D;
    btnReset: TButton;
    procedure Timer1Timer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure rbChange(Sender: TObject);
    procedure FloatAnimation1Process(Sender: TObject);
    procedure Viewport3D1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure Viewport3D1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Single);
    procedure btnResetClick(Sender: TObject);
  private
    FClickPoint: TPointF;
    FAngle: Double;
    procedure UpdateDisplay;
  public
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}


// TForm1
// ============================================================================
procedure TForm1.FormCreate(Sender: TObject);
begin
  dskFlatEarth.Position.X := 0;
  UpdateDisplay;
end;

// ----------------------------------------------------------------------------
procedure TForm1.btnResetClick(Sender: TObject);
begin
  Dummy1.RotationAngle.Point := TPoint3D.Zero;
end;

// ----------------------------------------------------------------------------
procedure TForm1.FloatAnimation1Process(Sender: TObject);
begin
  sphEarth.RotationAngle.Y := sphSun.RotationAngle.Y;
  sphMoon.RotationAngle.Y := sphSun.RotationAngle.Y;
end;

// ----------------------------------------------------------------------------
procedure TForm1.rbChange(Sender: TObject);
begin
  UpdateDisplay;
end;

// ----------------------------------------------------------------------------
procedure TForm1.Timer1Timer(Sender: TObject);
const
  FlatEarthRadius = 5.5;
  EarthRadius = 9;
  MoonRadius = 3;
begin
  FAngle := FAngle + 0.01;
  sphEarth.Position.X := sphSun.Position.X + cos(FAngle) * EarthRadius;
  sphEarth.Position.Z := sphSun.Position.Z + sin(FAngle) * EarthRadius;

  sphMoon.Position.X := sphEarth.Position.X + cos(FAngle * (365 / 88)) * MoonRadius;
  sphMoon.Position.Z := sphEarth.Position.Z + sin(FAngle * (365 / 88)) * MoonRadius;


  sphFlatEarthSun.Position.X := cos(FAngle) * FlatEarthRadius;
  sphFlatEarthSun.Position.Z := sin(FAngle) * FlatEarthRadius;

  sphFlatEarthMoon.Position.X := cos(FAngle) * FlatEarthRadius * -1;
  sphFlatEarthMoon.Position.Z := sin(FAngle) * FlatEarthRadius * -1;
end;

// ----------------------------------------------------------------------------
procedure TForm1.UpdateDisplay;
begin
  sphSun.Visible := rbTraditional.IsChecked;
  sphEarth.Visible := rbTraditional.IsChecked;
  sphMoon.Visible := rbTraditional.IsChecked;
  dskFlatEarth.Visible := rbNonTraditional.IsChecked;
end;

// ----------------------------------------------------------------------------
procedure TForm1.Viewport3D1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Single);
begin
  FClickPoint := PointF(X, Y);
end;

// ----------------------------------------------------------------------------
procedure TForm1.Viewport3D1MouseMove(Sender: TObject; Shift: TShiftState; X, Y: Single);
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
