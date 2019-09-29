unit ufrmMain;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  System.Math.Vectors, FMX.Controls3D, FMX.Objects3D, FMX.Controls.Presentation,
  FMX.StdCtrls, FMX.Viewport3D, FMX.Types3D, FMX.Edit, FMX.Layouts,
  uGameOfLife3D;

type
  TfrmMain = class(TForm)
    Viewport3D1: TViewport3D;
    Dummy1: TDummy;
    LayoutLeft: TLayout;
    tbScale: TTrackBar;
    LayoutBottom: TLayout;
    btnStep: TButton;
    btnRandom: TButton;
    btnRunPause: TButton;
    lblRules: TLabel;
    edtRules: TEdit;
    Timer1: TTimer;
    Grid3D1: TGrid3D;
    btnResetCamera: TButton;
    procedure Dummy1Render(Sender: TObject; Context: TContext3D);
    procedure Viewport3D1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure Viewport3D1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Single);
    procedure Timer1Timer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnRandomClick(Sender: TObject);
    procedure btnResetCameraClick(Sender: TObject);
    procedure btnRunPauseClick(Sender: TObject);
    procedure btnStepClick(Sender: TObject);
    procedure edtRulesValidate(Sender: TObject; var Text: string);
    procedure tbScaleChange(Sender: TObject);
  private
    FClickPoint: TPointF;
    FLife3D: TGameOfLife3D;
    procedure ResetGameSize;
  public
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.fmx}


// TfrmMain
// ============================================================================
procedure TfrmMain.FormCreate(Sender: TObject);
begin
  FLife3D := TGameOfLife3D.Create;
  edtRules.Text := FLife3D.Rules;
  FLife3D.SetSize(30, 30, 30);
end;

// ----------------------------------------------------------------------------
procedure TfrmMain.FormDestroy(Sender: TObject);
begin
  FLife3D.Free;
end;

// ----------------------------------------------------------------------------
procedure TfrmMain.ResetGameSize;
var
  LSize: Integer;
begin
  if Assigned(FLife3D) then
  begin
    LSize := Trunc(tbScale.Value);
    FLife3D.SetSize(LSize, LSize, LSize);
    Dummy1.Repaint;
  end;
end;

// ----------------------------------------------------------------------------
procedure TfrmMain.tbScaleChange(Sender: TObject);
begin
  ResetGameSize;
end;

// ----------------------------------------------------------------------------
procedure TfrmMain.btnRandomClick(Sender: TObject);
begin
  FLife3D.FillRandom;
  Dummy1.Repaint;
end;

// ----------------------------------------------------------------------------
procedure TfrmMain.btnResetCameraClick(Sender: TObject);
begin
  Dummy1.RotationAngle.Point := Point3D(0, 0, 0);
end;

// ----------------------------------------------------------------------------
procedure TfrmMain.btnRunPauseClick(Sender: TObject);
begin
  Timer1.Enabled := NOT Timer1.Enabled;
  btnStep.Enabled := NOT Timer1.Enabled;
  if Timer1.Enabled then
  begin
    btnRunPause.Text := 'Pause';
  end
  else
  begin
    btnRunPause.Text := 'Run';
  end;
end;

// ----------------------------------------------------------------------------
procedure TfrmMain.btnStepClick(Sender: TObject);
begin
  FLife3D.Step;
  Dummy1.Repaint;
end;

// ----------------------------------------------------------------------------
procedure TfrmMain.Dummy1Render(Sender: TObject; Context: TContext3D);
var
  i, j, k: Integer;
  X, Y, Z: Extended;
  LCubeSize: TPoint3D;
  LCubePosition: TPoint3D;
begin
  LCubeSize := Point3D(0.6, 0.6, 0.6);

  for i := 0 to FLife3D.Width - 1 do
    for j := 0 to FLife3D.Height - 1 do
      for k := 0 to FLife3D.Depth - 1 do
        if FLife3D.Data[i, j, k] = 1 then
        begin
          X := i - FLife3D.Width / 2;
          Y := j - FLife3D.Height / 2;
          Z := k - FLife3D.Depth / 2;

          LCubePosition := Point3D(X, Y, Z);
          Context.FillCube(LCubePosition, LCubeSize, 1, TAlphaColorRec.Blue);
        end;
end;

// ----------------------------------------------------------------------------
procedure TfrmMain.edtRulesValidate(Sender: TObject; var Text: string);
begin
  FLife3D.Rules := edtRules.Text;
end;

// ----------------------------------------------------------------------------
procedure TfrmMain.Timer1Timer(Sender: TObject);
begin
  Timer1.Enabled := False;
  try
    FLife3D.Step;
    Dummy1.Repaint;
  finally
    Timer1.Enabled := True;
  end;
end;

// ----------------------------------------------------------------------------
procedure TfrmMain.Viewport3D1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Single);
begin
  FClickPoint := PointF(X, Y);
end;

// ----------------------------------------------------------------------------
procedure TfrmMain.Viewport3D1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Single);
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
