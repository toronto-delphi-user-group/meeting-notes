unit ufrmMain;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  System.Math.Vectors, FMX.Controls3D, FMX.Objects3D, FMX.Viewport3D,
  FMX.Types3D, FMX.Ani, FMX.MaterialSources, System.RTLConsts;

type
  THelperWireframe = class(TCustomMesh);

  TfrmMain = class(TForm)
    Viewport3D1: TViewport3D;
    Dummy1: TDummy;
    FloatAnimation1: TFloatAnimation;
    Mesh1: TMesh;
    ColorMaterialSource1: TColorMaterialSource;
    procedure FormCreate(Sender: TObject);
    procedure Mesh1Render(Sender: TObject; Context: TContext3D);
  private
  public
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.fmx}


// TfrmMain
// ============================================================================
procedure TfrmMain.FormCreate(Sender: TObject);
const
  RHO = 28.0;
  SIGMA = 10.0;
  BETA = 8.0 / 3.0;
  DELTA_TIME = 0.001;
  BUFFER_SIZE = 200000;
var
  i: Integer;
  LPoint: TPoint3D;
  LDeltaX: Single;
  LDeltaY: Single;
  LDeltaZ: Single;
begin
  Mesh1.Data.IndexBuffer.Length := BUFFER_SIZE;
  Mesh1.Data.VertexBuffer.Length := BUFFER_SIZE;
  LPoint := TPoint3D.Create(0.1, 0.1, 0.1);
  for i := 0 to BUFFER_SIZE - 1 do
  begin
    LDeltaX := DELTA_TIME * (SIGMA * (LPoint.Y - LPoint.X));
    LDeltaY := DELTA_TIME * (LPoint.X * (RHO - LPoint.Z) - LPoint.Y);
    LDeltaZ := DELTA_TIME * (LPoint.X * LPoint.Y - BETA * LPoint.Z);

    LPoint.X := LPoint.X + LDeltaX;
    LPoint.Y := LPoint.Y + LDeltaY;
    LPoint.Z := LPoint.Z + LDeltaZ;

    Mesh1.Data.IndexBuffer.Indices[i] := i;
    Mesh1.Data.VertexBuffer.Vertices[i] := LPoint;
  end;
end;

// ----------------------------------------------------------------------------
procedure TfrmMain.Mesh1Render(Sender: TObject; Context: TContext3D);
var
  VB: TVertexBuffer;
  IB: TIndexBuffer;
begin
  VB := THelperWireframe(Sender).Data.VertexBuffer;
  IB := THelperWireframe(Sender).Data.IndexBuffer;
  Context.DrawPoints(VB, IB, ColorMaterialSource1.Material, 0.5);
end;

end.
