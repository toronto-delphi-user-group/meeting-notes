unit ufrmMain;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.Layouts, FMX.ListBox, FMX.Viewport3D,
  System.Math.Vectors, FMX.Objects3D, FMX.Controls3D, FMX.MaterialSources,
  FMX.Types3D,
  System.RTLConsts, FMX.Ani;

type
  THelperWireframe = class(TCustomMesh);

  TfrmMain = class(TForm)
    ImageControl1: TImageControl;
    Viewport3D1: TViewport3D;
    Label1: TLabel;
    Label2: TLabel;
    rbTextureMap: TRadioButton;
    rbTextureCubeMap: TRadioButton;
    rbTexturePlainCubeMap: TRadioButton;
    rbShapeSphere: TRadioButton;
    rbShapeCone: TRadioButton;
    rbShapeCylinder: TRadioButton;
    rbShapeCube: TRadioButton;
    rbShapeCubeFixed: TRadioButton;
    Dummy1: TDummy;
    ProxyObject1: TProxyObject;
    Sphere1: TSphere;
    Cone1: TCone;
    Cylinder1: TCylinder;
    Cube1: TCube;
    Cube2: TCube;
    ColorMaterialSource1: TColorMaterialSource;
    TextureMaterialSource1: TTextureMaterialSource;
    rbPrimitiveNone: TRadioButton;
    rbPrimitivePoints: TRadioButton;
    rbPrimitiveLines: TRadioButton;
    Label4: TLabel;
    TrackBar1: TTrackBar;
    Label3: TLabel;
    ListBox1: TListBox;
    ArcDial1: TArcDial;
    ArcDial2: TArcDial;
    ArcDial3: TArcDial;
    btnReset: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure rbShapeChange(Sender: TObject);
    procedure rbTextureChange(Sender: TObject);
    procedure rbPrimitiveChange(Sender: TObject);
    procedure ProxyObject1Render(Sender: TObject; Context: TContext3D);
    procedure ListBox1Change(Sender: TObject);
    procedure TrackBar1Change(Sender: TObject);
    procedure ArcDial1Change(Sender: TObject);
    procedure ArcDial2Change(Sender: TObject);
    procedure ArcDial3Change(Sender: TObject);
    procedure btnResetClick(Sender: TObject);
  private
    FbmpMap: TBitmap;
    FbmpCubeMap: TBitmap;
    FbmpPlainCubeMap: TBitmap;
    procedure RefreshBitmap;
    procedure UpdateDisplay;
  public
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.fmx}


// frmMain
// ============================================================================
procedure TfrmMain.FormCreate(Sender: TObject);
var
  VB: TVertexBuffer;
begin
  FbmpMap := TBitmap.Create;
  FbmpMap.LoadFromFile('2k_earth_daymap.jpg');
  FbmpCubeMap := TBitmap.Create;
  FbmpCubeMap.LoadFromFile('world_cube_net.png');
  FbmpPlainCubeMap := TBitmap.Create;
  FbmpPlainCubeMap.LoadFromFile('UVCubeMap.png');

  ImageControl1.Bitmap := FbmpMap;
  TextureMaterialSource1.Texture := FbmpMap;

  // Change texture coordinates on Cube2 to use a cube map
  VB := THelperWireframe(Cube2).Data.VertexBuffer;
  VB.TexCoord0[0] := TPointF.Create(0, 1 / 3);
  VB.TexCoord0[1] := TPointF.Create(0.25, 1 / 3);
  VB.TexCoord0[2] := TPointF.Create(0, 2 / 3);
  VB.TexCoord0[3] := TPointF.Create(0.25, 2 / 3);

  VB.TexCoord0[4] := TPointF.Create(0.75, 1 / 3);
  VB.TexCoord0[5] := TPointF.Create(0.5, 1 / 3);
  VB.TexCoord0[6] := TPointF.Create(0.75, 2 / 3);
  VB.TexCoord0[7] := TPointF.Create(0.5, 2 / 3);

  VB.TexCoord0[8] := TPointF.Create(0.25, 1);
  VB.TexCoord0[9] := TPointF.Create(0.25, 2 / 3);
  VB.TexCoord0[10] := TPointF.Create(0.5, 1);
  VB.TexCoord0[11] := TPointF.Create(0.5, 2 / 3);

  VB.TexCoord0[12] := TPointF.Create(0.25, 0);
  VB.TexCoord0[13] := TPointF.Create(0.25, 1 / 3);
  VB.TexCoord0[14] := TPointF.Create(0.5, 0);
  VB.TexCoord0[15] := TPointF.Create(0.5, 1 / 3);

  VB.TexCoord0[16] := TPointF.Create(0.25, 1 / 3);
  VB.TexCoord0[17] := TPointF.Create(0.25, 2 / 3);
  VB.TexCoord0[18] := TPointF.Create(0.5, 1 / 3);
  VB.TexCoord0[19] := TPointF.Create(0.5, 2 / 3);

  VB.TexCoord0[20] := TPointF.Create(1, 1 / 3);
  VB.TexCoord0[21] := TPointF.Create(1, 2 / 3);
  VB.TexCoord0[22] := TPointF.Create(0.75, 1 / 3);
  VB.TexCoord0[23] := TPointF.Create(0.75, 2 / 3);

  UpdateDisplay;
