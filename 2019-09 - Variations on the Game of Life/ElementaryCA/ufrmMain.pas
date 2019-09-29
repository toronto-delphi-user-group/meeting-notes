unit ufrmMain;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Objects, FMX.Controls.Presentation, uElementaryCA, FMX.Layouts, FMX.Edit;

type
  TfrmMain = class(TForm)
    tbScale: TTrackBar;
    pbRule7: TPaintBox;
    pbRule6: TPaintBox;
    pbRule5: TPaintBox;
    pbRule4: TPaintBox;
    pbRule3: TPaintBox;
    pbRule2: TPaintBox;
    pbRule1: TPaintBox;
    pbRule0: TPaintBox;
    LayoutRules: TLayout;
    LayoutClient: TLayout;
    LayoutBottom: TLayout;
    LayoutLeft: TLayout;
    pbGame: TPaintBox;
    lblRule: TLabel;
    edtRule: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure PaintBoxRulesPaint(Sender: TObject; Canvas: TCanvas);
    procedure PaintBoxClick(Sender: TObject);
    procedure tbScaleChange(Sender: TObject);
    procedure pbGameResized(Sender: TObject);
    procedure pbGamePaint(Sender: TObject; Canvas: TCanvas);
    procedure edtRuleValidate(Sender: TObject; var Text: string);
  private
    FWolfram: TElementaryCA;
    procedure ResetGameSize;
    procedure UpdateDisplay;
  public
  end;

var
  frmMain: TfrmMain;

implementation

uses
  System.Math, System.Character;

{$R *.fmx}


// TfrmMain
// ============================================================================
procedure TfrmMain.FormCreate(Sender: TObject);
begin
  FWolfram := TElementaryCA.Create;
  edtRule.Text := Format('%d', [FWolfram.Rule]);
  ResetGameSize;
end;

// ----------------------------------------------------------------------------
procedure TfrmMain.FormDestroy(Sender: TObject);
begin
  FWolfram.Free;
end;

// ----------------------------------------------------------------------------
procedure TfrmMain.edtRuleValidate(Sender: TObject; var Text: string);
var
  LRule: Integer;
begin
  if TryStrToInt(edtRule.Text, LRule) and (LRule >= 0) and (LRule <= 255) then
  begin
    FWolfram.Rule := LRule;
    UpdateDisplay;
  end
  else
  begin
    Text := FWolfram.Rule.ToString;
  end;
end;

// ----------------------------------------------------------------------------
procedure TfrmMain.pbGamePaint(Sender: TObject; Canvas: TCanvas);
var
  LRect: TRectF;
  LRow: Integer;
  LCol: Integer;
  LSize: Integer;
  LScale: Integer;
begin
  Canvas.BeginScene;
  try
    Canvas.Stroke.Kind := TBrushKind.Solid;
    Canvas.Stroke.Color := TAlphaColorRec.Black;

    LRect := pbGame.BoundsRect;
    Canvas.Fill.Color := TAlphaColorRec.White;
    Canvas.DrawRect(LRect, 1, 1, AllCorners, 100);

    Canvas.Fill.Color := TAlphaColorRec.Lightgray;
    Canvas.FillRect(LRect, 1, 1, AllCorners, 100);

    LScale := Trunc(tbScale.Value);
    LSize := FWolfram.Size;

    FWolfram.Clear;
    Canvas.Fill.Color := TAlphaColorRec.Black;
    for LRow := 0 to Trunc(pbGame.Height / LScale) - 1 do
    begin
      for LCol := 0 to LSize - 1 do
      begin
        if FWolfram.Data[LCol] = 1 then
        begin
          LRect.Left := LCol * LScale;
          LRect.Top := LRow * LScale;
          LRect.Right := LRect.Left + LScale;
          LRect.Bottom := LRect.Top + LScale;
          Canvas.FillRect(LRect, 1, 1, AllCorners, 100);
        end;
      end;
      FWolfram.Step;
    end;
  finally
    Canvas.EndScene;
  end;
