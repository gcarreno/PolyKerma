unit PolyKerma.Logging.Logger;

{$mode ObjFPC}{$H+}

interface

uses
{$IFDEF FPC_DOTTEDUNITS}
  System.Classes
, System.SysUtils
, System.DateUtils
{$ELSE FPC_DOTTEDUNITS}
  Classes
, SysUtils
, DateUtils
{$ENDIF FPC_DOTTEDUNITS}
, PolyKerma.Logging.Interfaces
;

type
{ TInterfacedLogger }
  TInterfacedLogger = class(TInterfacedObject, ILogger)
  private
  protected
  public
    procedure Log(const ALogType: TLogType; const AMessage: String);
  published
  end;

implementation

{ TInterfacedLogger }

procedure TInterfacedLogger.Log(const ALogType: TLogType;
  const AMessage: String);
begin
  case ALogType of
    pltInfo: WriteLn(Format  ('%s INFO: %s', [ DateToISO8601(Now), AMessage ]));
    pltWarn: WriteLn(Format  ('%s WARN: %s', [ DateToISO8601(Now), AMessage ]));
    pltError: WriteLn(Format('%s ERROR: %s', [ DateToISO8601(Now), AMessage ]));
    pltDebug: WriteLn(Format('%s DEBUG: %s', [ DateToISO8601(Now), AMessage ]));
  otherwise
  end;

end;

end.

