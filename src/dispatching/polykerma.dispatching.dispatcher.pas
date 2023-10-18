unit PolyKerma.Dispatching.Dispatcher;

{$mode objfpc}{$H+}

interface

uses
{$IFDEF FPC_DOTTEDUNITS}
  System.Classes
, System.SysUtils
{$ELSE FPC_DOTTEDUNITS}
  Classes
, SysUtils
{$ENDIF FPC_DOTTEDUNITS}
, SyncObjs
, contnrs
, PolyKerma.Logging
, PolyKerma.Dispatching.Message
, PolyKerma.Modules.Module
, PolyKerma.Threading.ThreadProcessMessages
;

type
{ TDispatcher }
  TDispatcher = class(TObject)
  private
    FMessageList: TFPObjectList;
    FChannelsCriticalSection: TCriticalSection;
    FChannelList: TFPHashObjectList;
    FThreadProcessMessages: TThreadProcessMessages;

    procedure ProcessMessage(const AMessage: TMessage); virtual;
  protected
  public
    constructor Create;
    destructor Destroy; override;

    procedure Post(const AMessage: TMessage);
    function Register(const AChannel: String; const AModule: TModule): Boolean;
    procedure Run(const WaitFor: Boolean);
    procedure Terminate;

  published
  end;
  TDispatcherClass = class of TDispatcher;

implementation

{ TDispatcher }

constructor TDispatcher.Create;
begin
  Debug({$I %FILE%}, {$I %LINE%}, 'Dispatcher Create');
  // Messages
  FMessageList:= TFPObjectList.Create;
  FMessageList.OwnsObjects:= True;
  // Channels
  FChannelsCriticalSection:= TCriticalSection.Create;
  FChannelList:= TFPHashObjectList.Create(True);
  FChannelList.OwnsObjects:= True;
  // Message Thread
  FThreadProcessMessages:= TThreadProcessMessages.Create(
    'Dispatcher',
    @ProcessMessage,
    FMessageList,
    True
  );
  FThreadProcessMessages.FreeOnterminate:= False;
  FThreadProcessMessages.Start;
end;

destructor TDispatcher.Destroy;
begin
  Debug({$I %FILE%}, {$I %LINE%}, 'Dispatcher Destroy');
  // Message Thread
  FThreadProcessMessages.Terminate;
  FThreadProcessMessages.WaitFor;
  FThreadProcessMessages.Free;
  // Channels
  FChannelList.Clear;
  FChannelList.Free;
  FChannelsCriticalSection.Free;
  // Messages
  FMessageList.Clear;
  FMessageList.Free;
  inherited Destroy;
end;

procedure TDispatcher.ProcessMessage(const AMessage: TMessage);
var
  modules: TFPObjectList;
  module: TModule;
  message: TMessage;
  indexModules: Integer;
begin
  Debug({$I %FILE%}, {$I %LINE%}, Format('Dispatcher Process Message: %s', [
    AMessage.Channel
  ]));
  FChannelsCriticalSection.Acquire;
  try
    modules:= FChannelList.Find(AMessage.Channel) as TFPObjectList;
    if Assigned(modules) then
    begin
      for indexModules:= 0 to Pred(modules.Count) do
      begin
        module:= modules[indexModules] as TModule;
        message:= AMessage.Copy;
        Debug({$I %FILE%}, {$I %LINE%}, 'Dispatch Process Message: About to call Receive on module');
        module.Receive(message);
        message.Free;
        Debug({$I %FILE%}, {$I %LINE%}, 'Dispatch Process Message: Done calling Receive on module');
      end;
    end;
  finally
    FChannelsCriticalSection.Release;
  end;
end;

function TDispatcher.Register(const AChannel: String;
  const AModule: TModule): Boolean;
var
  modules: TFPObjectList;
begin
  Result:= false;
  Debug({$I %FILE%}, {$I %LINE%}, 'Dispatcher Register');
  FChannelsCriticalSection.Acquire;
  try
    try
      modules:= FChannelList.Find(AChannel) as TFPObjectList;
      if Assigned(modules) then
      begin
        modules.Add(AModule);
      end
      else
      begin
        modules:= TFPObjectList.Create;
        modules.OwnsObjects:= True;
        modules.Add(AModule);
        FChannelList.Add(AChannel, modules);
      end;
    finally
      FChannelsCriticalSection.Release;
    end;
  except
    on E: Exception do
    begin
      Error({$I %FILE%}, {$I %LINE%}, Format('Dispatcher Register: %s', [
        E.Message
      ]));
      Result:= False;
    end;
  end;
end;

procedure TDispatcher.Run(const WaitFor: Boolean);
begin
  Debug({$I %FILE%}, {$I %LINE%}, 'Dispatcher Run');
  if WaitFor then FThreadProcessMessages.WaitFor;
end;

procedure TDispatcher.Terminate;
begin
  FThreadProcessMessages.Terminate;
end;

procedure TDispatcher.Post(const AMessage: TMessage);
begin
  Debug({$I %FILE%}, {$I %LINE%}, Format('Dispatcher Post: %s', [
    AMessage.Channel
  ]));
  FThreadProcessMessages.MessagesCriticalSection.Acquire;
  try
    FMessageList.Add(AMessage);
  finally
    FThreadProcessMessages.MessagesCriticalSection.Release;
  end;
end;

end.