end;

// ----------------------------------------------------------------------------
procedure TfrmMain.FormDestroy(Sender: TObject);
begin
  FbmpMap.Free;
  FbmpCubeMap.Free;
  FbmpPlainCubeMap.Free;
end;

// ----------------------------------------------------------------------------
procedure TfrmMain.ArcDial1Change(Sender: TObject);
begin
  ProxyObject1.RotationAngle.X := (Sender as TArcDial).Value;
end;

// ----------------------------------------------------------------------------
procedure TfrmMain.ArcDial2Change(Sender: TObject);
begin
  ProxyObject1.RotationAngle.Y := (Sender as TArcDial).Value;
end;

// ----------------------------------------------------------------------------
procedure TfrmMain.ArcDial3Change(Sender: TObject);
begin
  ProxyObject1.RotationAngle.Z := (Sender as TArcDial).Value;
end;

// ----------------------------------------------------------------------------
procedure TfrmMain.btnResetClick(Sender: TObject);
begin
  ArcDial1.Value := 0;
  ArcDial2.Value := 0;
  ArcDial3.Value := 0;
end;

// ----------------------------------------------------------------------------
procedure TfrmMain.ListBox1Change(Sender: TObject);
var
  i: Integer;
  VB: TVertexBuffer;
  IB: TIndexBuffer;
  LPoint1, LPoint2, LPoint3: TPointF;
  LShape: THelperWireframe;
  LBrush: TStrokeBrush;
  LBitmapWidth: Integer;
  LBitmapHeight: Integer;
begin
  if ListBox1.ItemIndex = -1 then
    Exit;

  RefreshBitmap;
  LBitmapWidth := ImageControl1.Bitmap.Width;
  LBitmapHeight := ImageControl1.Bitmap.Height;

  LShape := THelperWireframe(ProxyObject1.SourceObject);
  VB := LShape.Data.VertexBuffer;
  IB := LShape.Data.IndexBuffer;

  LBrush := TStrokeBrush.Create(TBrushKind.Solid, TAlphaColorRec.Yellow);
  try
    i := ListBox1.ItemIndex * 3;
    LPoint1 := VB.TexCoord0[IB[i]];
    LPoint2 := VB.TexCoord0[IB[i + 1]];
    LPoint3 := VB.TexCoord0[IB[i + 2]];

    LPoint1.X := LPoint1.X * LBitmapWidth;
    LPoint1.Y := LPoint1.Y * LBitmapHeight;
    LPoint2.X := LPoint2.X * LBitmapWidth;
    LPoint2.Y := LPoint2.Y * LBitmapHeight;
    LPoint3.X := LPoint3.X * LBitmapWidth;
    LPoint3.Y := LPoint3.Y * LBitmapHeight;

    LBrush.Thickness := 5;
    ImageControl1.Bitmap.Canvas.BeginScene;
    ImageControl1.Bitmap.Canvas.DrawLine(LPoint1, LPoint2, 1, LBrush);
    ImageControl1.Bitmap.Canvas.DrawLine(LPoint2, LPoint3, 1, LBrush);
    ImageControl1.Bitmap.Canvas.DrawLine(LPoint3, LPoint1, 1, LBrush);
    ImageControl1.Bitmap.Canvas.EndScene;

    ProxyObject1.Repaint;
  finally
    LBrush.Free;
  end;
end;

// ----------------------------------------------------------------------------
procedure TfrmMain.ProxyObject1Render(Sender: TObject; Context: TContext3D);
var
  LIndex: Integer;
  LShape: THelperWireframe;
  VB: TVertexBuffer;
  IB: TIndexBuffer;
  LColor: TAlphaColor;
  LPoint1, LPoint2, LPoint3: TPoint3D;
