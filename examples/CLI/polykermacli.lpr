program PolyKermaCLI;

{$IFDEF DELPHI}
{$APPLICATION CONSOLE}
{$ENDIF}

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}
  cthreads,
  BaseUnix,
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
, PolyKerma.Dispatching
, PolyKerma.Dispatching.Dispatcher
, PolyKerma.Dispatching.Message

  // Modules
, PolyKerma.Modules.Module
;

type
{ TPolyKermaCLI }
  TPolyKermaCLI = class(TCustomApplication)
  private
    FDispatcher: TDispatcher;
    procedure LoadParams;
    procedure PolyKermaSetup;
    procedure PolyKermaTearDown;
  protected
    procedure DoRun; override;
  public
    constructor Create(TheOwner: TComponent); override;
    destructor Destroy; override;
    procedure WriteHelp; virtual;

    property Dispatcher: TDispatcher
      read FDispatcher;
  end;

var
  Application: TPolyKermaCLI;

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
    Error({$I %FILE%}, {$I %LINE%}, ErrorOptions);
    Terminate(1);
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
  module: TModule;
  message: TMessage;
  //commsModule: TModuleCOmms;
  //controllerModule: TModuleController;
  //modelModule: TModuleModel;
begin
  FDispatcher:= TDispatcher.Create;

  module:= TModule.Create(@FDispatcher.Post);
  // Registering outside the constructor just for the base class
  FDispatcher.Register(cChannelModuleIn, module);
  module:= TModule.Create(@FDispatcher.Post);
  // Registering outside the constructor just for the base class
  FDispatcher.Register(cChannelModuleIn, module);
  module:= TModule.Create(@FDispatcher.Post);
  // Registering outside the constructor just for the base class
  FDispatcher.Register(cChannelModuleIn, module);

  { #todo -ogcarreno -cPolyKerma.Core : Add the Comms, Model and Controller }
  (*controllerModule:= TModuleController.Create(FDispatcher);
  FDispatcher.Register(cChannelControllerIn, module);
  modelModule:= TModule.Create(FDispatcher);
  FDispatcher.Register(cChannelModelIn, modelModule);
  commsModule:= TModule.Create(FDispatcher);
  FDispatcher.Register(cChannelCommsIn, commsModule);*)

  { #todo -ogcarreno -cPolyKerma.Example : Needs removing after tests are done }
  message:= TMessage.Create(cChannelModuleIn);
  FDispatcher.Post(message);
  message:= TMessage.Create(cChannelModuleIn);
  FDispatcher.Post(message);
  message:= TMessage.Create(cChannelModuleIn);
  FDispatcher.Post(message);
  message:= TMessage.Create(cChannelModuleIn);
  FDispatcher.Post(message);
  message:= TMessage.Create(cChannelModuleIn);
  FDispatcher.Post(message);
  message:= TMessage.Create(cChannelModuleIn);
  FDispatcher.Post(message);
  message:= TMessage.Create(cChannelModuleIn);
  FDispatcher.Post(message);
  message:= TMessage.Create(cChannelModuleIn);
  FDispatcher.Post(message);

end;

procedure TPolyKermaCLI.PolyKermaTearDown;
begin
  FDispatcher.Free;
end;


procedure TPolyKermaCLI.WriteHelp;
begin
  { add your help code here }
  WriteLn('Usage: polykermacli [-h|--help]');
end;

{$IFDEF UNIX}
procedure HandleSigInt(aSignal: LongInt); cdecl;
begin
  WriteLn(#13#10'Ctrl+C was pressed, terminating');
  Application.Dispatcher.Terminate;
end;
{$ENDIF UNIX}

procedure TPolyKermaCLI.DoRun;
begin
  LoadParams;

  if not Terminated then
  begin
    PolyKermaSetup;
    {$IFDEF UNIX}
    if FpSignal(SigInt, @HandleSigInt) = signalhandler(SIG_ERR) then begin
      Error({$I %FILE%}, {$I %LINE%}, Format('Failed to install signal error: %d', [ fpGetErrno ]));
      Halt(1);
    end;
    {$ENDIF UNIX}

    FDispatcher.Run(True);
    PolyKermaTearDown;
  end;

  // stop program loop
  Terminate;
end;

begin
  Application:= TPolyKermaCLI.Create(nil);
  Application.Title:= 'PolyKerma CLI Example';
  Application.Run;
  Application.Free;
end.

