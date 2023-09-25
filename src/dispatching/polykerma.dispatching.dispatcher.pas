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
    FMessagesCriticalSection: TCriticalSection;
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
  FMessagesCriticalSection:= TCriticalSection.Create;
  FMessageList:= TFPObjectList.Create;
  FMessageList.OwnsObjects:= True;
  // Channels
  FChannelsCriticalSection:= TCriticalSection.Create;
  FChannelList:= TFPHashObjectList.Create(True);
  FChannelList.OwnsObjects:= True;
  // Message Thread
  FThreadProcessMessages:= TThreadProcessMessages.Create(
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
  FMessagesCriticalSection.Free;
  inherited Destroy;
end;

procedure TDispatcher.ProcessMessage(const AMessage: TMessage);
begin
  Debug({$I %FILE%}, {$I %LINE%}, Format('Dispatcher Process Message: %s', [
    AMessage.Channel
  ]));
  //
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
      Error({$I %FILE%}, {$I %LINE%}, 'Dispatcher Register');
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
  FMessageList.Add(AMessage);
end;

end.

