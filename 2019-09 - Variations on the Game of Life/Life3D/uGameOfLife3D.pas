unit uGameOfLife3D;

interface

uses
  System.SysUtils, System.StrUtils, System.Types,
  System.Character,
  System.Math;

type
  TGameOfLife3DArray = Array of Array of Array of Byte;

  TGameOfLife3D = class
  private
    FCurrentData: TGameOfLife3DArray;
    FNextData: TGameOfLife3DArray;
    FWidth: Integer;
    FHeight: Integer;
    FDepth: Integer;
    FGeneration: Integer;
    FRules: string;
    FBornList: Array of Integer;
    FSurvivalList: Array of Integer;
    function GetWidth: Integer;
    function GetHeight: Integer;
    function GetDepth: Integer;
    procedure SetRules(const Value: string);
    function GetNeighbourhood(AX, AY, AZ: Integer): Integer;
    procedure ResizeArray;
    procedure Swap;
  public
    constructor Create;
    procedure Clear;
    procedure FillRandom;
    procedure Step;
    procedure SetSize(AWidth, AHeight, ADepth: Integer);
    property Data: TGameOfLife3DArray read FCurrentData write FCurrentData;
    property Generation: Integer read FGeneration;
    property Rules: string read FRules write SetRules;
    property Width: Integer read GetWidth;
    property Height: Integer read GetHeight;
    property Depth: Integer read GetDepth;
  end;

implementation


// TGameOfLife3D
// ============================================================================
constructor TGameOfLife3D.Create;
const
  DEFAULT_SIZE = 0;
  // DEFAULT_RULES = '5,6,7/6';
  DEFAULT_RULES = '2,3,4,5,6,7/5';
begin
  SetSize(DEFAULT_SIZE, DEFAULT_SIZE, DEFAULT_SIZE);
  SetRules(DEFAULT_RULES);
end;

// ----------------------------------------------------------------------------
procedure TGameOfLife3D.Clear;
begin
  SetLength(FCurrentData, 0, 0, 0);
  ResizeArray;
end;

// ----------------------------------------------------------------------------
procedure TGameOfLife3D.FillRandom;
var
  i, j, k: Integer;
begin
  for i := 0 to FWidth - 1 do
    for j := 0 to FHeight - 1 do
      for k := 0 to FDepth - 1 do
        FCurrentData[i, j, k] := Random(2);
end;

// ----------------------------------------------------------------------------
function TGameOfLife3D.GetWidth: Integer;
begin
  Result := FWidth;
end;

// ----------------------------------------------------------------------------
function TGameOfLife3D.GetHeight: Integer;
begin
  Result := FHeight;
end;

// ----------------------------------------------------------------------------
function TGameOfLife3D.GetDepth: Integer;
begin
  Result := FDepth;
end;

// ----------------------------------------------------------------------------
function TGameOfLife3D.GetNeighbourhood(AX, AY, AZ: Integer): Integer;
var
  i, j, k: Integer;
begin
  Result := 0;

  for i := -1 to 1 do
    for j := -1 to 1 do
      for k := -1 to 1 do
      begin
        Result := Result +
          FCurrentData[(FWidth + AX + i) MOD FWidth, (FHeight + AY + j) MOD FHeight, (FDepth + AZ + k) MOD FDepth];
      end;

  Result := Result - FCurrentData[AX, AY, AZ];
end;

// ----------------------------------------------------------------------------
procedure TGameOfLife3D.ResizeArray;
begin
  SetLength(FCurrentData, FWidth, FHeight, FDepth);
  SetLength(FNextData, FWidth, FHeight, FDepth);
end;

// ----------------------------------------------------------------------------
procedure TGameOfLife3D.SetRules(const Value: string);
var
  s: string;
  LRuleList: TStringDynArray;
  LTempList: TStringDynArray;
  LBornRules: string;
  LSurvivalRules: string;
begin
  FRules := Value;

  LRuleList := FRules.split(['/']);
  if AnsiStartsText('B', LRuleList[0]) then
  begin
    LBornRules := LRuleList[0];
    Delete(LBornRules, 1, 1);
    LSurvivalRules := LRuleList[1];
    Delete(LSurvivalRules, 1, 1);
  end
  else
  begin
    LBornRules := LRuleList[1];
    LSurvivalRules := LRuleList[0];
  end;

  SetLength(FBornList, 0);
  LTempList := LBornRules.split([',']);
  for s in LTempList do
  begin
    FBornList := FBornList + [StrToInt(s)];
  end;

  SetLength(FSurvivalList, 0);
  LTempList := LSurvivalRules.split([',']);
  for s in LTempList do
  begin
    FSurvivalList := FSurvivalList + [StrToInt(s)];
  end;
end;

// ----------------------------------------------------------------------------
procedure TGameOfLife3D.SetSize(AWidth, AHeight, ADepth: Integer);
begin
  FWidth := AWidth;
  FHeight := AHeight;
  FDepth := ADepth;
  ResizeArray;
end;

// ----------------------------------------------------------------------------
procedure TGameOfLife3D.Step;
var
  i, j, k: Integer;
  LNeighbourCount: Integer;
  LRule: Integer;
  LCellValue: Integer;
  LNewCellValue: Integer;
begin
  for i := 0 to FWidth - 1 do
  begin
    for j := 0 to FHeight - 1 do
    begin
      for k := 0 to FDepth - 1 do
      begin
        LCellValue := FCurrentData[i, j, k];
        LNeighbourCount := GetNeighbourhood(i, j, k);
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

        FNextData[i, j, k] := LNewCellValue;
      end;
    end;
  end;

  Swap;
end;

// ----------------------------------------------------------------------------
procedure TGameOfLife3D.Swap;
var
  LTemp: TGameOfLife3DArray;
begin
  LTemp := FCurrentData;
  FCurrentData := FNextData;
  FNextData := LTemp;
end;

end.
