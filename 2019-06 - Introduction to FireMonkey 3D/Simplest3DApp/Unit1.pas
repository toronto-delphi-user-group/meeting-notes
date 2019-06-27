unit Unit1;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms3D, FMX.Types3D, FMX.Forms, FMX.Graphics, 
  FMX.Dialogs, System.Math.Vectors, FMX.Ani, FMX.Objects3D, FMX.MaterialSources,
  FMX.Controls3D;

type
  TForm1 = class(TForm3D)
    Dummy1: TDummy;
    TextureMaterialSource1: TTextureMaterialSource;
    Sphere1: TSphere;
    FloatAnimation1: TFloatAnimation;
  private
  public
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}

end.