begin
  LShape := THelperWireframe(ProxyObject1.SourceObject);
  VB := LShape.Data.VertexBuffer;
  IB := LShape.Data.IndexBuffer;

  // Draw shape's points
  if rbPrimitivePoints.IsChecked then
    Context.DrawPoints(VB, IB, ColorMaterialSource1.Material, 1);

  // Draw shape's lines
  if rbPrimitiveLines.IsChecked then
  begin
    LIndex := 0;
    while LIndex < IB.Length do
    begin
      try
        LColor := TAlphaColorRec.White;
        Context.DrawLine(VB.Vertices[IB.Indices[LIndex]], VB.Vertices[IB.Indices[LIndex + 1]], 1, LColor);
        Context.DrawLine(VB.Vertices[IB.Indices[LIndex + 1]], VB.Vertices[IB.Indices[LIndex + 2]], 1, LColor);
        Context.DrawLine(VB.Vertices[IB.Indices[LIndex + 2]], VB.Vertices[IB.Indices[LIndex]], 1, LColor);
      except
      end;
      LIndex := LIndex + 3;
    end;
  end;


  if ListBox1.ItemIndex = -1 then
    Exit;

  // Draw selected triangle on shape
  LIndex := ListBox1.ItemIndex * 3;
  LColor := TAlphaColorRec.Yellow;
  LPoint1 := VB.Vertices[IB[LIndex]];
  LPoint2 := VB.Vertices[IB[LIndex + 1]];
  LPoint3 := VB.Vertices[IB[LIndex + 2]];

  Context.DrawLine(LPoint1, LPoint2, 1, LColor);
  Context.DrawLine(LPoint2, LPoint3, 1, LColor);
  Context.DrawLine(LPoint3, LPoint1, 1, LColor);
end;

// ----------------------------------------------------------------------------
procedure TfrmMain.rbPrimitiveChange(Sender: TObject);
begin
  ProxyObject1.Repaint;
end;

// ----------------------------------------------------------------------------
procedure TfrmMain.rbShapeChange(Sender: TObject);
begin
  case (Sender as TControl).Tag of
    0:
      ProxyObject1.SourceObject := Sphere1;
    1:
      ProxyObject1.SourceObject := Cone1;
    2:
      ProxyObject1.SourceObject := Cylinder1;
    3:
      ProxyObject1.SourceObject := Cube1;
    4:
      ProxyObject1.SourceObject := Cube2;
  end;

  RefreshBitmap;
  UpdateDisplay;
end;

// ----------------------------------------------------------------------------
procedure TfrmMain.rbTextureChange(Sender: TObject);
begin
  RefreshBitmap;
  TextureMaterialSource1.Texture := ImageControl1.Bitmap;
  UpdateDisplay;
end;

// ----------------------------------------------------------------------------
procedure TfrmMain.RefreshBitmap;
begin
  if rbTextureMap.IsChecked then
    ImageControl1.Bitmap := FbmpMap;

  if rbTextureCubeMap.IsChecked then
    ImageControl1.Bitmap := FbmpCubeMap;

  if rbTexturePlainCubeMap.IsChecked then
    ImageControl1.Bitmap := FbmpPlainCubeMap;
end;

// ----------------------------------------------------------------------------
procedure TfrmMain.TrackBar1Change(Sender: TObject);
begin
  Sphere1.Opacity := TrackBar1.Value;
  Cone1.Opacity := TrackBar1.Value;
  Cylinder1.Opacity := TrackBar1.Value;
  Cube1.Opacity := TrackBar1.Value;
  Cube2.Opacity := TrackBar1.Value;
end;

// ----------------------------------------------------------------------------
procedure TfrmMain.UpdateDisplay;
var
  LTriangleNo: Integer;
  i: Integer;
  s: string;
  LTex0, LTex1, LTex2: TPointF;
  LPoint0, LPoint1, LPoint2: TPoint3D;
  LShape: THelperWireframe;
  VB: TVertexBuffer;
  IB: TIndexBuffer;
begin
  LShape := THelperWireframe(ProxyObject1.SourceObject);
  VB := LShape.Data.VertexBuffer;
  IB := LShape.Data.IndexBuffer;

  ListBox1.Clear;
  ListBox1.BeginUpdate;
  try
    LTriangleNo := 0;
    while LTriangleNo < (LShape.Data.IndexBuffer.Length) div 3 do
    begin
      i := LTriangleNo * 3;
      LPoint0 := VB.Vertices[IB[i]];
      LPoint1 := VB.Vertices[IB[i + 1]];
      LPoint2 := VB.Vertices[IB[i + 2]];
      LTex0 := VB.TexCoord0[IB[i]];
      LTex1 := VB.TexCoord0[IB[i + 1]];
      LTex2 := VB.TexCoord0[IB[i + 2]];
      s := Format('%.4d%s[%d,%d,%d]  %s%.2f,%.2f,%.2f %.2f,%.2f,%.2f %.2f,%.2f,%.2f  %s%.2f,%.2f %.2f,%.2f %.2f,%.2f',
        [LTriangleNo,
        #9,
        IB[i], IB[i + 1], IB[i + 2],
        #9,
        LPoint0.X, LPoint0.Y, LPoint0.Z,
        LPoint1.X, LPoint1.Y, LPoint1.Z,
        LPoint2.X, LPoint2.Y, LPoint2.Z,
        #9,
        LTex0.X, LTex0.Y,
        LTex1.X, LTex1.Y,
        LTex2.X, LTex2.Y]);
      ListBox1.Items.Add(s);

      Inc(LTriangleNo);
    end;
  finally
    ListBox1.EndUpdate;
  end;
end;

end.
