unit PolyKerma.Modules.Module;

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
, PolyKerma.Logging
, PolyKerma.Dispatching
, PolyKerma.Dispatching.Dispatcher.Interfaces
, PolyKerma.Dispatching.Message.Interfaces
, PolyKerma.Modules.Interfaces
, PolyKerma.Threading.Interfaces
, PolyKerma.Threading.ThreadProcessMessages
;

type
{ TInterfacedModule }
  TInterfacedModule = class(TInterfacedObject, IModule)
  private
    FDispatcher: IDispatcher;
    FMessageList: IInterfaceList;
    FThreadProcessMessages: IThreadProcessMessages;

    procedure ProcessMessage(const AMessage: IMessage);
    procedure Receive(const AMessage: IMessage);
  protected
  public
    constructor Create(const ADispatcher: IDispatcher);
    destructor Destroy; override;

  published
  end;
  TInterfacedModuleClass = class of TInterfacedModule;

implementation

{ TDispatcher }

constructor TInterfacedModule.Create(const ADispatcher: IDispatcher);
begin
  Debug({$I %FILE%}, {$I %LINE%}, 'Module Create');
  FDispatcher:= ADispatcher;
  FMessageList:= TInterfaceList.Create;
  FThreadProcessMessages:= TInterfacedThreadProcessingMessages.Create(
    @ProcessMessage,
    FMessageList,
    False
  );
  // Register
  FDispatcher.Register(cChannelModuleIn, Self);
end;

destructor TInterfacedModule.Destroy;
begin
  Debug({$I %FILE%}, {$I %LINE%}, 'Module Destroy');
  FThreadProcessMessages.Terminate;
  FThreadProcessMessages.WaitFor;
  inherited Destroy;
end;

procedure TInterfacedModule.ProcessMessage(const AMessage: IMessage);
begin
  Debug({$I %FILE%}, {$I %LINE%}, Format('Module Process Message: %s', [
    AMessage.Channel
  ]));
  //
end;

procedure TInterfacedModule.Receive(const AMessage: IMessage);
begin
  Debug({$I %FILE%}, {$I %LINE%}, Format('Module Receive Message: %s', [
    AMessage.Channel
  ]));
  FMessageList.Add(AMessage);
end;

end.



