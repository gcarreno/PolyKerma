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
, PolyKerma.Logging.Logger
;


procedure Debug(const AMessage: String);
procedure Debug(const ASourceFile: String; const ASourceLine: String;
  const AMessage: String);
procedure Error(const AMessage: String);
procedure Error(const ASourceFile: String; const ASourceLine: String;
  const AMessage: String);

var
  Logger: TLogger;

implementation

procedure Debug(const AMessage: String);
begin
  if Assigned(Logger) then
  begin
    Logger.Log(pltDebug, AMessage);
  end;
end;

procedure Debug(const ASourceFile: String; const ASourceLine: String;
  const AMessage: String);
begin
  if Assigned(Logger) then
  begin
    Logger.Log(pltDebug, Format('%s:%s %s', [
      ASourceFile,
      ASourceLine,
      AMessage
    ]));
  end;
end;

procedure Error(const AMessage: String);
begin
  if Assigned(Logger) then
  begin
    Logger.Log(pltError, AMessage);
  end;
end;

procedure Error(const ASourceFile: String; const ASourceLine: String;
  const AMessage: String);
begin
  if Assigned(Logger) then
  begin
    Logger.Log(pltError, Format('%s:%s %s', [
      ASourceFile,
      ASourceLine,
      AMessage
    ]));
  end;
end;

initialization
  Logger:= TLogger.Create;
finalization
  Logger.Free;
  Logger:= nil;
end.

