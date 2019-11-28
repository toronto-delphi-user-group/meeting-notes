unit ufrmMain;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Utils,
  System.Diagnostics;

type
  TfrmMain = class(TForm)
    Image1: TImage;
    btnRefresh: TButton;
    lblTime: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnRefreshClick(Sender: TObject);
  private
    FStopwatch: TStopwatch;
    procedure DrawTriangle;
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
  Image1.Bitmap := TBitmap.Create(Trunc(Image1.Width), Trunc(Image1.Height));
  DrawTriangle;
end;

// ----------------------------------------------------------------------------
procedure TfrmMain.FormDestroy(Sender: TObject);
begin
  //
end;

// ----------------------------------------------------------------------------
procedure TfrmMain.btnRefreshClick(Sender: TObject);
begin
  DrawTriangle;
end;

// ----------------------------------------------------------------------------
procedure TfrmMain.DrawTriangle;
var
  i: Integer;
  LBitmapData: TBitmapData;
  LScanline: PAlphaColorArray;
  LPoints: TArray<TPointF>;
  LColors: TArray<TAlphaColor>;
  LRect: TRectF;
  LSelectedPoint: TPointF;
  LBitmapPoint: TPoint;
  LBitmapWidth, LBitmapHeight: Integer;
  LRandomNumber: Integer;
  LBrush: TStrokeBrush;
begin
  FStopwatch := TStopwatch.StartNew;

  LBitmapWidth := Image1.Bitmap.Width;
  LBitmapHeight := Image1.Bitmap.Height;

  Image1.Bitmap.Clear(TAlphaColorRec.Black);

  LColors := LColors + [TAlphaColorRec.Red];
  LColors := LColors + [TAlphaColorRec.Green];
  LColors := LColors + [TAlphaColorRec.Blue];

  LBrush := TStrokeBrush.Create(TBrushKind.Solid, TAlphaColorRec.Black);
  LBrush.Thickness := 6;
  Image1.Bitmap.Canvas.BeginScene;
  try
    for i := 0 to 2 do
    begin
      LSelectedPoint := TPointF.Create(Random(LBitmapWidth), Random(LBitmapHeight));
      LRect.Top := LSelectedPoint.Y - 3;
      LRect.Left := LSelectedPoint.X - 3;
      LRect.Width := 6;
      LRect.Height := 6;
      LBrush.Color := LColors[i];
      Image1.Bitmap.Canvas.DrawEllipse(LRect, 1, LBrush);
      LPoints := LPoints + [LSelectedPoint];
    end;

    LSelectedPoint := TPointF.Create(Random(LBitmapWidth), Random(LBitmapHeight));
    LRect.Top := LSelectedPoint.Y - 3;
    LRect.Left := LSelectedPoint.X - 3;
    LRect.Width := 6;
    LRect.Height := 6;
    LBrush.Color := TAlphaColorRec.Yellow;
    Image1.Bitmap.Canvas.DrawEllipse(LRect, 1, LBrush);
  finally
    LBrush.Free;
    Image1.Bitmap.Canvas.EndScene;
  end;

  Image1.Bitmap.Map(TMapAccess.ReadWrite, LBitmapData);
  try
    for i := 0 to 100000 do
    begin
      LRandomNumber := Random(3);
      LSelectedPoint := LSelectedPoint.MidPoint(LPoints[LRandomNumber]);
      LBitmapPoint := LSelectedPoint.Round;
      LScanline := PAlphaColorArray(LBitmapData.GetScanline(LBitmapPoint.Y));
      LScanline[LBitmapPoint.X] := LColors[LRandomNumber];
    end;
  finally
    Image1.Bitmap.Unmap(LBitmapData);
    FStopwatch.Stop;
    lblTime.Text := Format('%.0n ms', [FStopwatch.ElapsedMilliseconds + 0.0]);
  end;
end;

end.