end;

// ----------------------------------------------------------------------------
procedure TfrmMain.pbGameResized(Sender: TObject);
begin
  ResetGameSize;
end;

// ----------------------------------------------------------------------------
procedure TfrmMain.PaintBoxClick(Sender: TObject);
begin
  FWolfram.Rule := FWolfram.Rule XOR Trunc(Power(2, (Sender as TComponent).Tag));
  UpdateDisplay;
end;

// ----------------------------------------------------------------------------
procedure TfrmMain.PaintBoxRulesPaint(Sender: TObject; Canvas: TCanvas);
const
  RECT_TOP = 6;
  RECT_LEFT = 8;
  RECT_SIZE = 16;
  RECT_OFFSET = 19;
var
  LRect: TRectF;
  LPaintBox: TPaintBox;
begin
  LPaintBox := Sender as TPaintBox;

  Canvas.BeginScene;
  try
    Canvas.Stroke.Kind := TBrushKind.Solid;
    Canvas.Stroke.Thickness := 1;

    Canvas.Fill.Color := TAlphaColorRec.White;
    Canvas.FillRect(TRectF.Create(0, 0, LPaintBox.Width, LPaintBox.Height), 1, 1, AllCorners, 100);
    Canvas.Stroke.Color := TAlphaColorRec.Black;
    Canvas.DrawRect(TRectF.Create(0, 0, LPaintBox.Width, LPaintBox.Height), 1, 1, AllCorners, 100);

    LRect := TRectF.Create(RECT_LEFT, RECT_TOP, RECT_LEFT + RECT_SIZE, RECT_TOP + RECT_SIZE);
    Canvas.Fill.Color := TAlphaColorRec.Black;

    // Bit 4
    if (LPaintBox.Tag AND 4) > 0 then
      Canvas.FillRect(LRect, 0, 0, AllCorners, 100)
    else
      Canvas.DrawRect(LRect, 0, 0, AllCorners, 100);

    // Bit 2
    LRect.Left := LRect.Left + RECT_OFFSET;
    LRect.Right := LRect.Left + RECT_SIZE;
    if (LPaintBox.Tag AND 2) > 0 then
      Canvas.FillRect(LRect, 0, 0, AllCorners, 100)
    else
      Canvas.DrawRect(LRect, 0, 0, AllCorners, 100);

    // Bit 1
    LRect.Left := LRect.Left + RECT_OFFSET;
    LRect.Right := LRect.Left + RECT_SIZE;
    if (LPaintBox.Tag AND 1) > 0 then
      Canvas.FillRect(LRect, 0, 0, AllCorners, 100)
    else
      Canvas.DrawRect(LRect, 0, 0, AllCorners, 100);

    // Selected
    LRect.Left := RECT_LEFT + RECT_OFFSET;
    LRect.Right := LRect.Left + RECT_SIZE;
    LRect.Top := LRect.Top + RECT_OFFSET;
    LRect.Bottom := LRect.Top + RECT_SIZE;
    if (FWolfram.Rule AND Trunc(Power(2, LPaintBox.Tag))) > 0 then
      Canvas.FillRect(LRect, 0, 0, AllCorners, 100)
    else
      Canvas.DrawRect(LRect, 0, 0, AllCorners, 100);
  finally
    Canvas.EndScene;
  end;
end;

// ----------------------------------------------------------------------------
procedure TfrmMain.ResetGameSize;
begin
  if Assigned(FWolfram) then
  begin
    FWolfram.Size := Trunc(pbGame.Width / tbScale.Value);
    pbGame.Repaint;
  end;
end;

// ----------------------------------------------------------------------------
procedure TfrmMain.tbScaleChange(Sender: TObject);
begin
  ResetGameSize;
end;

// ----------------------------------------------------------------------------
procedure TfrmMain.UpdateDisplay;
begin
  edtRule.Text := Format('%d', [FWolfram.Rule]);
  LayoutRules.Repaint;
  pbGame.Repaint;
end;

end.
