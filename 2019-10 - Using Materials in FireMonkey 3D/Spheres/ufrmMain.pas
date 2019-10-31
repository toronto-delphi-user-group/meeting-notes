unit ufrmMain;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms3D, FMX.Types3D, FMX.Forms, FMX.Graphics,
  FMX.Dialogs, System.Math.Vectors, FMX.Controls3D, FMX.Objects3D,
  FMX.MaterialSources,
  System.RTLConsts;

type
  THelperWireframe = class(TCustomMesh);

  TfrmMain = class(TForm3D)
    Dummy1: TDummy;
    Sphere1: TSphere;
    Sphere2: TSphere;
    Sphere3: TSphere;
    Sphere4: TSphere;
    Sphere5: TSphere;
    Sphere6: TSphere;
    ColorMaterialSource1: TColorMaterialSource;
    ColorMaterialSource2: TColorMaterialSource;
    TextureMaterialSource1: TTextureMaterialSource;
    LightMaterialSource1: TLightMaterialSource;
    LightMaterialSource2: TLightMaterialSource;
    Light1: TLight;
    Text3D1: TText3D;
    Text3D2: TText3D;
    Text3D3: TText3D;
    Text3D4: TText3D;
    Text3D5: TText3D;
    Text3D6: TText3D;
    procedure Form3DCreate(Sender: TObject);
    procedure Sphere1Render(Sender: TObject; Context: TContext3D);
    procedure Sphere2Render(Sender: TObject; Context: TContext3D);
  private
  public
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.fmx}


// TfrmMain
// ============================================================================
procedure TfrmMain.Form3DCreate(Sender: TObject);
begin
  Sphere1.Opacity := 0;
  Sphere2.Opacity := 0;
  Self.Color := TAlphaColorRec.Black;
end;

// ----------------------------------------------------------------------------
procedure TfrmMain.Sphere1Render(Sender: TObject; Context: TContext3D);
var
  VB: TVertexBuffer;
  IB: TIndexBuffer;
begin
  VB := THelperWireframe(Sender).Data.VertexBuffer;
  IB := THelperWireframe(Sender).Data.IndexBuffer;

  Context.DrawPoints(VB, IB, ColorMaterialSource2.Material, 1);
end;

// ----------------------------------------------------------------------------
procedure TfrmMain.Sphere2Render(Sender: TObject; Context: TContext3D);
var
  i: Integer;
  VB: TVertexBuffer;
  IB: TIndexBuffer;
  LColor: TAlphaColor;
begin
  VB := THelperWireframe(Sender).Data.VertexBuffer;
  IB := THelperWireframe(Sender).Data.IndexBuffer;
  LColor := TAlphaColorRec.White;

  i := 0;
  while i < IB.Length do
  begin
    Context.DrawLine(VB.Vertices[IB.Indices[i]], VB.Vertices[IB.Indices[i + 1]], 1, LColor);
    Context.DrawLine(VB.Vertices[IB.Indices[i + 1]], VB.Vertices[IB.Indices[i + 2]], 1, LColor);
    Context.DrawLine(VB.Vertices[IB.Indices[i + 2]], VB.Vertices[IB.Indices[i]], 1, LColor);
    i := i + 3;
  end;
end;

end.
