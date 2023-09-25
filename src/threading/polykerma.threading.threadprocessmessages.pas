unit PolyKerma.Threading.ThreadProcessMessages;

{$mode ObjFPC}{$H+}

interface

uses
{$IFDEF FPC_DOTTEDUNITS}
  System.Classes
{$ELSE FPC_DOTTEDUNITS}
  Classes
{$ENDIF FPC_DOTTEDUNITS}
, contnrs
, SyncObjs
, PolyKerma.Logging
, PolyKerma.Dispatching.Message
;

type
{ TProcedureProcessMessages }
  TProcedureProcessMessages = procedure (const AMessage: TMessage) of object;

{ TThreadProcessMessages }
  TThreadProcessMessages = class(TThread)
  private
    FProcedureProcessMessages: TProcedureProcessMessages;
    FListCriticalSection: TCriticalSection;
    FMessageList: TFPObjectList;
  protected
    procedure Execute; override;
  public
    constructor Create(
      const AProcedureProcessMessages: TProcedureProcessMessages;
      const AMessageList: TFPObjectList;
      const CreateSuspended: Boolean
    );
    destructor Destroy; override;
  published
  end;
  TThreadProcessingMessagesClass = class of TThreadProcessMessages;

implementation

{ TThreadProcessMessages }

constructor TThreadProcessMessages.Create(
  const AProcedureProcessMessages: TProcedureProcessMessages;
  const AMessageList: TFPObjectList;
  const CreateSuspended: Boolean
);
begin
  Debug({$I %FILE%}, {$I %LINE%}, 'Thread Process Messages Create');
  FProcedureProcessMessages:= AProcedureProcessMessages;
  FListCriticalSection:= TCriticalSection.Create;
  FMessageList:= AMessageList;
  inherited Create(CreateSuspended);
end;

destructor TThreadProcessMessages.Destroy;
begin
  Debug({$I %FILE%}, {$I %LINE%}, 'Thread Process Messages Destroy');
  FListCriticalSection.Free;
  inherited Destroy;
end;

procedure TThreadProcessMessages.Execute;
var
  message: TMessage;
begin
  Debug({$I %FILE%}, {$I %LINE%}, 'Thread Process Messages Execute');
  while not Terminated do
  begin
    FListCriticalSection.Acquire;
    try
      if FMessageList.Count > 0 then
      begin
        message:= FMessageList[0] as TMessage;
        FProcedureProcessMessages(message);
        message:= nil;
        FMessageList.Delete(0);
      end;
      Sleep(1);
    finally
      FListCriticalSection.Release;
    end;
  end;
end;

end.

