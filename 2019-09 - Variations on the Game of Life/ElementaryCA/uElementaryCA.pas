unit uElementaryCA;

interface

uses
  System.Math;

type
  TElementaryCAArray = Array of Byte;

  TElementaryCA = class
  private
    FCurrentData: TElementaryCAArray;
    FNextData: TElementaryCAArray;
    FRule: Byte;
    FSize: Integer;
    FGeneration: Integer;
    function GetNeighbourhood(ACell: Integer): Integer;
    procedure SetRule(const Value: Byte);
    function GetSize: Integer;
    procedure SetSize(const Value: Integer);
    procedure Swap;
  public
    constructor Create;
    procedure Clear;
    procedure Step;
    property Data: TElementaryCAArray read FCurrentData write FCurrentData;
    property Generation: Integer read FGeneration;
    property Rule: Byte read FRule write SetRule;
    property Size: Integer read GetSize write SetSize;
  end;

implementation


// TElementaryCA
// ============================================================================
constructor TElementaryCA.Create;
const
  DEFAULT_LENGTH = 0;
  DEFAULT_RULE = 30;
begin
  SetSize(DEFAULT_LENGTH);
  FRule := DEFAULT_RULE;
end;

// ----------------------------------------------------------------------------
procedure TElementaryCA.Clear;
var
  i: Integer;
begin
  for i := 0 to Length(FCurrentData) - 1 do
  begin
    FCurrentData[i] := 0;
    FNextData[i] := 0;
  end;

  if Size > 0 then
    FCurrentData[Size DIV 2] := 1;
  FGeneration := 0;
end;

// ----------------------------------------------------------------------------
function TElementaryCA.GetNeighbourhood(ACell: Integer): Integer;
begin
  Result := 4 * FCurrentData[(Size + ACell - 1) MOD Size]
    + 2 * FCurrentData[(Size + ACell) MOD Size]
    + 1 * FCurrentData[(Size + ACell + 1) MOD Size];
end;

// ----------------------------------------------------------------------------
procedure TElementaryCA.SetRule(const Value: Byte);
begin
  FRule := Value;
  Clear;
end;

// ----------------------------------------------------------------------------
function TElementaryCA.GetSize: Integer;
begin
  Result := FSize;
end;

// ----------------------------------------------------------------------------
procedure TElementaryCA.SetSize(const Value: Integer);
begin
  SetLength(FCurrentData, Value);
  SetLength(FNextData, Value);
  FSize := Value;
  Clear;
end;

// ----------------------------------------------------------------------------
procedure TElementaryCA.Step;
var
  i: Integer;
  LNeighbourhood: Integer;
  LRuleBit: Integer;
begin
  for i := 0 to Length(FCurrentData) - 1 do
  begin
    LNeighbourhood := GetNeighbourhood(i);
    LRuleBit := Trunc(Power(2, LNeighbourhood));
    if (FRule AND LRuleBit) > 0 then
      FNextData[i] := 1
    else
      FNextData[i] := 0;
  end;

  Inc(FGeneration);
  Swap;
end;

// -----------------------------------------------------------------------------
procedure TElementaryCA.Swap;
var
  LTemp: TElementaryCAArray;
begin
  LTemp := FCurrentData;
  FCurrentData := FNextData;
  FNextData := LTemp;
end;

end.
