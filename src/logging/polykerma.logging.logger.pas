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
;

type
{ TLogType }
  TLogType = (
    pltDefault,
    pltInfo,
    pltWarn,
    pltError,
    pltDebug
  );

{ TLogger }
  TLogger = class(TObject)
  private
  protected
  public
    procedure Log(const ALogType: TLogType; const AMessage: String);
  published
  end;
  TInterfacedLoggerClass = class of TLogger;

implementation

{ TLogger }

procedure TLogger.Log(const ALogType: TLogType;
  const AMessage: String);
begin
  case ALogType of
    pltDefault: WriteLn(Format('%s %s', [ DateToISO8601(Now), AMessage ]));
    pltInfo: WriteLn(Format   ('%s INFO: %s', [ DateToISO8601(Now), AMessage ]));
    pltWarn: WriteLn(Format   ('%s WARN: %s', [ DateToISO8601(Now), AMessage ]));
    pltError: WriteLn(Format  ('%s ERROR: %s', [ DateToISO8601(Now), AMessage ]));
    pltDebug: WriteLn(Format  ('%s DEBUG: %s', [ DateToISO8601(Now), AMessage ]));
  end;

end;

end.

