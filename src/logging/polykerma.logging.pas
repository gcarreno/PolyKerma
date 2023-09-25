unit PolyKerma.Logging;

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
, PolyKerma.Logging.Logger
;


procedure Debug(const AMessage: String);
procedure Debug(const ASourceFile: String; const ASourceLine: String;
  const AMessage: String);

var
  Logger: ILogger;

implementation

procedure Debug(const AMessage: String);
begin
  Logger.Log(pltDebug, AMessage);
end;

procedure Debug(const ASourceFile: String; const ASourceLine: String;
  const AMessage: String);
begin
  Logger.Log(pltDebug, Format('%s:%s %s', [
    ASourceFile,
    ASourceLine,
    AMessage
  ]));
end;

initialization
  Logger:= TInterfacedLogger.Create;
end.

