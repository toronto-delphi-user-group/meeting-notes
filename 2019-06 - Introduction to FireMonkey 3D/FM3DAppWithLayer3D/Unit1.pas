unit Unit1;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms3D, FMX.Types3D, FMX.Forms, FMX.Graphics, 
  FMX.Dialogs, System.Math.Vectors, FMX.Objects3D, FMX.Controls.Presentation,
  FMX.StdCtrls, FMX.Layers3D, FMX.Controls3D;

type
  TForm1 = class(TForm3D)
    Dummy1: TDummy;
    Layer3D1: TLayer3D;
    Button1: TButton;
    Button2: TButton;
    StrokeCube1: TStrokeCube;
  private
  public
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}

end.
