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
, contnrs
, PolyKerma.Logging
, PolyKerma.Dispatching.Message
, PolyKerma.Threading.ThreadProcessMessages
;

type
{ TModule }
  TModule = class(TObject)
  private
    FDispatcher: TObject;
    FMessageList: TFPObjectList;
    FThreadProcessMessages: TThreadProcessMessages;
    FName: String;

  protected
    procedure ProcessMessage(const AMessage: TMessage); virtual;
  public
    constructor Create(const ADispatcher: TObject);
    destructor Destroy; override;

    procedure Receive(const AMessage: TMessage);

    property Name: String
      read FName;
  published
  end;
  TModuleClass = class of TModule;

implementation

{uses
  PolyKerma.Dispatching.Dispatcher
;}

{ TDispatcher }

constructor TModule.Create(const ADispatcher: TObject);
begin
  FName:= 'Base Module';
  Debug({$I %FILE%}, {$I %LINE%}, Format('Module Create: "%s"', [ FName ]));
  // Dispatcher
  FDispatcher:= ADispatcher;
  // Messages
  FMessageList:= TFPObjectList.Create;
  FMessageList.OwnsObjects:= True;
  // Message Thread
  FThreadProcessMessages:= TThreadProcessMessages.Create(
    @ProcessMessage,
    FMessageList,
    True
  );
  FThreadProcessMessages.FreeOnterminate:= False;
  FThreadProcessMessages.Start;
end;

destructor TModule.Destroy;
begin
  Debug({$I %FILE%}, {$I %LINE%}, Format('Module Destroy: "%s"', [ FName ]));
  // Message Thread
  FThreadProcessMessages.Terminate;
  FThreadProcessMessages.WaitFor;
  FThreadProcessMessages.Free;
  // Messages
  FMessageList.Clear;
  FMessageList.Free;
  inherited Destroy;
end;

procedure TModule.ProcessMessage(const AMessage: TMessage);
begin
  Debug({$I %FILE%}, {$I %LINE%}, Format('Module Process Message "%s": %s', [
    FName,
    AMessage.Channel
  ]));
end;

procedure TModule.Receive(const AMessage: TMessage);
begin
  Debug({$I %FILE%}, {$I %LINE%}, Format('Module Receive Message "%s": %s', [
    FName,
    AMessage.Channel
  ]));
  FMessageList.Add(AMessage);
end;

end.

