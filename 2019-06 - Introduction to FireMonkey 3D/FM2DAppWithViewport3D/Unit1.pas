unit Unit1;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  System.Math.Vectors, FMX.Controls3D, FMX.Objects3D, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.Viewport3D;

type
  TForm1 = class(TForm)
    Viewport3D1: TViewport3D;
    Button1: TButton;
    Button2: TButton;
    Panel1: TPanel;
    StrokeCube1: TStrokeCube;
    Dummy1: TDummy;
  private
  public
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}

end.
