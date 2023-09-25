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
//, contnrs
, PolyKerma.Logging
, PolyKerma.Dispatching.Dispatcher.Interfaces
, PolyKerma.Dispatching.Message.Interfaces
, PolyKerma.Modules.Interfaces
, PolyKerma.Threading.Interfaces
, PolyKerma.Threading.ThreadProcessMessages
;

type
{ TInterfacedDispatcher }
  TInterfacedDispatcher = class(TInterfacedObject, IDispatcher)
  private
    FMessageList: IInterfaceList;
    FThreadProcessMessages: IThreadProcessMessages;

    procedure ProcessMessage(const AMessage: IMessage);
  protected
  public
    constructor Create;
    destructor Destroy; override;

    procedure Post(const AMessage: IMessage);
    function Register(const AChannel: String; const AModule: IModule): Boolean;
    procedure Run(const WaitFor: Boolean);
  published
  end;
  TInterfacedDispatcherClass = class of TInterfacedDispatcher;

implementation

{ TInterfacedDispatcher }

constructor TInterfacedDispatcher.Create;
begin
  Debug({$I %FILE%}, {$I %LINE%}, 'Dispatcher Create');
  FMessageList:= TInterfaceList.Create;
  FThreadProcessMessages:= TInterfacedThreadProcessingMessages.Create(
    @ProcessMessage,
    FMessageList,
    False
  );
end;

destructor TInterfacedDispatcher.Destroy;
begin
  Debug({$I %FILE%}, {$I %LINE%}, 'Dispatcher Destroy');
  FThreadProcessMessages.Terminate;
  FThreadProcessMessages.WaitFor;
  inherited Destroy;
end;

procedure TInterfacedDispatcher.ProcessMessage(const AMessage: IMessage);
begin
  Debug({$I %FILE%}, {$I %LINE%}, Format('Dispatcher Process Message: %s', [
    AMessage.Channel
  ]));
  //
end;

function TInterfacedDispatcher.Register(const AChannel: String;
  const AModule: IModule): Boolean;
begin
  Debug({$I %FILE%}, {$I %LINE%}, 'Dispatcher Register');
  Result:= false;
end;

procedure TInterfacedDispatcher.Run(const WaitFor: Boolean);
begin
  Debug({$I %FILE%}, {$I %LINE%}, 'Dispatcher Run');
  if WaitFor then FThreadProcessMessages.WaitFor;
end;

procedure TInterfacedDispatcher.Post(const AMessage: IMessage);
begin
  Debug({$I %FILE%}, {$I %LINE%}, Format('Dispatcher Post: %s', [
    AMessage.Channel
  ]));
  FMessageList.Add(AMessage);
end;

end.

