unit PolyKerma.Threads.Interfaces;

{$mode ObjFPC}{$H+}

interface

uses
  Classes
;

type
{ IThread }
  IThread = interface
    ['{5D340B25-31E7-40C3-A5AB-8AFE68AA31C0}']

    procedure Start;
    procedure Resume;
    procedure Terminate;
    function WaitFor: Integer;

  end;

implementation

end.

