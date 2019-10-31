unit ufrmMain;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  System.Math.Vectors, FMX.Controls.Presentation, FMX.StdCtrls, FMX.Objects3D,
  FMX.Controls3D, FMX.Viewport3D, FMX.MaterialSources, uGameOfLife, FMX.Ani;

type
  TfrmMain = class(TForm)
    Viewport3D1: TViewport3D;
    Dummy1: TDummy;
    Sphere1: TSphere;
    TextureMaterialSource1: TTextureMaterialSource;
    FloatAnimation1: TFloatAnimation;
    btnClear: TButton;
    btnRandom: TButton;
    btnStep: TButton;
    btnRunPause: TButton;
    Timer1: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnStepClick(Sender: TObject);
    procedure btnRunPauseClick(Sender: TObject);
    procedure btnRandomClick(Sender: TObject);
    procedure btnClearClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    FBitmap: TBitmap;
    FLife: TGameOfLife;
    FScale: Integer;
    procedure DrawLife;
    procedure InitialiseBitmap;
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
  FLife := TGameOfLife.Create;
  FScale := 5;
  FBitmap := TBitmap.Create(1200, 600); // multiples of scale to avoid a seam

  FLife.Width := Trunc(FBitmap.Width / FScale);
  FLife.Height := Trunc(FBitmap.Height / FScale);
  FLife.FillRandom;

  InitialiseBitmap;
  DrawLife;
end;

// ----------------------------------------------------------------------------
procedure TfrmMain.FormDestroy(Sender: TObject);
begin
  FBitmap.Free;
  FLife.Free;
end;

// ----------------------------------------------------------------------------
procedure TfrmMain.btnClearClick(Sender: TObject);
begin
  FLife.Clear;
  DrawLife;
end;

// ----------------------------------------------------------------------------
procedure TfrmMain.btnRandomClick(Sender: TObject);
begin
  FLife.FillRandom;
  DrawLife;
end;

// ----------------------------------------------------------------------------
procedure TfrmMain.btnRunPauseClick(Sender: TObject);
begin
  Timer1.Enabled := NOT Timer1.Enabled;
  btnStep.Enabled := NOT Timer1.Enabled;
  if Timer1.Enabled then
    btnRunPause.Text := 'Pause'
  else
    btnRunPause.Text := 'Run';
end;

// ----------------------------------------------------------------------------
procedure TfrmMain.btnStepClick(Sender: TObject);
begin
  FLife.Step;
  DrawLife;
end;

// ----------------------------------------------------------------------------
procedure TfrmMain.DrawLife;
var
  LRect: TRectF;
  LRow: Integer;
  LCol: Integer;
  LOffset: Integer;
  LCanvas: TCanvas;
begin
  LOffset := 0;
  if FScale > 2 then
    LOffset := 1;
  if FScale > 8 then
    LOffset := 2;

  TextureMaterialSource1.Texture := FBitmap;
  LCanvas := TextureMaterialSource1.Texture.Canvas;
  LCanvas.BeginScene;
  try
    LCanvas.Fill.Color := TAlphaColorRec.Black;
    for LRow := 0 to FLife.Height - 1 do
    begin
      for LCol := 0 to FLife.Width - 1 do
      begin
        LRect.Left := LCol * FScale;
        LRect.Top := LRow * FScale;
        LRect.Right := LRect.Left + FScale - LOffset;
        LRect.Bottom := LRect.Top + FScale - LOffset;
        if FLife.Data[LCol, LRow] = 1 then
          LCanvas.FillRect(LRect, 0, 0, AllCorners, 100);
      end;
    end;
  finally
    LCanvas.EndScene;
  end;
end;

// ----------------------------------------------------------------------------
procedure TfrmMain.InitialiseBitmap;
var
  LRect: TRectF;
  LRow: Integer;
  LCol: Integer;
  LOffset: Integer;
  LCanvas: TCanvas;
begin
  LOffset := 0;
  if FScale > 2 then
    LOffset := 1;
  if FScale > 8 then
    LOffset := 2;

  LCanvas := FBitmap.Canvas;
  LCanvas.BeginScene;
  try
    LRect := FBitmap.Bounds;
    LCanvas.Fill.Color := TAlphaColorRec.Lightgray;
    LCanvas.FillRect(LRect, 0, 0, AllCorners, 100);

    LCanvas.Fill.Color := TAlphaColorRec.White;
    for LRow := 0 to FLife.Height - 1 do
    begin
      for LCol := 0 to FLife.Width - 1 do
      begin
        LRect.Left := LCol * FScale;
        LRect.Top := LRow * FScale;
        LRect.Right := LRect.Left + FScale - LOffset;
        LRect.Bottom := LRect.Top + FScale - LOffset;
        LCanvas.FillRect(LRect, 0, 0, AllCorners, 100);
      end;
    end;
  finally
    LCanvas.EndScene;
  end;
end;

// ----------------------------------------------------------------------------
procedure TfrmMain.Timer1Timer(Sender: TObject);
begin
  Timer1.Enabled := False;
  try
    FLife.Step;
    DrawLife;
  finally
    Timer1.Enabled := True;
  end;
end;

end.
