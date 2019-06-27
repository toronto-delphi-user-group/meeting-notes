unit Unit1;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms3D, FMX.Types3D, FMX.Forms, FMX.Graphics,
  FMX.Dialogs, System.Math.Vectors, FMX.Ani, FMX.Objects3D, FMX.Controls3D,
  FMX.MaterialSources, FMX.StdCtrls, FMX.Controls.Presentation, FMX.Layers3D;

type
  TForm1 = class(TForm3D)
    Dummy1: TDummy;

    sph00Sol: TSphere;
    sph01Mercury: TSphere;
    sph02Venus: TSphere;
    sph03Earth: TSphere;
    sph03Luna: TSphere;
    sph04Mars: TSphere;
    sph05Jupiter: TSphere;
    sph06Saturn: TSphere;
    dskSaturnRings: TDisk;
    sph07Uranus: TSphere;
    dskUranusRings: TDisk;
    sph08Neptune: TSphere;
    sph09Pluto: TSphere;
    mtl00Sol: TTextureMaterialSource;
    mtl01Mercury: TTextureMaterialSource;
    mtl02Venus: TTextureMaterialSource;
    mtl03Earth: TTextureMaterialSource;
    mtl04Mars: TTextureMaterialSource;
    mtl05Jupiter: TTextureMaterialSource;
    mtl06Saturn: TTextureMaterialSource;
    mtl07Uranus: TTextureMaterialSource;
    mtl08Neptune: TTextureMaterialSource;
    mtl09Pluto: TTextureMaterialSource;
    mtl06SaturnRings: TTextureMaterialSource;
    mtl03Luna: TTextureMaterialSource;
    mtl07UranusRings: TTextureMaterialSource;
    anmRotation: TFloatAnimation;
    Layer3D1: TLayer3D;
    btnResetOrbits: TButton;
    chkAnimate: TCheckBox;
    Grid3D1: TGrid3D;
    btnResetView: TButton;
    procedure anmRotationProcess(Sender: TObject);
    procedure Form3DCreate(Sender: TObject);
    procedure Form3DMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure Form3DMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Single);
    procedure btnResetOrbitsClick(Sender: TObject);
    procedure chkAnimateChange(Sender: TObject);
    procedure btnResetViewClick(Sender: TObject);
  private
    FClickPoint: TPointF;
    FAngle: Double;
    procedure DrawOrbits(AReferenceAngle: Double);
    procedure DrawRotation(ARotationAngle: Double);
    procedure SetPosition(ASrc, ADest: TPosition3D; AAngle, ARadius: Double);
  public
  published
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}


// TForm1
// ============================================================================
procedure TForm1.Form3DCreate(Sender: TObject);
begin
  FAngle := 0;
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

// ----------------------------------------------------------------------------
procedure TForm1.btnResetOrbitsClick(Sender: TObject);
begin
  sph00Sol.RotationAngle.Y := 0;
  DrawRotation(sph00Sol.RotationAngle.Y);

  FAngle := 0;
  DrawOrbits(FAngle);
end;

// ----------------------------------------------------------------------------
procedure TForm1.btnResetViewClick(Sender: TObject);
begin
  Dummy1.RotationAngle.Point := TPoint3D.Zero;
end;

// ----------------------------------------------------------------------------
procedure TForm1.chkAnimateChange(Sender: TObject);
begin
  anmRotation.Enabled := chkAnimate.IsChecked;
end;

// ----------------------------------------------------------------------------
procedure TForm1.anmRotationProcess(Sender: TObject);
begin
  DrawRotation(sph00Sol.RotationAngle.Y);

  FAngle := FAngle + 0.01;
  DrawOrbits(FAngle);
end;

// ----------------------------------------------------------------------------
procedure TForm1.DrawOrbits(AReferenceAngle: Double);
const
  MercuryRadius = 3;
  VenusRadius = 4;
  EarthRadius = 5.5;
  MoonRadius = 0.9;
  MarsRadius = 7;
  JupiterRadius = 10;
  SaturnRadius = 14;
  UranusRadius = 17.5;
  NeptuneRadius = 20;
  PlutoRadius = 22;

  MercuryOrbit = 88;
  VenusOrbit = 224.7;
  EarthOrbit = 365.2;
  MoonOrbit = 27.3;
  MarsOrbit = 687;
  JupiterOrbit = 4331;
  SaturnOrbit = 10747;
  UranusOrbit = 30589;
  NeptuneOrbit = 59800;
  PlutoOrbit = 90560;
begin
  SetPosition(sph00Sol.Position, sph01Mercury.Position, AReferenceAngle * (EarthOrbit / MercuryOrbit), MercuryRadius);
  SetPosition(sph00Sol.Position, sph02Venus.Position, AReferenceAngle * (EarthOrbit / VenusOrbit), VenusRadius);
  SetPosition(sph00Sol.Position, sph03Earth.Position, AReferenceAngle, EarthRadius);
  SetPosition(sph03Earth.Position, sph03Luna.Position, AReferenceAngle * (EarthOrbit / MoonOrbit), MoonRadius);
  SetPosition(sph00Sol.Position, sph04Mars.Position, AReferenceAngle * (EarthOrbit / MarsOrbit), MarsRadius);
  SetPosition(sph00Sol.Position, sph05Jupiter.Position, AReferenceAngle * (EarthOrbit / JupiterOrbit), JupiterRadius);
  SetPosition(sph00Sol.Position, sph06Saturn.Position, AReferenceAngle * (EarthOrbit / SaturnOrbit), SaturnRadius);
  SetPosition(sph00Sol.Position, sph07Uranus.Position, AReferenceAngle * (EarthOrbit / UranusOrbit), UranusRadius);
  SetPosition(sph00Sol.Position, sph08Neptune.Position, AReferenceAngle * (EarthOrbit / NeptuneOrbit), NeptuneRadius);
  SetPosition(sph00Sol.Position, sph09Pluto.Position, AReferenceAngle * (EarthOrbit / PlutoOrbit), PlutoRadius);
end;

// ----------------------------------------------------------------------------
procedure TForm1.DrawRotation(ARotationAngle: Double);
begin
  sph00Sol.RotationAngle.Y := ARotationAngle;
  sph01Mercury.RotationAngle.Y := ARotationAngle;
  sph02Venus.RotationAngle.Y := (abs(ARotationAngle - 360));
  sph03Earth.RotationAngle.Y := ARotationAngle;
  sph03Luna.RotationAngle.Y := ARotationAngle;
  sph04Mars.RotationAngle.Y := ARotationAngle;
  sph05Jupiter.RotationAngle.Y := ARotationAngle;
  sph06Saturn.RotationAngle.Y := ARotationAngle;
  sph07Uranus.RotationAngle.Y := (abs(ARotationAngle - 360));
  sph08Neptune.RotationAngle.Y := ARotationAngle;
  sph09Pluto.RotationAngle.Y := ARotationAngle;
end;

// ----------------------------------------------------------------------------
procedure TForm1.SetPosition(ASrc, ADest: TPosition3D; AAngle, ARadius: Double);
begin
  ADest.X := ASrc.X + cos(AAngle) * ARadius;
  ADest.Z := ASrc.Z + sin(AAngle) * ARadius;
end;

end.
