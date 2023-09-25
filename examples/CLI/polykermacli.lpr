program PolyKermaCLI;

{$IFDEF DELPHI}
{$APPLICATION CONSOLE}
{$ENDIF}

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}
  cthreads,
  {$ENDIF UNIX}

  {$IFDEF FPC_DOTTEDUNITS}
  System.Classes
, System.SysUtils
  {$ELSE FPC_DOTTEDUNITS}
  Classes
, SysUtils
  {$ENDIF FPC_DOTTEDUNITS}
, CustApp
  { you can add units after this }
  // Logging
, PolyKerma.Logging

  // Dispatching
, PolyKerma.Dispatching.Interfaces
, PolyKerma.Dispatching.Dispatcher

  // Modules
, PolyKerma.Modules.Interfaces
, PolyKerma.Modules.Module
;

type

{ TPolyKermaCLI }
  TPolyKermaCLI = class(TCustomApplication)
  private
    FDispatcher: IDispatcher;

    procedure LoadParams;
    procedure PolyKermaSetup;
    procedure PolyKermaTearDown;
  protected
    procedure DoRun; override;
  public
    constructor Create(TheOwner: TComponent); override;
    destructor Destroy; override;
    procedure WriteHelp; virtual;
  end;

{ TPolyKermaCLI }

constructor TPolyKermaCLI.Create(TheOwner: TComponent);
begin
  inherited Create(TheOwner);
  StopOnException:= True;
end;

destructor TPolyKermaCLI.Destroy;
begin
  inherited Destroy;
end;

procedure TPolyKermaCLI.LoadParams;
var
  ErrorOptions: String;
begin
  // quick check parameters
  ErrorOptions:= CheckOptions('h', 'help');
  if ErrorOptions <> '' then begin
    Debug({$I %FILE%}, {$I %LINE%}, ErrorOptions);
    Terminate;
    Exit;
  end;

  // parse parameters
  if HasOption('h', 'help') then begin
    WriteHelp;
    Terminate;
    Exit;
  end;
end;

procedure TPolyKermaCLI.PolyKermaSetup;
var
  module: IModule;
begin
  FDispatcher:= TInterfacedDispatcher.Create;
  module:= TInterfacedModule.Create(FDispatcher);
end;

procedure TPolyKermaCLI.PolyKermaTearDown;
begin
  // Not quite sure I'll need this, but just in case...
end;

procedure TPolyKermaCLI.WriteHelp;
begin
  { add your help code here }
  WriteLn('Usage: polykerma [-h|--help]');
end;

procedure TPolyKermaCLI.DoRun;
begin
  LoadParams;

  PolyKermaSetup;

  // stop program loop
  Terminate;
end;

var
  Application: TPolyKermaCLI;
begin
  Application:= TPolyKermaCLI.Create(nil);
  Application.Title:= 'PolyKerma CLI Example';
  Application.Run;
  Application.Free;
end.

