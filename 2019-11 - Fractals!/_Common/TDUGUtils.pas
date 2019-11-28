unit TDUGUtils;

interface

function Map(AValue, AInputMin, AInputMax, AOutputMin, AOutputMax: Double): Double;

implementation

// ----------------------------------------------------------------------------
function Map(AValue, AInputMin, AInputMax, AOutputMin, AOutputMax: Double): Double;
begin
  Result := AOutputMin + (AOutputMax - AOutputMin) * ((AValue - AInputMin) / (AInputMax - AInputMin));
end;

end.
