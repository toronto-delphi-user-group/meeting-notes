unit Unit1;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  System.RTLConsts,
  FMX.Types, FMX.Controls, FMX.Forms3D, FMX.Types3D, FMX.Forms, FMX.Graphics,
  FMX.Dialogs, System.Math.Vectors, FMX.Controls3D, FMX.Objects3D,
  FMX.MaterialSources;

type
  TForm1 = class(TForm3D)
    Dummy1: TDummy;
    Grid3D1: TGrid3D;
    Mesh1: TMesh;
    ColorMaterialSource1: TColorMaterialSource;
    procedure Form3DCreate(Sender: TObject);
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


// TForm1
// ============================================================================
procedure TForm1.Form3DCreate(Sender: TObject);
begin
  // Method A - Use TMesh's data properties (string)
  // Requires less code but is slower to parse
  // Can be set at design time

  // Define points in groups of three (x, y, z)
  // Values can be separated by space or comma
  Mesh1.Data.Points :=
    '0 0 0  -1 -1 -1  1 -1 -1 '
    + '0 0 0  -1 1 -1  1 1 -1 '
    + '0 0 0  -1 -1 1  1 -1 1 '
    + '0 0 0  -1 1 1  1 1 1';

  // Define vertices of triangles from the points created above by index in groups of three
  Mesh1.Data.TriangleIndices :=
    '0 1 2 '
    + '3 4 5 '
    + '6 7 8 '
    + '9 10 11';


  // Method B - Use TMesh's data buffers directly
  // Requires more code but is much faster on large datasets

  // Mesh1.Data.IndexBuffer.Length := 12;
  // Mesh1.Data.VertexBuffer.Length := 12;
  //
  // Mesh1.Data.VertexBuffer.Vertices[0] := TPoint3D.Create(0, 0, 0);
  // Mesh1.Data.VertexBuffer.Vertices[1] := TPoint3D.Create(-1, -1, -1);
  // Mesh1.Data.VertexBuffer.Vertices[2] := TPoint3D.Create(1, -1, -1);
  // Mesh1.Data.IndexBuffer.Indices[0] := 0;
  // Mesh1.Data.IndexBuffer.Indices[1] := 1;
  // Mesh1.Data.IndexBuffer.Indices[2] := 2;
  //
  // Mesh1.Data.VertexBuffer.Vertices[3] := TPoint3D.Create(0, 0, 0);
  // Mesh1.Data.VertexBuffer.Vertices[4] := TPoint3D.Create(-1, 1, -1);
  // Mesh1.Data.VertexBuffer.Vertices[5] := TPoint3D.Create(1, 1, -1);
  // Mesh1.Data.IndexBuffer.Indices[3] := 3;
  // Mesh1.Data.IndexBuffer.Indices[4] := 4;
  // Mesh1.Data.IndexBuffer.Indices[5] := 5;
  //
  // Mesh1.Data.VertexBuffer.Vertices[6] := TPoint3D.Create(0, 0, 0);
  // Mesh1.Data.VertexBuffer.Vertices[7] := TPoint3D.Create(-1, -1, 1);
  // Mesh1.Data.VertexBuffer.Vertices[8] := TPoint3D.Create(1, -1, 1);
  // Mesh1.Data.IndexBuffer.Indices[6] := 6;
  // Mesh1.Data.IndexBuffer.Indices[7] := 7;
  // Mesh1.Data.IndexBuffer.Indices[8] := 8;
  //
  // Mesh1.Data.VertexBuffer.Vertices[9] := TPoint3D.Create(0, 0, 0);
  // Mesh1.Data.VertexBuffer.Vertices[10] := TPoint3D.Create(-1, 1, 1);
  // Mesh1.Data.VertexBuffer.Vertices[11] := TPoint3D.Create(1, 1, 1);
  // Mesh1.Data.IndexBuffer.Indices[9] := 9;
  // Mesh1.Data.IndexBuffer.Indices[10] := 10;
  // Mesh1.Data.IndexBuffer.Indices[11] := 11;
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
