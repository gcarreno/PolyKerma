unit PolyKerma.Threading.ThreadProcessMessages;

{$mode ObjFPC}{$H+}

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
    FName: String;
    FProcedureProcessMessages: TProcedureProcessMessages;
    FMessagesCriticalSection: TCriticalSection;
    FMessageList: TFPObjectList;
  protected
    procedure Execute; override;
  public
    constructor Create(
      const AName: String;
      const AProcedureProcessMessages: TProcedureProcessMessages;
      const AMessageList: TFPObjectList;
      const CreateSuspended: Boolean
    );
    destructor Destroy; override;

    property Name: String
      read FName;
    property MessagesCriticalSection: TCriticalSection
      read FMessagesCriticalSection;
  published
  end;
  TThreadProcessingMessagesClass = class of TThreadProcessMessages;

implementation

{ TThreadProcessMessages }

constructor TThreadProcessMessages.Create(
  const AName: String;
  const AProcedureProcessMessages: TProcedureProcessMessages;
  const AMessageList: TFPObjectList;
  const CreateSuspended: Boolean);
begin
  Debug({$I %FILE%}, {$I %LINE%}, Format('Thread Process Messages Create(%s): "%s"',[ FName, AName ]));
  FName:= AName;
  FProcedureProcessMessages:= AProcedureProcessMessages;
  FMessagesCriticalSection:= TCriticalSection.Create;
  FMessageList:= AMessageList;
  inherited Create(CreateSuspended);
end;

destructor TThreadProcessMessages.Destroy;
begin
  Debug({$I %FILE%}, {$I %LINE%}, Format('Thread Process Messages Destroy(%s)', [ FName ]));
  FMessagesCriticalSection.Free;
  inherited Destroy;
end;

procedure TThreadProcessMessages.Execute;
var
  message: TMessage;
begin
  Debug({$I %FILE%}, {$I %LINE%}, Format('Thread Process Messages Execute(%s): Enter', [ FName ]));
  while not Terminated do
  begin
    message:= nil;
    FMessagesCriticalSection.Acquire;
    //Debug({$I %FILE%}, {$I %LINE%}, 'Thread Process Messages Execute: Lock Acquired');
    try
      if FMessageList.Count > 0 then
      begin
        Debug({$I %FILE%}, {$I %LINE%},
          Format('Thread Process Messages Count(%s) <: %d', [ FName, FMessageList.Count ])
        );
        message:= (FMessageList.First as TMessage).Copy;
        FMessageList.Delete(FMessageList.IndexOf(FMessageList.First));
        Debug({$I %FILE%}, {$I %LINE%},
          Format('Thread Process Messages Count(%s) >: %d', [ FName, FMessageList.Count ])
        );
      end;
    finally
      FMessagesCriticalSection.Release;
      //Debug({$I %FILE%}, {$I %LINE%}, 'Thread Process Messages Execute: Lock Released');
    end;
    //Debug({$I %FILE%}, {$I %LINE%}, 'Thread Process Messages Execute: Sending to ProcessMessage');
    if Assigned(message) then FProcedureProcessMessages(message);
    message.Free;
    { #todo -ogcarreno -cPolyKerma.Core : Replace this Sleep(1) with a signal trigerred from the Post }
    Sleep(1);
  end;
  Debug({$I %FILE%}, {$I %LINE%}, Format('Thread Process Messages Execute(%s): Exit', [ FName ]));
end;

end.

