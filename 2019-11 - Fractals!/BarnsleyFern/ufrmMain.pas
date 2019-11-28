unit ufrmMain;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Utils,
  System.Diagnostics, System.Math;

type
  TfrmMain = class(TForm)
    btnPixel: TButton;
    Image1: TImage;
    btnScanline: TButton;
    btnScanlinePerLine: TButton;
    lblPixel: TLabel;
    lblScanline: TLabel;
    lblScanlinePerLine: TLabel;
    btnFern: TButton;
    lblFern: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure btnPixelClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnScanlineClick(Sender: TObject);
    procedure btnScanlinePerLineClick(Sender: TObject);
    procedure btnFernClick(Sender: TObject);
  private
    FStopwatch: TStopwatch;
  public
  end;

var
  frmMain: TfrmMain;

implementation

uses
  TDUGUtils;

{$R *.fmx}


// TfrmMain
// ============================================================================
procedure TfrmMain.FormCreate(Sender: TObject);
begin
  Randomize;
  Image1.Bitmap := TBitmap.Create(Trunc(Image1.Width), Trunc(Image1.Height));
end;

// ----------------------------------------------------------------------------
procedure TfrmMain.FormDestroy(Sender: TObject);
begin
end;

// ----------------------------------------------------------------------------
procedure TfrmMain.btnPixelClick(Sender: TObject);
var
  LBitmapData: TBitmapData;
  LBitmapX, LBitmapY: Integer;
begin
  FStopwatch := TStopwatch.StartNew;
  try
    Image1.Bitmap.Map(TMapAccess.ReadWrite, LBitmapData);
    for LBitmapY := 0 to (Image1.Bitmap.Height - 1) do
    begin
      for LBitmapX := 0 to (Image1.Bitmap.Width - 1) do
      begin
        LBitmapData.SetPixel(LBitmapX, LBitmapY, TAlphaColorRec.Green);
      end;
    end;
  finally
    Image1.Bitmap.Unmap(LBitmapData);
    FStopwatch.Stop;
    lblPixel.Text := Format('%.0n ms', [FStopwatch.ElapsedMilliseconds + 0.0]);
  end;
end;

// ----------------------------------------------------------------------------
procedure TfrmMain.btnScanlineClick(Sender: TObject);
var
  LBitmapData: TBitmapData;
  LScanline: PAlphaColorArray;
  LBitmapX, LBitmapY: Integer;
begin
  FStopwatch := TStopwatch.StartNew;
  try
    Image1.Bitmap.Map(TMapAccess.ReadWrite, LBitmapData);
    for LBitmapY := 0 to (Image1.Bitmap.Height - 1) do
    begin
      for LBitmapX := 0 to (Image1.Bitmap.Width - 1) do
      begin
        LScanline := PAlphaColorArray(LBitmapData.GetScanline(LBitmapY));
        LScanline[LBitmapX] := TAlphaColorRec.Blue;
      end;
    end;
  finally
    Image1.Bitmap.Unmap(LBitmapData);
    FStopwatch.Stop;
    lblScanline.Text := Format('%.0n ms', [FStopwatch.ElapsedMilliseconds + 0.0]);
  end;
end;

// ----------------------------------------------------------------------------
procedure TfrmMain.btnScanlinePerLineClick(Sender: TObject);
var
  LBitmapData: TBitmapData;
  LScanline: PAlphaColorArray;
  LBitmapX, LBitmapY: Integer;
begin
  FStopwatch := TStopwatch.StartNew;
  try
    Image1.Bitmap.Map(TMapAccess.ReadWrite, LBitmapData);
    for LBitmapY := 0 to (Image1.Bitmap.Height - 1) do
    begin
      LScanline := PAlphaColorArray(LBitmapData.GetScanline(LBitmapY));
      for LBitmapX := 0 to (Image1.Bitmap.Width - 1) do
      begin
        LScanline[LBitmapX] := TAlphaColorRec.Blue;
      end;
    end;
  finally
    Image1.Bitmap.Unmap(LBitmapData);
    FStopwatch.Stop;
    lblScanlinePerLine.Text := Format('%.0n ms', [FStopwatch.ElapsedMilliseconds + 0.0]);
  end;
end;

// ----------------------------------------------------------------------------
procedure TfrmMain.btnFernClick(Sender: TObject);
var
  i: Integer;
  LBitmapData: TBitmapData;
  LScanline: PAlphaColorArray;
  LLastPoint: TPointF;
  LNextPoint: TPointF;
  LBitmapPoint: TPoint;
  LBitmapWidth, LBitmapHeight: Integer;
  LRandomNumber: Single;
  LUseScanline: Boolean;
begin
  LUseScanline := False;

  FStopwatch := TStopwatch.StartNew;

  LBitmapWidth := Image1.Bitmap.Width;
  LBitmapHeight := Image1.Bitmap.Height;

  Image1.Bitmap.Clear(TAlphaColorRec.White);
  Image1.Bitmap.Map(TMapAccess.ReadWrite, LBitmapData);
  try
    LLastPoint := TPointF.Create(0, 0);

    for i := 0 to 100000 do
    begin
      LRandomNumber := Random;

      if LRandomNumber < 0.01 then
      begin
        LNextPoint.X := 0.0;
        LNextPoint.Y := 0.16 * LLastPoint.Y;
      end
      else if LRandomNumber < 0.86 then
      begin
        LNextPoint.X := 0.85 * LLastPoint.X + 0.04 * LLastPoint.Y;
        LNextPoint.Y := -0.04 * LLastPoint.X + 0.85 * LLastPoint.Y + 1.6;
      end
      else if LRandomNumber < 0.93 then
      begin
        LNextPoint.X := 0.20 * LLastPoint.X - 0.26 * LLastPoint.Y;
        LNextPoint.Y := 0.23 * LLastPoint.X + 0.22 * LLastPoint.Y + 1.6;
      end
      else
      begin
        LNextPoint.X := -0.15 * LLastPoint.X + 0.28 * LLastPoint.Y;
        LNextPoint.Y := 0.26 * LLastPoint.X + 0.24 * LLastPoint.Y + 0.44;
      end;

      // Scale point to bitmap
      LBitmapPoint.X := Trunc(Map(LNextPoint.X, -2.1820, 2.6558, 0, LBitmapWidth));
      LBitmapPoint.Y := Trunc(Map(LNextPoint.Y, 0, 9.9983, LBitmapHeight, 0));

      if LUseScanline then
      begin
        // Scanline
        LScanline := PAlphaColorArray(LBitmapData.GetScanline(LBitmapPoint.Y));
        LScanline[LBitmapPoint.X] := TAlphaColorRec.Green;
      end
      else
      begin
        // Individual Pixels
        LBitmapData.SetPixel(LBitmapPoint.X, LBitmapPoint.Y, TAlphaColorRec.Green);
      end;

      LLastPoint := LNextPoint;
    end;
  finally
    Image1.Bitmap.Unmap(LBitmapData);
    FStopwatch.Stop;
    lblFern.Text := Format('%.0n ms', [FStopwatch.ElapsedMilliseconds + 0.0]);
  end;
end;

end.
