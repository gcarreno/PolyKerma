unit PolyKerma.Threading.ThreadProcessMessages;

{$mode ObjFPC}{$H+}

interface

uses
{$IFDEF FPC_DOTTEDUNITS}
  System.Classes
{$ELSE FPC_DOTTEDUNITS}
  Classes
{$ENDIF FPC_DOTTEDUNITS}
, PolyKerma.Logging
, PolyKerma.Dispatching.Message.Interfaces
, PolyKerma.Threading.Interfaces
, PolyKerma.Threading.Thread
;

type
{ TProcedureProcessMessages }
  TProcedureProcessMessages = procedure (const AMessage: IMessage) of object;

{ TInterfacedThreadProcessingMessages }
  TInterfacedThreadProcessingMessages = class(
    TInterfacedThread,
    IThreadProcessMessages
  )
  private
    FProcedureProcessMessages: TProcedureProcessMessages;
    FMessageList: IInterfaceList;
  protected
    procedure Execute; override;
  public
    constructor Create(
      const AProcedureProcessMessages: TProcedureProcessMessages;
      const AMessageList: IInterfaceList;
      const CreateSuspended: Boolean
    );
    destructor Destroy; override;
  published
  end;
  TInterfacedThreadProcessingMessagesClass =
    class of TInterfacedThreadProcessingMessages;

implementation

{ TInterfacedThreadProcessingMessages }

constructor TInterfacedThreadProcessingMessages.Create(
  const AProcedureProcessMessages: TProcedureProcessMessages;
  const AMessageList: IInterfaceList;
  const CreateSuspended: Boolean
);
begin
  Debug({$I %FILE%}, {$I %LINE%}, 'Thread Process Messages Create');
  FProcedureProcessMessages:= AProcedureProcessMessages;
  FMessageList:= AMessageList;
  inherited Create(CreateSuspended);
end;

destructor TInterfacedThreadProcessingMessages.Destroy;
begin
  Debug({$I %FILE%}, {$I %LINE%}, 'Thread Process Messages Destroy');
  inherited Destroy;
end;

procedure TInterfacedThreadProcessingMessages.Execute;
var
  message: IMessage;
begin
  Debug({$I %FILE%}, {$I %LINE%}, 'Thread Process Messages Execute');
  while not Terminated do
  begin
    FMessageList.Lock;
    try
      if FMessageList.Count > 0 then
      begin
        message:= FMessageList[0] as IMessage;
        FProcedureProcessMessages(message);
        message:= nil;
        FMessageList.Delete(0);
      end;
      Sleep(1);
    finally
      FMessageList.Unlock;
    end;
  end;
end;

end.

