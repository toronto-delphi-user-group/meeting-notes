unit ufrmMain;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Utils,
  System.Diagnostics, FMX.Controls.Presentation, FMX.StdCtrls;

type
  TfrmMain = class(TForm)
    Image1: TImage;
    Image2: TImage;
    lblTime: TLabel;
    Label1: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure Image1MouseMove(Sender: TObject; Shift: TShiftState; X, Y: Single);
  private
    FDrawing: Boolean;
    FMandelbrotRatio: Single;
    FJuliaRatio: Single;
    FStopwatch: TStopwatch;
    procedure DrawMandelbrot;
    procedure DrawJulia(ACA, ACB: Double);
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
  Image2.Bitmap := TBitmap.Create(Trunc(Image2.Width), Trunc(Image2.Height));

  FMandelbrotRatio := Image1.Bitmap.Height / Image1.Bitmap.Width;
  FJuliaRatio := Image2.Bitmap.Height / Image2.Bitmap.Width;

  DrawMandelbrot;
end;

// ----------------------------------------------------------------------------
procedure TfrmMain.Image1MouseMove(Sender: TObject; Shift: TShiftState; X, Y: Single);
var
  LCA, LCB: Double;
begin
  if FDrawing then
    Exit;

  FDrawing := True;
  try
    begin
      FStopwatch := TStopwatch.StartNew;
      LCA := Map(X, 0, Image1.Bitmap.Width, -2.5, 1.5);
      LCB := Map(Y, 0, Image1.Bitmap.Height, -2 * FMandelbrotRatio, 2 * FMandelbrotRatio);
      DrawJulia(LCA, LCB);
      Application.ProcessMessages;
    end;
  finally
    FDrawing := False;
    FStopwatch.Stop;
    lblTime.Text := Format('%.0n ms', [FStopwatch.ElapsedMilliseconds + 0.0]);
  end;
end;

// ----------------------------------------------------------------------------
// Note that the code is virtually identical to DrawMandelbrot
procedure TfrmMain.DrawJulia(ACA, ACB: Double);
const
  MAX_ITERATIONS = 100;
var
  X, Y: Integer; // Bitmap coordinates
  a, b: Double; // Bitmap coordinates mapped to Mandelbrot set
  n: Integer; // Number of iterations

  aa: Double; // A squared
  bb: Double; // B squared
  ca, cb: Double; // Placeholder for original values of c

  LBitmapWidth, LBitmapHeight: Integer;
  LPixelColor: TAlphaColor;
  LBright: Double;
  LBitmapData: TBitmapData;
  LScanline: PAlphaColorArray;
begin
  LBitmapWidth := Image2.Bitmap.Width;
  LBitmapHeight := Image2.Bitmap.Height;

  Image2.Bitmap.Clear(TAlphaColorRec.White);
  Image2.Bitmap.Map(TMapAccess.ReadWrite, LBitmapData);
  try
    for Y := 0 to LBitmapHeight - 1 do
    begin
      LScanline := PAlphaColorArray(LBitmapData.GetScanline(Y));
      for X := 0 to LBitmapWidth - 1 do
      begin

        a := Map(X, 0, LBitmapWidth, -2, 2);
        b := Map(Y, 0, LBitmapHeight, -2 * FJuliaRatio, 2 * FJuliaRatio);

        // Retain original values of c
        ca := ACA;
        cb := ACB;

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
          LPixelColor := TAlphaColorRec.White
        else
        begin
          LBright := Map(n, 0, MAX_ITERATIONS, 0, 1); // Normalise iteration count
          LPixelColor := TAlphaColorF.Create(0, 0, LBright).ToAlphaColor;
        end;

        LScanline[X] := LPixelColor;
      end;
    end;
  finally
    Image2.Bitmap.Unmap(LBitmapData);
    Image2.Repaint;
  end;
end;

// ----------------------------------------------------------------------------
procedure TfrmMain.DrawMandelbrot;
const
  MAX_ITERATIONS = 100;
var
  X, Y: Integer; // Bitmap coordinates
  a, b: Double; // Bitmap coordinates mapped to Mandelbrot set
  n: Integer; // Number of iterations

  aa: Double; // A squared
  bb: Double; // B squared
  ca, cb: Double; // Placeholder for original values of c

  LBitmapWidth, LBitmapHeight: Integer;
  LPixelColor: TAlphaColor;
  LBright: Double;
  LBitmapData: TBitmapData;
  LScanline: PAlphaColorArray;
begin
  LBitmapWidth := Image1.Bitmap.Width;
  LBitmapHeight := Image1.Bitmap.Height;

  Image1.Bitmap.Clear(TAlphaColorRec.White);
  Image1.Bitmap.Map(TMapAccess.ReadWrite, LBitmapData);
  try
    for Y := 0 to LBitmapHeight - 1 do
    begin
      LScanline := PAlphaColorArray(LBitmapData.GetScanline(Y));
      for X := 0 to LBitmapWidth - 1 do
      begin

        a := Map(X, 0, LBitmapWidth, -2.5, 1.5);
        b := Map(Y, 0, LBitmapHeight, -2 * FJuliaRatio, 2 * FJuliaRatio);

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

        LScanline[X] := LPixelColor;
      end;
    end;
  finally
    Image1.Bitmap.Unmap(LBitmapData);
  end;
end;

end.
