unit PolyKerma.Logging.Interfaces;

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
{ TLogType }
  TLogType = (
    pltInfo,
    pltWarn,
    pltError,
    pltDebug
  );

{ ILogger }
  ILogger = Interface
  ['{87D36451-1415-46A9-8E49-20498BDD6BFF}']
    procedure Log(const ALogType: TLogType; const AMessage: String);
  end;

implementation

end.

