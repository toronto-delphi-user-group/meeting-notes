unit ufrmMain;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  System.Diagnostics, FMX.Objects, FMX.Utils,
  System.Math, FMX.Controls.Presentation, FMX.StdCtrls;

type
  TfrmMain = class(TForm)
    Image1: TImage;
    lblTime: TLabel;
    btnRefresh: TButton;
    procedure FormCreate(Sender: TObject);
    procedure btnRefreshClick(Sender: TObject);
  private
    FStopwatch: TStopwatch;
    procedure DrawMandelbrot;
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
  Image1.Bitmap := TBitmap.Create(Trunc(Image1.Width), Trunc(Image1.Height));
  DrawMandelbrot;
end;

// ----------------------------------------------------------------------------
procedure TfrmMain.btnRefreshClick(Sender: TObject);
begin
  DrawMandelbrot;
end;

// ----------------------------------------------------------------------------
procedure TfrmMain.DrawMandelbrot;
const
  MAX_ITERATIONS = 100;
var
  x, y: Integer; // Bitmap coordinates
  a, b: Double; // Bitmap coordinates mapped to Mandelbrot set
  n: Integer; // Number of iterations

  aa: Double; // A squared
  bb: Double; // B squared
  ca, cb: Double; // Placeholder for original values of c

  LBitmapWidth, LBitmapHeight: Integer;
  LBitmapRatio: Single;
  LPixelColor: TAlphaColor;
  LBright: Double;
  LBitmapData: TBitmapData;
  LScanline: PAlphaColorArray;
begin
  FStopwatch := TStopwatch.StartNew;

  LBitmapWidth := Image1.Bitmap.Width;
  LBitmapHeight := Image1.Bitmap.Height;
  LBitmapRatio := LBitmapHeight / LBitmapWidth;

  Image1.Bitmap.Clear(TAlphaColorRec.White);
  Image1.Bitmap.Map(TMapAccess.ReadWrite, LBitmapData);
  try
    for y := 0 to LBitmapHeight - 1 do
    begin
      LScanline := PAlphaColorArray(LBitmapData.GetScanline(y));
      for x := 0 to LBitmapWidth - 1 do
      begin

        a := Map(x, 0, LBitmapWidth, -2.5, 1.5);
        // a := Map(x, 0, LBitmapWidth, -2, 2);
        b := Map(y, 0, LBitmapHeight, -2 * LBitmapRatio, 2 * LBitmapRatio);

        // Retain original values of c
        ca := a;
        cb := b;

        n := 0;
        while (n < MAX_ITERATIONS) do
        begin
          // Z Squared
          aa := (a * a) - (b * b); // Real component
          bb := 2 * a * b; // Imaginary component

          // + c
          a := aa + ca;
          b := bb + cb;

          if abs(a + b) > 4 then
            Break;

          Inc(n);
        end;

        if n >= MAX_ITERATIONS then
          LPixelColor := TAlphaColorRec.Black
        else
        begin
          LBright := Map(n, 0, MAX_ITERATIONS, 0, 1); // Normalise iteration count
          LPixelColor := TAlphaColorF.Create(LBright, LBright, LBright).ToAlphaColor;
        end;

        LScanline[x] := LPixelColor;
      end;
    end;
  finally
    Image1.Bitmap.Unmap(LBitmapData);
    FStopwatch.Stop;
    lblTime.Text := Format('%.0n ms', [FStopwatch.ElapsedMilliseconds + 0.0]);
  end;
end;

end.
