unit PolyKerma.Threading.Interfaces;

{$mode ObjFPC}{$H+}

interface

uses
{$IFDEF FPC_DOTTEDUNITS}
  System.Classes
{$ELSE FPC_DOTTEDUNITS}
  Classes
{$ENDIF FPC_DOTTEDUNITS}
;

type
{ IThread }
  IThread = interface
    ['{EAA30789-6A3B-47FB-B6D7-20338C8E5F89}']

    procedure Start;
    procedure Resume;
    procedure Terminate;
    function WaitFor: Integer;

  end;

{ IThreadProcessMessages }
  IThreadProcessMessages = interface(IThread)
    ['{4F58FD48-C5DA-4DC4-960F-A9FEA4591C79}']

  end;

implementation

end.

