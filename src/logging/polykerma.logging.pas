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
;

procedure DebugLn(const AMessage: String);
procedure DebugLn(const ASourceFile: String; const ASourceLine: String;
  const AMessage: String);

implementation

procedure DebugLn(const AMessage: String);
begin
  WriteLn(Format('%s INFO: %s', [ DateToISO8601(Now), AMessage ]));
end;

procedure DebugLn(const ASourceFile: String; const ASourceLine: String;
  const AMessage: String);
begin
  DebugLn(Format('%s:%s %s', [ ASourceFile, ASourceLine, AMessage ]));
end;

end.

