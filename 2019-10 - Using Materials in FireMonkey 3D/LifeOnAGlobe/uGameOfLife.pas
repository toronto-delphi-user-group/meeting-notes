unit uGameOfLife;

interface

uses
  System.SysUtils, System.StrUtils, System.Types,
  System.Character,
  System.Math;

type
  TGameOfLifeArray = Array of Array of Byte;

  TGameOfLife = class
  private
    FCurrentData: TGameOfLifeArray;
    FNextData: TGameOfLifeArray;
    FWidth: Integer;
    FHeight: Integer;
    FGeneration: Integer;
    FRules: string;
    FBornList: Array of Integer;
    FSurvivalList: Array of Integer;
    function GetHeight: Integer;
    procedure SetHeight(const Value: Integer);
    function GetWidth: Integer;
    procedure SetWidth(const Value: Integer);
    procedure SetRules(const Value: string);
    function GetNeighbourhood(ACol, ARow: Integer): Integer;
    procedure ResizeArray;
    procedure Swap;
  public
    constructor Create;
    procedure Clear;
    procedure FillRandom;
    procedure Step;
    property Data: TGameOfLifeArray read FCurrentData write FCurrentData;
    property Generation: Integer read FGeneration;
    property Rules: string read FRules write SetRules;
    property Height: Integer read GetHeight write SetHeight;
    property Width: Integer read GetWidth write SetWidth;
  end;

implementation

// TGameOfLife
// ============================================================================
constructor TGameOfLife.Create;
const
  DEFAULT_WIDTH = 0;
  DEFAULT_HEIGHT = 0;
  DEFAULT_RULES = 'b3/s23';
begin
  SetWidth(DEFAULT_WIDTH);
  SetHeight(DEFAULT_HEIGHT);
  SetRules(DEFAULT_RULES);
end;

// ----------------------------------------------------------------------------
procedure TGameOfLife.Clear;
begin
  SetLength(FCurrentData, 0, 0);
  ResizeArray;
end;

// ----------------------------------------------------------------------------
procedure TGameOfLife.FillRandom;
var
  i, j: Integer;
begin
  for i := 0 to FWidth - 1 do
    for j := 0 to FHeight - 1 do
      FCurrentData[i, j] := Random(2);
end;

// ----------------------------------------------------------------------------
function TGameOfLife.GetHeight: Integer;
begin
  Result := FHeight;
end;

// ----------------------------------------------------------------------------
procedure TGameOfLife.SetHeight(const Value: Integer);
begin
  FHeight := Value;
  ResizeArray;
end;

// ----------------------------------------------------------------------------
function TGameOfLife.GetWidth: Integer;
begin
  Result := FWidth;
end;

// ----------------------------------------------------------------------------
procedure TGameOfLife.SetWidth(const Value: Integer);
begin
  FWidth := Value;
  ResizeArray;
end;

// ----------------------------------------------------------------------------
procedure TGameOfLife.SetRules(const Value: string);
var
  c: Char;
  LRuleList: TStringDynArray;
  LBornRules: string;
  LSurvivalRules: string;
begin
  FRules := Value;

  LRuleList := FRules.split(['/']);
  if AnsiStartsText('B', LRuleList[0]) then
  begin
    LBornRules := LRuleList[0];
    LSurvivalRules := LRuleList[1];
  end
  else
  begin
    LBornRules := LRuleList[1];
    LSurvivalRules := LRuleList[0];
  end;

  SetLength(FBornList, 0);
  for c in LBornRules do
  begin
    if c.IsDigit then
      FBornList := FBornList + [StrToInt(c)];
  end;

  SetLength(FSurvivalList, 0);
  for c in LSurvivalRules do
  begin
    if c.IsDigit then
      FSurvivalList := FSurvivalList + [StrToInt(c)];
  end;
end;

// ----------------------------------------------------------------------------
function TGameOfLife.GetNeighbourhood(ACol, ARow: Integer): Integer;
var
  i, j: Integer;
begin
  Result := 0;

  for i := -1 to 1 do
    for j := -1 to 1 do
      Result := Result +
        FCurrentData[(FWidth + ACol + i) MOD FWidth, (FHeight + ARow + j) MOD FHeight];

  Result := Result - FCurrentData[ACol, ARow];
end;

// ----------------------------------------------------------------------------
procedure TGameOfLife.ResizeArray;
begin
  SetLength(FCurrentData, FWidth, FHeight);
  SetLength(FNextData, FWidth, FHeight);
end;

// ----------------------------------------------------------------------------
procedure TGameOfLife.Step;
var
  i, j: Integer;
  LNeighbourCount: Integer;
  LRule: Integer;
  LCellValue: Integer;
  LNewCellValue: Integer;
begin
  for i := 0 to FWidth - 1 do
  begin
    for j := 0 to FHeight - 1 do
    begin
      LCellValue := FCurrentData[i, j];
      LNeighbourCount := GetNeighbourhood(i, j);
      LNewCellValue := 0;
      if LCellValue = 0 then
      begin
        for LRule in FBornList do
          if LNeighbourCount = LRule then
            LNewCellValue := 1;
      end
      else if LCellValue = 1 then
      begin
        for LRule in FSurvivalList do
          if LNeighbourCount = LRule then
            LNewCellValue := 1;
      end;

      FNextData[i, j] := LNewCellValue;
    end;
  end;

  Swap;
end;

// ----------------------------------------------------------------------------
procedure TGameOfLife.Swap;
var
  LTemp: TGameOfLifeArray;
begin
  LTemp := FCurrentData;
  FCurrentData := FNextData;
  FNextData := LTemp;
end;

end.
