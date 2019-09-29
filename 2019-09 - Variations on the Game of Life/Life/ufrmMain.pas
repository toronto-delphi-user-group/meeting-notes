unit ufrmMain;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Layouts, uGameOfLife, FMX.Edit;

type
  TfrmMain = class(TForm)
    LayoutLeft: TLayout;
    tbScale: TTrackBar;
    LayoutClient: TLayout;
    LayoutBottom: TLayout;
    pbGame: TPaintBox;
    btnRandom: TButton;
    btnStep: TButton;
    Timer1: TTimer;
    btnRunPause: TButton;
    lblRules: TLabel;
    edtRules: TEdit;
    btnClear: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnClearClick(Sender: TObject);
    procedure btnRandomClick(Sender: TObject);
    procedure btnRunPauseClick(Sender: TObject);
    procedure btnStepClick(Sender: TObject);
    procedure pbGameMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Single);
    procedure pbGamePaint(Sender: TObject; Canvas: TCanvas);
    procedure pbGameResized(Sender: TObject);
    procedure tbScaleChange(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure pbGameMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure edtRulesValidate(Sender: TObject; var Text: string);
  private
    FLife: TGameOfLife;
    procedure ResetGameSize;
    procedure SetCellValue(Shift: TShiftState; X, Y: Single);
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
  edtRules.Text := FLife.Rules;
  ResetGameSize;
end;

// ----------------------------------------------------------------------------
procedure TfrmMain.FormDestroy(Sender: TObject);
begin
  FLife.Free;
end;

// ----------------------------------------------------------------------------
procedure TfrmMain.btnClearClick(Sender: TObject);
begin
  FLife.Clear;
  pbGame.Repaint;
end;

// ----------------------------------------------------------------------------
procedure TfrmMain.btnRandomClick(Sender: TObject);
begin
  FLife.FillRandom;
  pbGame.Repaint;
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
  FLife.Step;
  pbGame.Repaint;
end;

// ----------------------------------------------------------------------------
procedure TfrmMain.edtRulesValidate(Sender: TObject; var Text: string);
begin
  FLife.Rules := edtRules.Text;
end;

// ----------------------------------------------------------------------------
procedure TfrmMain.tbScaleChange(Sender: TObject);
begin
  ResetGameSize;
end;

// ----------------------------------------------------------------------------
procedure TfrmMain.Timer1Timer(Sender: TObject);
begin
  Timer1.Enabled := False;
  try
    FLife.Step;
    pbGame.Repaint;
  finally
    Timer1.Enabled := True;
  end;
end;

// ----------------------------------------------------------------------------
procedure TfrmMain.pbGameMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Single);
begin
  if (ssLeft in Shift) or (ssRight in Shift) then
    SetCellValue(Shift, X, Y);
end;

// ----------------------------------------------------------------------------
procedure TfrmMain.pbGameMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Single);
begin
  if (ssLeft in Shift) or (ssRight in Shift) then
    SetCellValue(Shift, X, Y);
end;

// ----------------------------------------------------------------------------
procedure TfrmMain.pbGamePaint(Sender: TObject; Canvas: TCanvas);
var
  LRect: TRectF;
  LRow: Integer;
  LCol: Integer;
  LScale: Integer;
  LOffset: Integer;
begin
  Canvas.BeginScene;
  try
    LRect := pbGame.BoundsRect;

    Canvas.Fill.Color := TAlphaColorRec.White;
    Canvas.DrawRect(LRect, 0, 0, AllCorners, 100);

    Canvas.Fill.Color := TAlphaColorRec.Lightgray;
    Canvas.FillRect(LRect, 0, 0, AllCorners, 100);

    LScale := Trunc(tbScale.Value);

    LOffset := 0;
    if LScale > 2 then
      LOffset := 1;
    if LScale > 8 then
      LOffset := 2;

    for LRow := 0 to FLife.Height - 1 do
    begin
      for LCol := 0 to FLife.Width - 1 do
      begin
        LRect.Left := LCol * LScale;
        LRect.Top := LRow * LScale;
        LRect.Right := LRect.Left + LScale - LOffset;
        LRect.Bottom := LRect.Top + LScale - LOffset;

        if FLife.Data[LCol, LRow] = 1 then
          Canvas.Fill.Color := TAlphaColorRec.Black
        else
          Canvas.Fill.Color := TAlphaColorRec.White;

        Canvas.FillRect(LRect, 0, 0, AllCorners, 100);
      end;
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
procedure TfrmMain.ResetGameSize;
begin
  if Assigned(FLife) then
  begin
    FLife.Width := Trunc(pbGame.Width / tbScale.Value);
    FLife.Height := Trunc(pbGame.Height / tbScale.Value);
    pbGame.Repaint;
  end;
end;

// ----------------------------------------------------------------------------
procedure TfrmMain.SetCellValue(Shift: TShiftState; X, Y: Single);
begin
  if ssLeft in Shift then
  begin
    FLife.Data[Trunc(X / tbScale.Value), Trunc(Y / tbScale.Value)] := 1;
    pbGame.Repaint;
  end;

  if ssRight in Shift then
  begin
    FLife.Data[Trunc(X / tbScale.Value), Trunc(Y / tbScale.Value)] := 0;
    pbGame.Repaint;
  end;
end;

end.
